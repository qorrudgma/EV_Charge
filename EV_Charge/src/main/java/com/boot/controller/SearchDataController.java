package com.boot.controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.time.Duration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.boot.dto.EvChargerDTO;
import com.boot.service.EvChargerService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
//@Controller
public class SearchDataController {
	@Value("${new.api.key}")
	private String newkey;

	@Autowired
	private RedisTemplate<String, Object> redisTemplate;

	@Autowired
	private EvChargerService chargerService;

//	@RequestMapping("/search_data")
//	public List<EvChargerDTO> search_data(@RequestBody Map<String, Double> map) {
//		log.info("search_data()");
////		log.info("lat => " + map.get("lat"));
//		Double lat = map.get("lat");
//		Double lng = map.get("lng");
//		Double lat_n = map.get("lat_n");
//		Double lng_n = map.get("lng_n");
////		log.info(lat_n + " / " + lng_n);
//
//		List<EvChargerDTO> ev_list = new ArrayList<>();
//		ev_list = chargerService.ev_list(lat, lng, lat_n, lng_n);
////		log.info("ev_list => " + ev_list);
//
//		return ev_list;
//	}

	@RequestMapping("/search_data")
	public List<EvChargerDTO> search_data(@RequestBody Map<String, Double> map) {
		log.info("search_data()");
		Double lat = map.get("lat");
		Double lng = map.get("lng");
		Double lat_n = map.get("lat_n");
		Double lng_n = map.get("lng_n");

		if (lat_n == 0.0025) {
			String cacheKey = String.format("search_data:%.6f:%.6f", lat, lng);
			// 1) 캐시에서 먼저 조회 시도
			@SuppressWarnings("unchecked")
			List<EvChargerDTO> ev_list = (List<EvChargerDTO>) redisTemplate.opsForValue().get(cacheKey);
			if (ev_list == null) {
				// 2) 캐시에 없으면 DB 조회
				ev_list = chargerService.ev_list(lat, lng, lat_n, lng_n);

				// 3) 조회 결과를 캐시에 저장 (TTL 5분)
//				redisTemplate.opsForValue().set(cacheKey, ev_list, Duration.ofMinutes(5));
				// 시간 제한 없음
				redisTemplate.opsForValue().set(cacheKey, ev_list);

				log.info("DB 조회 후 캐시에 저장 완료");
			} else {
				log.info("캐시에서 데이터 조회 완료");
			}
			return ev_list;
		} else {
			String cacheKey = String.format("search_data:%.2f:%.2f", lat, lng);
			// 1) 캐시에서 먼저 조회 시도
			@SuppressWarnings("unchecked")
			List<EvChargerDTO> ev_list = (List<EvChargerDTO>) redisTemplate.opsForValue().get(cacheKey);
			if (ev_list == null) {
				// 2) 캐시에 없으면 DB 조회
				ev_list = chargerService.ev_list(lat, lng, lat_n, lng_n);
				// 시간 제한 없음
				redisTemplate.opsForValue().set(cacheKey, ev_list);
				log.info("DB 조회 후 캐시에 저장 완료");
			} else {
				log.info("캐시에서 데이터 조회 완료");
			}
			return ev_list;
		}
//		ev_list = chargerService.ev_list(lat, lng, lat_n, lng_n);
//
//		// 4) 결과 리턴
//		return ev_list;
	}

	@RequestMapping("/stat_data")
//	public List<Map<String, Integer>> stat_data(@RequestBody Map<String, String> body) {
	public Map<String, Integer> stat_data(@RequestBody Map<String, String> body) {
		log.info("stat_data()");
		String stat_id = body.get("stat_id");
//		List<Map<String, Integer>> count_list = new ArrayList<>();
//		Map<String, Integer> stat_map = new HashMap<>();

		String cacheKey = String.format("stat_id:%s", stat_id);
		// 1) 캐시에서 먼저 조회 시도 (생략 가능, 없으면 DB에서 조회)
		@SuppressWarnings("unchecked")
		Map<String, Integer> stat_map = (Map<String, Integer>) redisTemplate.opsForValue().get(cacheKey);

		if (stat_map == null) {
			try {
				stat_map = new HashMap<>();
				String url = "https://apis.data.go.kr/B552584/EvCharger/getChargerInfo?serviceKey=" + newkey
						+ "﻿&dataType=JSON&pageNo=1&numOfRows=100&statId=" + stat_id;
				url = url.replace("\uFEFF", "").trim();
				log.info(url);
				URL F_url = new URL(url);
				HttpURLConnection conn = (HttpURLConnection) F_url.openConnection();
				conn.setRequestMethod("GET");

				BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
				StringBuilder sb = new StringBuilder();
				String line;
				while ((line = br.readLine()) != null) {
					sb.append(line);
				}
				br.close();

				JSONObject jsonObj = new JSONObject(sb.toString());

				if (jsonObj.has("items") && jsonObj.getJSONObject("items").has("item")) {
					JSONArray itemArray = jsonObj.getJSONObject("items").getJSONArray("item");

					int rapid_stat_one = 0;
					int rapid_stat_two = 0;
					int rapid_stat_three = 0;
					int rapid_stat_five = 0;
					int rapid_stat_nine = 0;
					int rapid_stat_t = 0;
					int slow_stat_one = 0;
					int slow_stat_two = 0;
					int slow_stat_three = 0;
					int slow_stat_five = 0;
					int slow_stat_nine = 0;
					int slow_stat_t = 0;

					for (int i = 0; i < itemArray.length(); i++) {
						JSONObject item = itemArray.getJSONObject(i);
						int stat = item.optInt("stat", 9);
						int output = item.optInt("output", 0);
						if (output >= 50) {
							switch (stat) {
							case 1:
								rapid_stat_one++;
								break;
							case 2:
								rapid_stat_two++;
								break;
							case 3:
								rapid_stat_three++;
								break;
							case 5:
								rapid_stat_five++;
								break;
							case 9:
								rapid_stat_nine++;
								break;
							default:
								rapid_stat_t++;
								break;
							}
						} else {
							switch (stat) {
							case 1:
								slow_stat_one++;
								break;
							case 2:
								slow_stat_two++;
								break;
							case 3:
								slow_stat_three++;
								break;
							case 5:
								slow_stat_five++;
								break;
							case 9:
								slow_stat_nine++;
								break;
							default:
								slow_stat_t++;
								break;
							}
						}
					}
					stat_map.put("rapid_stat_one", rapid_stat_one);
					stat_map.put("rapid_stat_two", rapid_stat_two);
					stat_map.put("rapid_stat_three", rapid_stat_three);
					stat_map.put("rapid_stat_five", rapid_stat_five);
					stat_map.put("rapid_stat_nine", rapid_stat_nine);
					stat_map.put("rapid_stat_t", rapid_stat_t);
					stat_map.put("slow_stat_one", slow_stat_one);
					stat_map.put("slow_stat_two", slow_stat_two);
					stat_map.put("slow_stat_three", slow_stat_three);
					stat_map.put("slow_stat_five", slow_stat_five);
					stat_map.put("slow_stat_nine", slow_stat_nine);
					stat_map.put("slow_stat_t", slow_stat_t);
//					log.info("!@#$!@#$!@#$" + slow_stat_nine);
					redisTemplate.opsForValue().set(cacheKey, stat_map, Duration.ofMinutes(1));
					log.info("DB 조회 후 캐시에 저장 완료");

					// count_list.add(statMap);
				}

			} catch (Exception e) {
				e.printStackTrace();
			}
		} else {
			log.info("캐시에서 데이터 가져옴");
		}
		return stat_map;
	}
}