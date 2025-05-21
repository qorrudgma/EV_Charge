package com.boot.findpath;

import javax.annotation.PostConstruct;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;

import lombok.extern.slf4j.Slf4j;

// Spring Boot에서 HTTP 요청 보내는 방법
@Component
@Slf4j
public class KakaoNaviClient {

	private static String REST_API_KEY;

	@Value("${kakao.api.key}")
	private String restAPIKey;

	@PostConstruct
	public void init() {
		REST_API_KEY = restAPIKey;
	}

	public static String getRestApiKey() {
		return REST_API_KEY;
	}

	public String getDirections(String startCoord, String endCoord) {
		// 출발지, 도착지 주소를 위경도로 변환하는 작업 필요
		// 변환 후 좌표로 카카오 내비게이션 API 호출
		// 간단하게 예시 URL 생성
		String url = "https://apis-navi.kakaomobility.com/v1/directions?origin=" + startCoord + "&destination="
				+ endCoord + "&summary=false";

		return callApi(url);
	}

	public String callApi(String url) {
		RestTemplate restTemplate = new RestTemplate();

		HttpHeaders headers = new HttpHeaders();
		headers.set("Authorization", "KakaoAK " + REST_API_KEY); // 인증 헤더 추가

		HttpEntity<String> entity = new HttpEntity<>(headers);

		ResponseEntity<String> response = restTemplate.exchange(url, HttpMethod.GET, entity, String.class);

		return response.getBody();
	}
}
