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

	// time 문자열을 숫자로 변환하는 함수 (예: "13:00" -> 13.0)
	public double timeToDouble(String timeStr) {
		try {
			String[] parts = timeStr.split(":");
			return Double.parseDouble(parts[0]);
		} catch (Exception e) {
			log.warn("timeToDouble 변환 실패: " + timeStr);
			return 0.0;
		}
	}
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
		// VectorAssembler 제거: training에는 이미 "features" 컬럼이 존재함
		LinearRegression lr = new LinearRegression().setLabelCol("label").setFeaturesCol("features");

		LinearRegressionModel model = lr.fit(training);

		log.info("학습데이터로 맞춤모델 생성 makeModel()");
		return model;
	}

	// 선형 회귀 : 학습된 모델로 예상치 반환(새로운 거 기존 거 둘 다 가능)
	public Dataset<Row> LinearResultRow(LinearRegressionModel model, SparkSession spark, JsonNode inputJson) {

		List<Row> inputRows = makeLinearInputData(inputJson);

		StructType schema = new StructType(
				new StructField[] { new StructField("features", new VectorUDT(), false, Metadata.empty()) });

		Dataset<Row> inputDataFrame = spark.createDataFrame(inputRows, schema);

		// VectorAssembler 제거!
		Dataset<Row> predictions = model.transform(inputDataFrame);

		return predictions;
	}

