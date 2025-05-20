package com.boot;

import java.util.Arrays;
import java.util.List;

import org.apache.spark.SparkConf;
import org.apache.spark.api.java.JavaRDD;
import org.apache.spark.api.java.JavaSparkContext;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class SparkApp {
	public static void main(String[] args) {
        SpringApplication.run(SparkApp.class, args);

        SparkConf conf = new SparkConf()
                .setAppName("SpringBootSparkApp")
                .setMaster("local[*]"); // 클러스터일 경우 spark://... 으로 변경

        JavaSparkContext sc = new JavaSparkContext(conf);

        List<String> data = Arrays.asList("one", "two", "three");
        JavaRDD<String> rdd = sc.parallelize(data);
        long count = rdd.count();
        System.out.println("RDD Count: " + count);

        sc.close();
    }

}
