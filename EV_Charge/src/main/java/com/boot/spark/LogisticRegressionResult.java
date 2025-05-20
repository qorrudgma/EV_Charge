package com.boot.spark;

import java.util.ArrayList;
import java.util.List;

import org.apache.spark.ml.classification.LogisticRegression;
import org.apache.spark.ml.classification.LogisticRegressionModel;
import org.apache.spark.ml.linalg.VectorUDT;
import org.apache.spark.ml.linalg.Vectors;
import org.apache.spark.sql.Dataset;
import org.apache.spark.sql.Row;
import org.apache.spark.sql.RowFactory;
import org.apache.spark.sql.SparkSession;
import org.apache.spark.sql.types.DataTypes;
import org.apache.spark.sql.types.Metadata;
import org.apache.spark.sql.types.StructField;
import org.apache.spark.sql.types.StructType;

public class LogisticRegressionResult {

	public static void main(String[] args) {
		SparkSession spark = SparkSession.builder().appName("Java Logistic Regression Result").master("local[*]")
				.getOrCreate(); // 로컬모드

		// 학습 데이터 생성 (label, features)
		List<Row> data = new ArrayList<>();
		data.add(RowFactory.create(1.0, Vectors.dense(0.0, 1.1, 0.1)));
		data.add(RowFactory.create(0.0, Vectors.dense(2.0, 1.0, -1.0)));
		data.add(RowFactory.create(0.0, Vectors.dense(2.0, 1.3, 1.0)));
		data.add(RowFactory.create(1.0, Vectors.dense(0.0, 1.2, -0.5)));

		// 학습 스키마 설정
		StructType schema = new StructType(
				new StructField[] { new StructField("label", DataTypes.DoubleType, false, Metadata.empty()),
						new StructField("features", new VectorUDT(), false, Metadata.empty()) });

		Dataset<Row> training = spark.createDataFrame(data, schema);

		// 로지스틱 회귀 모델 생성 및 학습
		LogisticRegression lr = new LogisticRegression().setMaxIter(10).setRegParam(0.01);

		LogisticRegressionModel model = lr.fit(training);

		// 모델 요약 정보 출력
		System.out.println("Coefficients: " + model.coefficients());
		System.out.println("Intercept: " + model.intercept());

		// 테스트 데이터 생성
		List<Row> testData = new ArrayList<>();
		testData.add(RowFactory.create(Vectors.dense(-1.0, 1.5, 1.3)));
		testData.add(RowFactory.create(Vectors.dense(3.0, 2.0, -0.1)));
		Dataset<Row> test = spark.createDataFrame(testData, new StructType(
				new StructField[] { new StructField("features", new VectorUDT(), false, Metadata.empty()) }));

		// 예측 수행
		Dataset<Row> predictions = model.transform(test);
		predictions.show(false);

		spark.stop();
	}
}
