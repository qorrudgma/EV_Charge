package com.boot.spark;

import java.io.File;
import java.io.IOException;

import org.apache.spark.ml.regression.LinearRegressionModel;
import org.apache.spark.sql.Dataset;
import org.apache.spark.sql.Row;
import org.apache.spark.sql.SparkSession;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class LinearRegressionResult {

	// 새 모델 생성 후 학습과 예측 둘다 수행
	public Dataset<Row> executeLinearRegression(JsonNode inputJson) throws Exception {
		ObjectMapper mapper = new ObjectMapper();

		// 학습할 데이터가 담긴 json 파일은 여기서 변경
		String learningJsonStr = new LogisticRegressionResult().JsonToStringConverter("station_charge_data.json");
		JsonNode learningJson = mapper.readTree(learningJsonStr);

		SparkSession spark = new SparkSessionGenerator().makeSparkSession("Reservatrion_analize", "local[*]");

		MachineLearning ML = new MachineLearning();
		LinearRegressionModel model = ML.LinearMachineGenerator(spark, learningJson);

		Dataset<Row> predictions = ML.LinearResultRow(model, spark, inputJson);
		predictions.show(false);

		spark.close();

		return predictions;
	}

	// 기존 모델 이용해서 예측 수행
	public Dataset<Row> existingLinearModel(LinearRegressionModel model, JsonNode inputJson) {
		SparkSession spark = new SparkSessionGenerator().makeSparkSession("Reservatrion_analize", "local[*]");

		MachineLearning ML = new MachineLearning();

		Dataset<Row> predictions = ML.LinearResultRow(model, spark, inputJson);
		predictions.show(false);
		log.info("선형 회귀 모델 예측 완료, 결과 {}건", predictions.count());

		spark.close();

		return predictions;
	}

	public String JsonToStringConverter(String filename) throws IOException {
		// 1. JSON 파일 경로 (예: learning_data.json)
		File jsonFile = new File("src/main/resources/json/" + filename);

		// 2. ObjectMapper로 읽기
		ObjectMapper mapper = new ObjectMapper();
		JsonNode jsonNode = mapper.readTree(jsonFile);

		// 3. JsonNode를 문자열로 변환 (줄바꿈 제거해서 한 줄로)
		String JsonStr = jsonNode.toString();

		return JsonStr;
	}

}
