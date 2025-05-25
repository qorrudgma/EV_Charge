package com.boot.findpath;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.boot.board.controller.BoardController;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class NaviController {

	private final BoardController boardController;

	private final KakaoNaviClient kakaoNaviClient;
	private final ObjectMapper objectMapper;

	public NaviController(KakaoNaviClient kakaoNaviClient, ObjectMapper objectMapper, BoardController boardController) {
		this.kakaoNaviClient = kakaoNaviClient;
		this.objectMapper = objectMapper;
		this.boardController = boardController;
	}

	@GetMapping("/findpath")
	public String showMap(@RequestParam(required = false) Double startLat,
			@RequestParam(required = false) Double startLng, @RequestParam(required = false) Double endLng,
			@RequestParam(required = false) Double endLat, Model model) throws Exception {

		if (endLat == null || endLng == null) {
			// 주소 미입력 시 빈 지도 또는 안내 페이지 보여주기
			model.addAttribute("vertexJson", "[]");
			return "/main";
		}

		List<Map<String, Object>> routeInfoList = new ArrayList<>();

		String startCoord = startLng + "," + startLat;
		String endCoord = endLng + "," + endLat;
		// 1) 출발지, 목적지를 위경도로 변환 (예: Kakao Local API 또는 직접 구현)
		String response = kakaoNaviClient.getDirections(startCoord, endCoord);

		log.info("@# showMap response =>" + response);
		int distance = 0;
		JsonNode root = objectMapper.readTree(response);
		List<Double> vertexList = new ArrayList<>();
		JsonNode routesNode = root.get("routes");
		if (routesNode != null && routesNode.isArray()) {
			for (JsonNode route : routesNode) {

				// distance 추출
				JsonNode summaryNode = route.get("summary");
				if (summaryNode != null && summaryNode.has("distance")) {
					distance = summaryNode.get("distance").asInt();
					log.info("@# Total distance => " + distance);
				}

				JsonNode sectionsNode = route.get("sections");
				if (sectionsNode != null && sectionsNode.isArray()) {
					for (JsonNode section : sectionsNode) {
						JsonNode roadsNode = section.get("roads");
						if (roadsNode != null && roadsNode.isArray()) {
							for (JsonNode road : roadsNode) {
								JsonNode vertexesNode = road.get("vertexes");
								if (vertexesNode != null && vertexesNode.isArray()) {
									for (JsonNode vertex : vertexesNode) {
										vertexList.add(vertex.asDouble());
									}
								}

								Map<String, Object> routeInfo = new HashMap<>();
								routeInfo.put("name", road.path("name").asText("이름 없음"));
								routeInfo.put("distance", road.path("distance").asInt(-1));
								routeInfo.put("duration", road.path("duration").asInt(-1));
								routeInfo.put("turnType", road.path("turnType").asInt(-1));
								routeInfo.put("roadType", road.path("roadType").asInt(-1));
								routeInfo.put("guidance", road.path("guidance").asText(""));
								routeInfo.put("trafficSpeed", road.path("trafficSpeed").asInt(-1));
								routeInfo.put("trafficState", road.path("trafficState").asInt(-1));
								routeInfoList.add(routeInfo);

							}
						}
					}
				}
			}
		}

		String vertexJson = objectMapper.writeValueAsString(vertexList);
		model.addAttribute("routeInfoList", routeInfoList);
		model.addAttribute("vertexJson", vertexJson);
		model.addAttribute("findpath", "findpath_ok");

		log.info("@# showMap routeInfoList =>" + routeInfoList);

		return "/main";
	}
}
