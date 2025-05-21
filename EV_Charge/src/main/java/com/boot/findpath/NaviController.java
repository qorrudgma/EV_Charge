package com.boot.findpath;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class NaviController {

	private final KakaoNaviClient kakaoNaviClient;
	private final ObjectMapper objectMapper;

	public NaviController(KakaoNaviClient kakaoNaviClient, ObjectMapper objectMapper) {
		this.kakaoNaviClient = kakaoNaviClient;
		this.objectMapper = objectMapper;
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
		log.info("@# Param startLat =>" + startLat);
		log.info("@# Param startLng =>" + startLng);

//		if (startLat == null || startLng == null) {
//			// 기본값 (서울 시청 좌표)
//			startLat = 37.5665;
//			startLng = 126.9780;
//		}
		String startCoord = startLng + "," + startLat;
		String endCoord = endLng + "," + endLat;
		// 1) 출발지, 목적지를 위경도로 변환 (예: Kakao Local API 또는 직접 구현)
		// 여기서는 kakaoNaviClient에서 출발지/목적지를 받아서 경로 정보를 리턴하도록 수정 필요
		String response = kakaoNaviClient.getDirections(startCoord, endCoord);

		log.info("@# showMap response =>" + response);
		int distance = 0;
		JsonNode root = objectMapper.readTree(response);
		log.info("@# showMap root =>" + root);

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
							}
						}
					}
				}
			}
		}

		String vertexJson = objectMapper.writeValueAsString(vertexList);
		log.info("@# showMap vertexJson =>" + vertexJson);
		log.info("@# showMap distance =>" + distance);
		log.info("@# showMap startLat =>" + startLat);
		log.info("@# showMap startLng =>" + startLng);
		log.info("@# showMap startLat =>" + endLat);
		log.info("@# showMap startLng =>" + endLng);
		model.addAttribute("vertexJson", vertexJson);
		model.addAttribute("findpath", "findpath_ok");

		return "/main";
	}
}
