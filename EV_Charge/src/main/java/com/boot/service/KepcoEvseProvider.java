package com.boot.service;

import java.util.ArrayList;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;

import com.boot.dto.EvseLocationDto;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RequiredArgsConstructor
@Component
@Slf4j
public class KepcoEvseProvider {

	private final GeoCodingService geoCodingService; // 주소 -> 좌표 변환 서비스

	private String apiKey = "5dn0N8Crwm8QuYA4ZXI0CIC2691l5ei6VxmTc9JI";

	public List<EvseLocationDto> getStationsByRegion(String metroCd, String cityCd) {
		List<EvseLocationDto> result = new ArrayList<>();
		try {
			String url = "https://bigdata.kepco.co.kr/openapi/v1/EVcharge.do?apiKey=" + apiKey
					+ "&returnType=json&metroCd=" + metroCd + "&cityCd=" + cityCd;

			String json = new RestTemplate().getForObject(url, String.class);
			JSONObject root = new JSONObject(json);
			JSONArray data = root.getJSONArray("data");

			for (int i = 0; i < data.length(); i++) {
				JSONObject obj = data.getJSONObject(i);
				String stationName = obj.getString("stnPlace");
				String stationAddress = obj.getString("stnAddr");

				// 주소 -> 좌표 변환
				double[] coords = geoCodingService.convertFromAddressToGeoCoordinate(stationAddress);
				double lat = coords[0];
				double lng = coords[1];

				result.add(new EvseLocationDto("1", stationName, stationAddress, lat, lng));
			}
		} catch (Exception e) {
			log.error("Error while fetching stations", e);
		}
		return result;
	}
}
