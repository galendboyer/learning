fire_df = spark.read \
      .format("csv") \
      .option("header", "true") \
      .option("inferSchema", "true") \
      .load("/databricks-datasets/learning-spark-v2/sf-fire/sf-fire-calls.csv");

fire_df = spark.read \
    .csv("/databricks-datasets/learning-spark-v2/sf-fire/sf-fire-calls.csv",
         header="true",
         inferSchema="true");

fire_df.show(10);
display(fire_df);
fire_df.createGlobalTempView("fire_service_calls_view");

select * from global_temp.fire_service_calls_view;
