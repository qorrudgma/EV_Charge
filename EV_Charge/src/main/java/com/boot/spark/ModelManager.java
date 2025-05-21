package com.boot.spark;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;

import org.apache.spark.ml.classification.LogisticRegressionModel;

public class ModelManager {

	private final String modelPath;

	public ModelManager(String modelPath) {
		this.modelPath = modelPath;
	}

	/**
	 * 모델 저장
	 */
	public void saveModel(LogisticRegressionModel model) {
		try {
			// 디렉토리 존재 여부 확인 후 없으면 생성
			java.nio.file.Path path = Paths.get(modelPath);
			if (!Files.exists(path)) {
				model.save(modelPath);
				System.out.println("모델이 저장되었습니다: " + modelPath);
			} else {
				System.out.println("모델 경로가 이미 존재합니다. 덮어쓰지 않음.");
			}
		} catch (IOException e) {
			System.err.println("모델 저장 중 오류 발생: " + e.getMessage());
			e.printStackTrace();
		}
	}

	/**
	 * 저장된 모델이 존재하는지 확인
	 */
	public boolean modelExists() {
		return Files.exists(Paths.get(modelPath));
	}

	/**
	 * 저장된 모델 불러오기
	 */
	public LogisticRegressionModel loadModel() {
		try {
			return LogisticRegressionModel.load(modelPath);
		} catch (Exception e) {
			System.err.println("모델 로드 중 오류 발생: " + e.getMessage());
			return null;
		}
	}

}
