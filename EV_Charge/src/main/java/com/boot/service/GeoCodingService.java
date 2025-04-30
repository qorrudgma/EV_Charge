package com.boot.service;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

import com.fasterxml.jackson.databind.JsonNode;

@Service
public class GeoCodingService {

	private final RestTemplate restTemplate = new RestTemplate();
	private final String BASE_URL = "https://dapi.kakao.com/v2/local/search/address.json";
	private final String KAKAO_API_KEY = "KakaoAK 1562effcafb2affe43ab466614eed613";

	public double[] convertFromAddressToGeoCoordinate(String inputAddress) {
		String url = UriComponentsBuilder.fromHttpUrl(BASE_URL).queryParam("query", inputAddress).build().toUriString();

		HttpHeaders headers = new HttpHeaders();
		headers.set("Authorization", KAKAO_API_KEY);
		HttpEntity<?> entity = new HttpEntity<>(headers);

		ResponseEntity<JsonNode> response = restTemplate.exchange(url, HttpMethod.GET, entity, JsonNode.class);
		JsonNode documents = response.getBody().get("documents");

		if (documents.isArray() && documents.size() > 0) {
			JsonNode addressNode = documents.get(0).get("address");
			double latitude = addressNode.get("y").asDouble();
			double longitude = addressNode.get("x").asDouble();
			return new double[] { latitude, longitude };
		} else {
			throw new RuntimeException("주소에 대한 좌표를 찾을 수 없습니다.");
		}
	}
}
