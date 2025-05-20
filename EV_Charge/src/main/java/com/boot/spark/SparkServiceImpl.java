package com.boot.spark;

import java.util.ArrayList;
import java.util.List;

import org.apache.spark.api.java.JavaRDD;
import org.apache.spark.api.java.JavaSparkContext;
import org.apache.spark.sql.Dataset;
import org.apache.spark.sql.Row;
import org.apache.spark.sql.SparkSession;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.databind.JsonNode;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service("SparkService")
public class SparkServiceImpl implements SparkService {

	private SparkSession spark;
	private JavaSparkContext sparkContext;

	public SparkServiceImpl(SparkSession spark) {
		this.spark = spark;
		this.sparkContext = new JavaSparkContext(spark.sparkContext());
	}

	@Override
	public void JSONtest(JsonNode jsonNode) {
		List<String> jsonElements = new ArrayList<>();
		jsonNode.forEach(node -> jsonElements.add(node.toString()));

		JavaRDD<String> rdd = sparkContext.parallelize(jsonElements);

		Dataset<Row> df = spark.read().json(rdd.rdd());
		df.show();
		df.printSchema();
	}
}
