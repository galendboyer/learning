df = (spark.read
      .format("csv")
      .option("header", "true")
      .option("inferSchema", "true")
      .load("/FileStore/tables/sample_data/tmp.txt"))

display(df)      
