source credentials.sql;

select * from trips(1) into link aws_s3 'ooc-scratchpad-us-east-1/tripdata/vehicle_1' with compression;
select * from trips(2) into link aws_s3 'ooc-scratchpad-us-east-1/tripdata/vehicle_2' with compression;
select * from trips(3) into link aws_s3 'ooc-scratchpad-us-east-1/tripdata/vehicle_3' with compression;
select * from trips(4) into link aws_s3 'ooc-scratchpad-us-east-1/tripdata/vehicle_4' with compression;
select * from trips(5) into link aws_s3 'ooc-scratchpad-us-east-1/tripdata/vehicle_5' with compression;
select * from trips(6) into link aws_s3 'ooc-scratchpad-us-east-1/tripdata/vehicle_6' with compression;
select * from trips(7) into link aws_s3 'ooc-scratchpad-us-east-1/tripdata/vehicle_7' with compression;
select * from trips(8) into link aws_s3 'ooc-scratchpad-us-east-1/tripdata/vehicle_8' with compression;
select * from trips(9) into link aws_s3 'ooc-scratchpad-us-east-1/tripdata/vehicle_9' with compression;
select * from trips(10) into link aws_s3 'ooc-scratchpad-us-east-1/tripdata/vehicle_10' with compression;