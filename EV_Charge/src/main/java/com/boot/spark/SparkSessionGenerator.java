/*==========================================================
* 파일명     : SparkSessionGenerator.java
* 작성자     : 임진우
* 작성일자   : 2025-05-21
* 설명       : 스파크 세션 객체 생성기

* 수정 이력 :
* 날짜         수정자       내용
* --------   ----------   ------------------------- 
* 2025-05-20   임진우       완성
============================================================*/

package com.boot.spark;

import org.apache.spark.sql.SparkSession;

public class SparkSessionGenerator {
	public SparkSession makeSparkSession(String appName, String master) {
		SparkSession spark = SparkSession.builder().appName(appName).master(master).getOrCreate();
		return spark;
	}
}
