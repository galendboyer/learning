
drop table if exists demo_db.fire_service_calls_tbl;
drop view if exists demo_db.fire_service_calls_view;
drop database if exists demo_db;
%fs rm -r dbfs:/user/hive/warehouse/demo_db.db

%sql
create database if not exists demo_db;

%sql
create table if not exists demo_db.fire_service_calls_tbl(
  CallNumber integer,
  UnitID string,
  IncidentNumber integer,
  CallType string,
  CallDate date,
  WatchDate date,
  CallFinalDisposition string,
  AvailableDtTm string,
  Address string,
  City string,
  ZipcodeofIncident integer,
  Battalion string,
  StationArea string,
  Box string,
  OrigPriority string,
  Priority string,
  FinalPriority integer,
  ALSUnit boolean,
  CallTypeGroup string,
  NumAlarms integer,
  UnitType string,
  Unitsequenceincalldispatch integer,
  FirePreventionDistrict string,
  SupervisorDistrict string,
  Neighborhood string,
  Location string,
  RowID string,
  Delay double
) using parquet;

-- insert into demo_db.fire_service_calls_tbl
-- values(1234,null,null,null,null,null,null,null,null,null,null
-- ,null,null,null,null,null,null,null,null,null,null,null,null
-- ,null,null,null,null,null);


%sql
truncate table demo_db.fire_service_calls_tbl;

fire_df = spark.read \
      .format("csv") \
      .option("header", "true") \
      .option("inferSchema", "true") \
      .load("/databricks-datasets/learning-spark-v2/sf-fire/sf-fire-calls.csv");
spark.catalog.dropGlobalTempView("fire_service_calls_view")
fire_df.createGlobalTempView("fire_service_calls_view");

insert into demo_db.fire_service_calls_tbl
select * from global_temp.fire_service_calls_view;
select * from demo_db.fire_service_calls_tbl;

