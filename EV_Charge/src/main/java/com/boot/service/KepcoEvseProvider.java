package com.boot.service;

import java.util.ArrayList;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;

import com.boot.dto.EvseLocationDto;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RequiredArgsConstructor
@Component
@Slf4j
public class KepcoEvseProvider {

	@Value("${api.key}") // API Key를 application.properties에서 주입
	private String key;

	private final GeoCodingService geoCodingService; // 주소 -> 좌표 변환 서비스

	public List<EvseLocationDto> getStationsByRegion(String metroCd, String cityCd) {
		List<EvseLocationDto> result = new ArrayList<>();
		try {
			String url = "https://bigdata.kepco.co.kr/openapi/v1/EVcharge.do?apiKey=" + key
					+ "&returnType=json&metroCd=" + metroCd + "&cityCd=" + cityCd;

			String json = new RestTemplate().getForObject(url, String.class);
			JSONObject root = new JSONObject(json);
			JSONArray data = root.getJSONArray("data");

			for (int i = 0; i < data.length(); i++) {
				JSONObject obj = data.getJSONObject(i);
//				String stationName = obj.getString("stnPlace");
//				String stationAddress = obj.getString("stnAddr");
				String addr = obj.getString("stnAddr");
				String place = obj.getString("stnPlace");
				String rapid = Integer.toString(obj.getInt("rapidCnt"));
				String slow = Integer.toString(obj.getInt("slowCnt"));
				String car = obj.getString("carType");

				// 주소 -> 좌표 변환
				double[] coords = geoCodingService.convertFromAddressToGeoCoordinate(addr);
				double lat = coords[0];
				double lng = coords[1];

				result.add(new EvseLocationDto(Integer.toString(i), place, addr, lat, lng, rapid, slow, car));
			}
		} catch (Exception e) {
			log.error("Error while fetching stations", e);
		}
		return result;
	}

//	public List<EvseLocationDto> getStationsByRegion(String metroCd, String cityCd) {
//		List<EvseLocationDto> result = new ArrayList<>();
//		try {
//			String url = "https://bigdata.kepco.co.kr/openapi/v1/EVcharge.do?apiKey=" + apiKey
//					+ "&returnType=json&metroCd=" + metroCd + "&cityCd=" + cityCd;
//			
//			String json = new RestTemplate().getForObject(url, String.class);
//			JSONObject root = new JSONObject(json);
//			JSONArray data = root.getJSONArray("data");
//			
//			for (int i = 0; i < data.length(); i++) {
//				JSONObject obj = data.getJSONObject(i);
//				String stationName = obj.getString("stnPlace");
//				String stationAddress = obj.getString("stnAddr");
//				
//				// 주소 -> 좌표 변환
//				double[] coords = geoCodingService.convertFromAddressToGeoCoordinate(stationAddress);
//				double lat = coords[0];
//				double lng = coords[1];
//				
//				result.add(new EvseLocationDto("1", stationName, stationAddress, lat, lng, "1", "1", "1"));
//			}
//		} catch (Exception e) {
//			log.error("Error while fetching stations", e);
//		}
//		return result;
//	}
}
