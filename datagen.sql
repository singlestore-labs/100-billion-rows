drop database if exists datagen;
create database datagen;
use datagen;

create rowstore table t (i int auto_increment primary key);
create table numbers(i tinyint, shard());

delimiter //
create or replace procedure ensure_all_partitions_nonempty () as
declare
  q_num_partitions query(c int) = select count(*) from information_schema.distributed_partitions where database_name = "datagen" and role = "Master";
  num_partitions int = scalar(q_num_partitions);
  q_num_nonempty_partitions query(c int) = select coalesce(sum(x), 0) as c from (select 1 as x from t group by partition_id());
begin
  while scalar(q_num_nonempty_partitions) < num_partitions loop
    insert into t select * from (select null from t union all select null);
  end loop;
end //

create or replace procedure fill_table (target_size bigint) as
declare
  q query(c bigint) = select count(*) as c from numbers;
begin
  truncate table numbers;
  insert into numbers select max(t.i) from t group by partition_id();
  while scalar(q) < target_size loop
    insert into numbers select 1 from numbers;
  end loop;
end //
delimiter ;

-- setup table t
call ensure_all_partitions_nonempty();

-- at least 1b rows in the numbers table
call fill_table(1000000000);

select partition_id(), count(*) from numbers group by 1 order by 1;
select count(distinct partition_id()), format(count(*),2) from numbers;

create view distances as (
  select table_col as miles
  from table([1, 5, 10, 25, 50, 75, 100, 125, 150, 175])
);

-- generates count(numbers) * 10 rows
create or replace function trips(vehicle_id int) returns table as return (
  select
    vehicle_id,
    miles,
    -- using vehicle_id as time_for_miles
    (miles * vehicle_id) as duration
  FROM distances
  STRAIGHT_JOIN numbers
);