// 데이터 세팅 ================================================================================		
	// 학습데이터 세팅 (안전한 null 및 타입 체크 추가)
	public List<Row> makeLearningData(JsonNode jNode) {
		log.info("@# Start makeLearningData()----");
		List<Row> learningData = new ArrayList<>();

		for (int i = 0; i < jNode.size(); i++) {
			JsonNode rowNode = jNode.get(i);

			// "label" 필드가 존재하는지 체크
			if (!rowNode.has("label")) {
				log.warn(i + "번째 노드에 label 필드가 없습니다.");
				continue; // 이 노드는 건너뜀
			}
			double label = rowNode.get("label").asDouble();

			// 피처 배열 만들기 (label 제외하고 수치형 컬럼만)
			List<Double> featuresList = new ArrayList<>();

			// 필요한 피처 필드들 명시 (필요에 따라 조절)
			String[] featureKeys = { "lat", "lng", "charge_level", "detour_distance", "waiting_time", };

			boolean skipNode = false;
			for (String key : featureKeys) {
				if (!rowNode.has(key)) {
					log.warn(i + "번째 노드에 " + key + " 필드가 없습니다.");
					skipNode = true;
					break;
				}
				featuresList.add(rowNode.get(key).asDouble());
			}
			if (skipNode) {
				continue; // 필드 부족하면 이 노드 건너뜀
			}

			double[] features = featuresList.stream().mapToDouble(Double::doubleValue).toArray();

			learningData.add(RowFactory.create(label, Vectors.dense(features)));
			log.info(i + "번째 노드 학습데이터 저장 완료");
		}

		return learningData;
	}

	// 입력데이터 세팅 (안전한 null 및 타입 체크 추가)
	public List<Row> makeInputData(JsonNode jNode) {
		List<Row> inputData = new ArrayList<>();

		log.info("@# makeInputData() jNode =>" + jNode);

		// 단일 객체인 경우 처리
		if (!jNode.isArray()) {
			JsonNode rowNode = jNode;
			String[] featureKeys = { "lat", "lng", "charge_level", "detour_distance", "waiting_time" };

			boolean skipNode = false;
			List<Double> featuresList = new ArrayList<>();

			for (String key : featureKeys) {
				if (!rowNode.has(key) || !rowNode.get(key).isNumber()) {
					log.warn("단일 노드에 '" + key + "' 필드가 없거나 숫자가 아닙니다.");
					skipNode = true;
					break;
				}
				featuresList.add(rowNode.get(key).asDouble());
			}

			if (!skipNode) {
				double[] values = featuresList.stream().mapToDouble(Double::doubleValue).toArray();
				inputData.add(RowFactory.create(Vectors.dense(values)));
				log.info("단일 노드 입력데이터 저장 완료");
			}

			return inputData;
		}

		// 배열인 경우 (기존 코드)
		for (int i = 0; i < jNode.size(); i++) {
			JsonNode rowNode = jNode.get(i);
			if (rowNode == null || !rowNode.isObject()) {
				log.warn(i + "번째 노드가 JSON 객체가 아니거나 null입니다.");
				continue; // 스킵
			}

			String[] featureKeys = { "lat", "lng", "charge_level", "detour_distance", "waiting_time" };

			boolean skipNode = false;
			List<Double> featuresList = new ArrayList<>();

			for (String key : featureKeys) {
				if (!rowNode.has(key) || !rowNode.get(key).isNumber()) {
					log.warn(i + "번째 노드에 '" + key + "' 필드가 없거나 숫자가 아닙니다.");
					skipNode = true;
					break;
				}
				featuresList.add(rowNode.get(key).asDouble());
			}

			if (skipNode) {
				continue;
			}

			double[] values = featuresList.stream().mapToDouble(Double::doubleValue).toArray();

			inputData.add(RowFactory.create(Vectors.dense(values)));
			log.info(i + "번째 노드 입력데이터 저장 완료");
		}

		return inputData;
	}

	// 선형 회귀 학습데이터
	public List<Row> makeLinearLearningData(JsonNode jNode) {
		log.info("@# Start makeLearningData()----");
		List<Row> learningData = new ArrayList<>();

		String[] featureKeys = { "lat", "lng", "charge_level", "detour_distance", "waiting_time" };

		for (int i = 0; i < jNode.size(); i++) {
			JsonNode rowNode = jNode.get(i);

			if (!rowNode.has("label")) {
				log.warn(i + "번째 노드에 label 필드가 없습니다.");
				continue;
			}
			double label = rowNode.get("label").asDouble();

			List<Double> featuresList = new ArrayList<>();

			boolean skipNode = false;
			for (String key : featureKeys) {
				if (!rowNode.has(key)) {
					log.warn(i + "번째 노드에 " + key + " 필드가 없습니다.");
					skipNode = true;
					break;
				}
				if (!rowNode.get(key).isNumber()) {
					log.warn(i + "번째 노드의 " + key + " 필드가 숫자가 아닙니다.");
					skipNode = true;
					break;
				}
				featuresList.add(rowNode.get(key).asDouble());
			}

			if (skipNode) {
				continue;
			}

			if (!rowNode.has("time")) {
				log.warn(i + "번째 노드에 time 필드가 없습니다.");
				continue;
			}

			String timeStr = rowNode.get("time").asText();
			double timeFeature = timeToDouble(timeStr);
			featuresList.add(timeFeature);

			double[] features = featuresList.stream().mapToDouble(Double::doubleValue).toArray();

			learningData.add(RowFactory.create(label, Vectors.dense(features)));
			log.info(i + "번째 노드 학습데이터 저장 완료");
		}
		log.info("@# 선형회귀 학습데이터 =>" + learningData);
		return learningData;
	}

	// 선형회귀 입력데이터
	public List<Row> makeLinearInputData(JsonNode jNode) {
		List<Row> inputData = new ArrayList<>();
		log.info("@# makeLinearInputData() jNode =>" + jNode);

		// 'time' 제외된 feature 키 배열
		String[] featureKeys = { "lat", "lng", "charge_level", "detour_distance", "waiting_time" };

		if (!jNode.isArray()) {
			// 단일 JSON 객체 처리
			JsonNode rowNode = jNode;
			boolean skipNode = false;
			List<Double> featuresList = new ArrayList<>();

			for (String key : featureKeys) {
				if (!rowNode.has(key) || !rowNode.get(key).isNumber()) {
					log.warn("단일 노드에 '" + key + "' 필드가 없거나 숫자가 아닙니다.");
					skipNode = true;
					break;
				}
				featuresList.add(rowNode.get(key).asDouble());
			}

			if (!skipNode) {
				if (!rowNode.has("time")) {
					log.warn("단일 노드에 time 필드가 없습니다.");
					skipNode = true;
				} else {
					String timeStr = rowNode.get("time").asText();
					double timeFeature = timeToDouble(timeStr);
					featuresList.add(timeFeature);
				}
			}

			if (!skipNode) {
				double[] values = featuresList.stream().mapToDouble(Double::doubleValue).toArray();
				inputData.add(RowFactory.create(Vectors.dense(values)));
				log.info("단일 노드 선형회귀 입력데이터 저장 완료");
			}

			return inputData;
		}

		// 배열인 경우
		for (int i = 0; i < jNode.size(); i++) {
			JsonNode rowNode = jNode.get(i);

			if (rowNode == null || !rowNode.isObject()) {
				log.warn(i + "번째 노드가 JSON 객체가 아니거나 null입니다.");
				continue;
			}

			boolean skipNode = false;
			List<Double> featuresList = new ArrayList<>();

			for (String key : featureKeys) {
				if (!rowNode.has(key) || !rowNode.get(key).isNumber()) {
					log.warn(i + "번째 노드에 '" + key + "' 필드가 없거나 숫자가 아닙니다.");
					skipNode = true;
					break;
				}
				featuresList.add(rowNode.get(key).asDouble());
			}

			if (!skipNode) {
				if (!rowNode.has("time")) {
					log.warn(i + "번째 노드에 time 필드가 없습니다.");
					skipNode = true;
				} else {
					String timeStr = rowNode.get("time").asText();
					double timeFeature = timeToDouble(timeStr);
					featuresList.add(timeFeature);
				}
			}

			if (skipNode) {
				continue;
			}

			double[] values = featuresList.stream().mapToDouble(Double::doubleValue).toArray();
			inputData.add(RowFactory.create(Vectors.dense(values)));
			log.info(i + "번째 노드 선형회귀 입력데이터 저장 완료");
		}
		log.info("@# 선형회귀 입력데이터 =>" + inputData);
		return inputData;
	}

}
