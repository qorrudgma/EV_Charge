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

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.spark.ml.linalg.Vector;
import org.apache.spark.sql.Dataset;
import org.apache.spark.sql.Row;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.boot.dto.EvChargerDTO;
import com.boot.reservation.dto.ReservationDTO;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ArrayNode;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class SparkController {

	private SparkService sparkService;

	public SparkController(SparkServiceImpl sparkService) {
		this.sparkService = sparkService;
	}

	// 로지스틱 모델 해당 충전소 혼잡도 예측
	public List<Map<String, Double>> logisticAnalize(String stat_id) throws Exception {

		LogisticRegressionResult LRR = new LogisticRegressionResult();
		List<EvChargerDTO> dtos = sparkService.select_data_by_stat(stat_id);

		ObjectMapper objectMapper = new ObjectMapper();
		ArrayNode arrayNode = objectMapper.createArrayNode();

		for (int i = 0; i < dtos.size(); i++) {
			Map<String, Object> partialMap = new HashMap<>();

			double latitude = dtos.get(i).getLat();
			double longitude = dtos.get(i).getLng();
			double charge_level = Double.parseDouble(dtos.get(i).getOutput()); // 충전기 충전속도 = output 필드
			double detour_distance = 40.0; // 실제 데이터 있으면 넣기
			double waiting_time = 40.0; // 실제 데이터 있으면 넣기
			String busi_nm_val = dtos.get(i).getBusi_nm(); // 사업자명

			partialMap.put("lat", latitude);
			partialMap.put("lng", longitude);
			partialMap.put("charge_level", charge_level);
			partialMap.put("detour_distance", detour_distance);
			partialMap.put("waiting_time", waiting_time);
			partialMap.put("busi_nm", busi_nm_val);

			log.info("@# logisticAnalize() partialMap =>" + partialMap);

			JsonNode jsonNode = objectMapper.valueToTree(partialMap);
			arrayNode.add(jsonNode);
		}

		Dataset<Row> predictions = LRR.executeLogRegression(arrayNode);
		log.info("@# logisticAnalize() predictions =>" + predictions);
		List<Row> rows = predictions.collectAsList(); // Dataset<Row> → List<Row>

		List<Map<String, Double>> result_list = new ArrayList<>();
		for (Row row : rows) {
			Map<String, Double> result = new HashMap<>();
			double prediction = row.getAs("prediction");

			// probability는 Vector 타입이므로 getAs(Vector)로 받기
			Vector probabilityVector = row.getAs("probability");
			double prob_0 = probabilityVector.apply(0); // 클래스 0일 확률
			double prob_1 = probabilityVector.apply(1); // 클래스 1일 확률

			System.out.println("예측 결과: " + prediction);
			System.out.println("혼잡할 확률: " + prob_1);
			System.out.println("혼잡하지 않을 확률: " + prob_0);

			result.put("prediction", prediction);
			result.put("prob_1", prob_1);
			result.put("prob_0", prob_0);
			result_list.add(result);
		}

		return result_list;
	}

	// 선형 모델 해당 충전소 추정 예약자수 예측
	public List<Map<String, Double>> linearAnalize(String stat_id) throws Exception {
		LinearRegressionResult LRR = new LinearRegressionResult();
		List<EvChargerDTO> dtos = sparkService.select_data_by_stat(stat_id);
		ObjectMapper objectMapper = new ObjectMapper();
		ArrayNode arrayNode = objectMapper.createArrayNode();

		for (EvChargerDTO dto : dtos) {
			Map<String, Object> sample = new HashMap<>();
			sample.put("lat", dto.getLat());
			sample.put("lng", dto.getLng());
			sample.put("charge_level", Double.parseDouble(dto.getOutput()));
			sample.put("detour_distance", 40.0);
			sample.put("waiting_time", 40.0);

			// time 필드 추가 (dto에 getTime() 있으면 사용, 없으면 임시값)
			sample.put("time", "03:00");

			JsonNode jsonNode = objectMapper.valueToTree(sample);
			arrayNode.add(jsonNode);
		}

		Dataset<Row> predictions = LRR.executeLinearRegression(arrayNode);
		List<Row> rows = predictions.collectAsList();

		List<Map<String, Double>> result_list = new ArrayList<>();
		for (Row row : rows) {
			Map<String, Double> result = new HashMap<>();
			double prediction = row.getAs("prediction");
			result.put("prediction", prediction);
			result_list.add(result);
		}

		return result_list;
	}

	// 분석 기법을 이용한 차트표현
	@GetMapping("/getChart")
//	public void getChart(@RequestParam("stat_id") String stat_id, Model model) throws Exception {
	public String getChart(Model model) throws Exception {
		String stat_id = "BT000149"; // 파라미터로 id 받을때 이거 주석처리
		log.info("@# Start!! log_predictions");
		List<Map<String, Double>> log_predictions = logisticAnalize(stat_id);
		log.info("@# getChart() log_predictions=>" + log_predictions);

		List<EvChargerDTO> stat_dtos = sparkService.select_data_by_stat(stat_id);
		List<ReservationDTO> reserve_dtos = sparkService.select_reserve_by_stat_id("7");

		String addr = stat_dtos.get(1).getAddr();
		String[] addr_array = addr.split(" ");
		String head_addr_1 = addr_array[0];
		String head_addr_2 = addr_array[1];
		String head_addr_3 = addr_array[2];
		String head_addr = head_addr_1 + " " + head_addr_2 + " " + head_addr_3;
		List<EvChargerDTO> addr_dtos = sparkService.select_stats_by_addr(head_addr);

		model.addAttribute("log_predictions", log_predictions);
		model.addAttribute("addr_dtos", addr_dtos);
		model.addAttribute("reserve_dtos", reserve_dtos);

		return "chart";
	}
}
