/*==========================================================
* 파일명     : LogisticRegressionResult.java
* 작성자     : 임진우
* 작성일자   : 2025-05-21
* 설명       : 로지스틱 회귀 구현

* 수정 이력 :
* 날짜         수정자       내용
* --------   ----------   ------------------------- 
* 2025-05-20   임진우       완성
============================================================*/

package com.boot.spark;

import java.io.File;
import java.io.IOException;

import org.apache.spark.ml.classification.LogisticRegressionModel;
import org.apache.spark.sql.Dataset;
import org.apache.spark.sql.Row;
import org.apache.spark.sql.SparkSession;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class LogisticRegressionResult {

	public Dataset<Row> executeLogRegression(JsonNode inputJson) throws Exception {
		ObjectMapper mapper = new ObjectMapper();

		// 학습할 데이터가 담긴 json 파일은 여기서 변경
		String learningJsonStr = new LogisticRegressionResult().JsonToStringConverter("station_charge_data.json");
		JsonNode learningJson = mapper.readTree(learningJsonStr);

		// 스파크 세션객체 생성
		SparkSession spark = new SparkSessionGenerator().makeSparkSession("station_analize", "local[*]");

		// 스파크 객체와 학습데이터로 학습된 모델 생성
		MachineLearning ML = new MachineLearning();
		LogisticRegressionModel model = ML.LogMachineGenerator(spark, learningJson);

		// 예상 결과치 도출
		Dataset<Row> predictions = ML.LogResultRow(model, spark, inputJson);
		predictions.show(false);
		log.info("로지스틱 회귀 모델 예측 완료, 결과 {}건", predictions.count());

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
