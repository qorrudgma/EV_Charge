/*==========================================================
* 파일명     : MachineLearning.java
* 작성자     : 임진우
* 작성일자   : 2025-05-21
* 설명       : 로지스틱 회귀에 필요한 머신러닝 메소드들 모음

* 수정 이력 :
* 날짜         수정자       내용
* --------   ----------   ------------------------- 
* 2025-05-20   임진우       로지스틱 회귀 메소드 작성 완료
============================================================*/

package com.boot.spark;

import java.util.ArrayList;
import java.util.List;

import org.apache.spark.ml.classification.LogisticRegression;
import org.apache.spark.ml.classification.LogisticRegressionModel;
import org.apache.spark.ml.feature.VectorAssembler;
import org.apache.spark.ml.linalg.VectorUDT;
import org.apache.spark.ml.linalg.Vectors;
import org.apache.spark.ml.regression.LinearRegression;
import org.apache.spark.ml.regression.LinearRegressionModel;
import org.apache.spark.sql.Dataset;
import org.apache.spark.sql.Row;
import org.apache.spark.sql.RowFactory;
import org.apache.spark.sql.SparkSession;
import org.apache.spark.sql.types.DataTypes;
import org.apache.spark.sql.types.Metadata;
import org.apache.spark.sql.types.StructField;
import org.apache.spark.sql.types.StructType;

import com.fasterxml.jackson.databind.JsonNode;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class MachineLearning {

// 로지스틱 회귀 ================================================================================

	// 로지스틱 회귀 : 학습된 모델 반환
	public LogisticRegressionModel LogMachineGenerator(SparkSession spark, JsonNode learningJson) {

		List<Row> learningDataSet = makeLearningData(learningJson);

		StructType schema = new StructType(
				new StructField[] { new StructField("label", DataTypes.DoubleType, false, Metadata.empty()),
						new StructField("features", new VectorUDT(), false, Metadata.empty()) });

		Dataset<Row> training = spark.createDataFrame(learningDataSet, schema);

		LogisticRegressionModel model = makeLogModel(training);

		return model;
	}

	// 로지스틱 회귀 : 모델 생성 및 학습
	public LogisticRegressionModel makeLogModel(Dataset<Row> training) {
		LogisticRegression lr = new LogisticRegression().setMaxIter(2000).setRegParam(0.01);
		LogisticRegressionModel model = lr.fit(training);
		log.info("학습데이터로 맞춤모델 생성 makeModel()");
		return model;
	}

	// 로지스틱 회귀 : 학습된 모델로 예상치 반환(새로운 거 기존 거 둘 다 가능)
	public Dataset<Row> LogResultRow(LogisticRegressionModel model, SparkSession spark, JsonNode inputJson) {
		List<Row> inputDataSet = makeInputData(inputJson);

		Dataset<Row> test = spark.createDataFrame(inputDataSet, new StructType(
				new StructField[] { new StructField("features", new VectorUDT(), false, Metadata.empty()) }));

		Dataset<Row> predictions = model.transform(test);
		predictions.select("features", "prediction", "probability").show(20, false);

		log.info("@# 로지스틱 회귀 : 예상결과 반환 완료!!");

		return predictions;
	}

// 선형 회귀 ================================================================================

	// 선형 회귀 : 학습된 모델 반환
	public LinearRegressionModel LinearMachineGenerator(SparkSession spark, JsonNode learningJson) {

		List<Row> learningDataSet = makeLearningData(learningJson);

		StructType schema = new StructType(
				new StructField[] { new StructField("label", DataTypes.DoubleType, false, Metadata.empty()),
						new StructField("features", new VectorUDT(), false, Metadata.empty()) });

		Dataset<Row> training = spark.createDataFrame(learningDataSet, schema);

		LinearRegressionModel model = makeLinearModel(training);

		return model;
	}

	// 선형 회귀 : 모델 생성 및 학습
	public LinearRegressionModel makeLinearModel(Dataset<Row> training) {
		VectorAssembler assembler = new VectorAssembler().setInputCols(new String[] { "feature" })
				.setOutputCol("features");

		Dataset<Row> vectorDf = assembler.transform(training).select("label", "features");

		LinearRegression lr = new LinearRegression().setLabelCol("label").setFeaturesCol("features");

		LinearRegressionModel model = lr.fit(vectorDf);

		log.info("학습데이터로 맞춤모델 생성 makeModel()");
		return model;
	}

	// 선형 회귀 : 학습된 모델로 예상치 반환(새로운 거 기존 거 둘 다 가능)
	public Dataset<Row> LinearResultRow(LinearRegressionModel model, SparkSession spark, JsonNode inputJson) {
		List<Row> inputDataSet = makeInputData(inputJson);

		Dataset<Row> test = spark.createDataFrame(inputDataSet, new StructType(
				new StructField[] { new StructField("features", new VectorUDT(), false, Metadata.empty()) }));

		Dataset<Row> predictions = model.transform(test);
		predictions.select("features", "prediction", "probability").show(20, false);

		log.info("@# 선형 회귀 : 예상결과 반환 완료!!");

		return predictions;
	}

// 데이터 세팅 ================================================================================		
	// 학습데이터 세팅
	public List<Row> makeLearningData(JsonNode jNode) {
		log.info("@# Start makeLearningData()----");
		List<Row> learningData = new ArrayList<>();

		for (int i = 0; i < jNode.size(); i++) {
			JsonNode rowNode = jNode.get(i);
			double label = rowNode.get(0).asDouble();
			double[] features = new double[rowNode.size() - 1];

			for (int k = 1; k < rowNode.size(); k++) {
				features[k - 1] = rowNode.get(k).asDouble();
			}
			learningData.add(RowFactory.create(label, Vectors.dense(features)));
			log.info(i + "번째 노드 학습데이터 저장 완료");
		}

		return learningData;
	}

	// 입력데이터 세팅
	public List<Row> makeInputData(JsonNode jNode) {
		log.info("@# Start makeInputData()----");
		List<Row> inputData = new ArrayList<>();

		for (int i = 0; i < jNode.size(); i++) {
			JsonNode rowNode = jNode.get(i);
			double[] values = new double[rowNode.size()];

			for (int k = 0; k < rowNode.size(); k++) {
				values[k] = rowNode.get(k).asDouble(); // 더 안전
			}

			inputData.add(RowFactory.create(Vectors.dense(values)));
			log.info(i + "번째 노드 입력데이터 저장 완료");
		}

		return inputData;
	}

}
