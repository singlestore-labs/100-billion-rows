drop database if exists tripdata;
create database tripdata;
use tripdata;

source credentials.sql;

CREATE TABLE trips (
  vehicle_id int,
  miles int,
  duration_minutes int,

  sort key (vehicle_id, miles),
  shard ()
);

create or replace pipeline trips as
  load data link aws_s3 'ooc-scratchpad-us-east-1/tripdata/'
  into table trips;

-- start pipeline trips foreground limit 1 batches;