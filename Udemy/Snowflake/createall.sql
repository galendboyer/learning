
CREATE WAREHOUSE FIRST_WAREHOUSE 
WITH
WAREHOUSE_SIZE = XSMALL
MIN_CLUSTER_COUNT = 1
MAX_CLUSTER_COUNT = 3
AUTO_SUSPEND = 60
AUTO_RESUME = TRUE
SCALING_POLICY = 'Economy'
INITIALLY_SUSPENDED = TRUE
COMMENT = 'This is our 2nd warehouse'
;

CREATE DATABASE FIRST_DATABASE;

CREATE SCHEMA FIRST_SCHEMA;

CREATE TABLE first_table (
   first_column INT,
    second_column TEXT
    -- supported types: https://docs.snowflake.com/en/sql-reference/intro-summary-data-types
    )
;
