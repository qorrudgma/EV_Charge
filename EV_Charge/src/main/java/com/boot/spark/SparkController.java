/*==========================================================
* 파일명     : SparkController.java
* 작성자     : 임진우
* 작성일자   : 2025-05-21
* 설명       : Spark 동작 트리거용 컨트롤러

* 수정 이력 :
* 날짜         수정자       내용
* --------   ----------   ------------------------- 
* 2025-05-20   임진우       테스트 완료
============================================================*/

package com.boot.spark;

import org.apache.spark.sql.Dataset;
import org.apache.spark.sql.Row;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/spark")
public class SparkController {

	private SparkService sparkService;

	public SparkController(SparkServiceImpl sparkService) {
		this.sparkService = sparkService;
	}

	@GetMapping("/test")
	public Dataset<Row> testSpark() throws Exception {
		LogisticRegressionResult LR = new LogisticRegressionResult();
		Dataset<Row> predictions = LR.executeLogRegression(null);

		return predictions;
	}
}
