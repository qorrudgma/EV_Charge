package com.boot.controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.boot.dto.EvChargerDTO;
import com.boot.service.EvChargerService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
//@RestController
@Controller
public class UpdateDataController {
	@Value("${new.api.key}")
	private String newkey;

	@Autowired
	private EvChargerService chargerService;

	@RequestMapping("update_data")
	public String update_data() {
		ev_charger_data();
		return "redirect:main";
	}

	public void ev_charger_data() {
		log.info("ev_charger_data() 시작");
		try {
			// 페이징 처리를 위한 변수 추가
			int pageNo = 1;
			int numOfRows = 9000; // 한 페이지당 데이터 수
			int totalCount = 0;
			boolean hasMoreData = true;

			while (hasMoreData) {
				String url = "https://apis.data.go.kr/B552584/EvCharger/getChargerInfo?serviceKey=" + newkey
						+ "﻿&dataType=JSON&pageNo=" + pageNo + "&numOfRows=" + numOfRows;

				log.info("API URL (" + pageNo + " 페이지) => " + url);
				// url 키값 바뀌는거 방지
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

				// 첫 페이지에서 총 데이터 수 확인
				if (pageNo == 1) {
					totalCount = jsonObj.optInt("totalCount", 0);
//					totalCount = 15;
					log.info("총 데이터 수 =>" + totalCount);
				}

				if (jsonObj.has("items") && jsonObj.getJSONObject("items").has("item")) {
					JSONArray itemArray = jsonObj.getJSONObject("items").getJSONArray("item");
					log.info("페이지 " + pageNo + " => " + itemArray.length());

					// 현재 페이지에 데이터가 없으면 종료
					if (itemArray.length() == 0) {
						hasMoreData = false;
						continue;
					}

					List<EvChargerDTO> ev_charger_data_list = new ArrayList<>();

					for (int i = 0; i < itemArray.length(); i++) {
						EvChargerDTO ev_charger_data = new EvChargerDTO();
						JSONObject item = itemArray.getJSONObject(i);

						String stat_name = item.optString("statNm", "");
						String stat_id = item.optString("statId", "");
						String chger_id = item.optString("chgerId", "");
						String chger_type = item.optString("chgerType", "");
						String addr = item.optString("addr", "");
						String addr_detail = item.optString("addrDetail", "");
						String location = item.optString("location", "");
						double lat = item.optDouble("lat", 0.0);
						double lng = item.optDouble("lng", 0.0);
						String use_time = item.optString("useTime", "");
						String busi_id = item.optString("busiId", "");
						String bnm = item.optString("bnm", "");
						String busi_nm = item.optString("busiNm", "");
						String busi_call = item.optString("busiCall", "");
						String output = item.optString("output", "");
						String method = item.optString("method", "");
						String zcode = item.optString("zcode", "");
						String zscode = item.optString("zscode", "");
						String kind = item.optString("kind", "");
						String kind_detail = item.optString("kindDetail", "");
						String parking_free = item.optString("parkingFree", "");
						String note = item.optString("note", "");
						String limit_yn = item.optString("limitYn", "");
						String limit_detail = item.optString("limitDetail", "");
						String del_yn = item.optString("delYn", "");
						String del_detail = item.optString("delDetail", "");
						String traffic_yn = item.optString("trafficYn", "");
						int year = item.optInt("year", 0);

						ev_charger_data.setStat_name(stat_name);
						ev_charger_data.setStat_id(stat_id);
						ev_charger_data.setChger_id(chger_id);
						ev_charger_data.setChger_type(chger_type);
						ev_charger_data.setAddr(addr);
						ev_charger_data.setAddr_detail(addr_detail);
						ev_charger_data.setLocation(location);
						ev_charger_data.setLat(lat);
						ev_charger_data.setLng(lng);
						ev_charger_data.setUse_time(use_time);
						ev_charger_data.setBusi_id(busi_id);
						ev_charger_data.setBnm(bnm);
						ev_charger_data.setBusi_nm(busi_nm);
						ev_charger_data.setBusi_call(busi_call);
						ev_charger_data.setOutput(output);
						ev_charger_data.setMethod(method);
						ev_charger_data.setZcode(zcode);
						ev_charger_data.setZscode(zscode);
						ev_charger_data.setKind(kind);
						ev_charger_data.setKind_detail(kind_detail);
						ev_charger_data.setParking_free(parking_free);
						ev_charger_data.setNote(note);
						ev_charger_data.setLimit_yn(limit_yn);
						ev_charger_data.setLimit_detail(limit_detail);
						ev_charger_data.setDel_yn(del_yn);
						ev_charger_data.setDel_detail(del_detail);
						ev_charger_data.setTraffic_yn(traffic_yn);
						ev_charger_data.setYear(year);

						ev_charger_data_list.add(ev_charger_data);
					}

					// 데이터베이스에 저장
					if (!ev_charger_data_list.isEmpty()) {
						log.info("페이지 " + pageNo + " => " + ev_charger_data_list.size() + "개의 데이터 저장");
						chargerService.ev_charger_update(ev_charger_data_list);
					}

					// 다음 페이지 확인
					if (pageNo * numOfRows >= totalCount) {
						hasMoreData = false;
						log.info("모든 데이터 처리 완료. 총 " + pageNo + " 페이지, " + totalCount + " 개의 데이터");
					} else {
						pageNo++;
						// API 호출 간격 (서버 부하 방지)
						try {
							Thread.sleep(1000);
						} catch (InterruptedException e) {
							log.warn("스레드 대기 중 인터럽트 발생", e);
						}
					}
				} else {
					log.warn("페이지 " + pageNo + " => 예상된 JSON 구조가 아닙니다");
					hasMoreData = false;
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		log.info("ev_charger_data() 종료");
	}

//	public void ev_charger_data() {
//		log.info("ev_charger_data()");
//		try {
//			String url = "https://apis.data.go.kr/B552584/EvCharger/getChargerInfo?serviceKey=" + newkey
//					+ "﻿&dataType=JSON&pageNo=1&numOfRows=10&statId=ME174013";
//
//			log.info(url);
//			url = url.replace("\uFEFF", "").trim();
//			log.info(url);
//
//			URL F_url = new URL(url);
//			HttpURLConnection conn = (HttpURLConnection) F_url.openConnection();
//			conn.setRequestMethod("GET");
//
//			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
//			StringBuilder sb = new StringBuilder();
//			String line;
//			while ((line = br.readLine()) != null) {
//				sb.append(line);
//			}
//			br.close();
//
//			String jsonData = sb.toString();
//
//			JSONObject jsonObj = new JSONObject(jsonData);
//
//			List<EvChargerDTO> ev_charger_data_list = new ArrayList<>();
//			if (jsonObj.has("items") && jsonObj.getJSONObject("items").has("item")) {
//				JSONArray item_array = jsonObj.getJSONObject("items").getJSONArray("item");
//				log.info("API에서 가져온 데이터 갯수 => " + item_array.length());
//
//				for (int i = 0; i < item_array.length(); i++) {
//					EvChargerDTO ev_charger_data = new EvChargerDTO();
//
//					JSONObject item = item_array.getJSONObject(i);
//
//					String stat_name = item.optString("statNm", "");
//					String stat_id = item.optString("statId", "");
//					String chger_id = item.optString("chgerId", "");
//					String chger_type = item.optString("chgerType", "");
//					String addr = item.optString("addr", "");
//					String addr_detail = item.optString("addrDetail", "");
//					String location = item.optString("location", "");
//					double lat = item.optDouble("lat", 0);
//					double lng = item.optDouble("lng", 0);
//					String use_time = item.optString("useTime", "");
//					String busi_id = item.optString("busiId", "");
//					String bnm = item.optString("bnm", "");
//					String busi_nm = item.optString("busiNm", "");
//					String busi_call = item.optString("busiCall", "");
//					String output = item.optString("output", "");
//					String method = item.optString("method", "");
//					String zcode = item.optString("zcode", "");
//					String zscode = item.optString("zscode", "");
//					String kind = item.optString("kind", "");
//					String kind_detail = item.optString("kindDetail", "");
//					String parking_free = item.optString("parkingFree", "");
//					String note = item.optString("note", "");
//					String limit_yn = item.optString("limitYn", "");
//					String limit_detail = item.optString("limitDetail", "");
//					String del_yn = item.optString("delYn", "");
//					String del_detail = item.optString("delDetail", "");
//					String traffic_yn = item.optString("trafficYn", "");
//					int year = item.optInt("year", 0);
//					ev_charger_data.setStat_name(stat_name);
//					ev_charger_data.setStat_id(stat_id);
//					ev_charger_data.setChger_id(chger_id);
//					ev_charger_data.setChger_type(chger_type);
//					ev_charger_data.setAddr(addr);
//					ev_charger_data.setAddr_detail(addr_detail);
//					ev_charger_data.setLocation(location);
//					ev_charger_data.setLat(lat);
//					ev_charger_data.setLng(lng);
//					ev_charger_data.setUse_time(use_time);
//					ev_charger_data.setBusi_id(busi_id);
//					ev_charger_data.setBnm(bnm);
//					ev_charger_data.setBusi_nm(busi_nm);
//					ev_charger_data.setBusi_call(busi_call);
//					ev_charger_data.setOutput(output);
//					ev_charger_data.setMethod(method);
//					ev_charger_data.setZcode(zcode);
//					ev_charger_data.setZscode(zscode);
//					ev_charger_data.setKind(kind);
//					ev_charger_data.setKind_detail(kind_detail);
//					ev_charger_data.setParking_free(parking_free);
//					ev_charger_data.setNote(note);
//					ev_charger_data.setLimit_yn(limit_yn);
//					ev_charger_data.setLimit_detail(limit_detail);
//					ev_charger_data.setDel_yn(del_yn);
//					ev_charger_data.setDel_detail(del_detail);
//					ev_charger_data.setTraffic_yn(traffic_yn);
//					ev_charger_data.setYear(year);
//
//					ev_charger_data_list.add(ev_charger_data);
//				}
//				chargerService.ev_charger_update(ev_charger_data_list);
//			}
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		log.info("ev_charger_data()");
//	}

//	@RequestMapping("/search_data")
//	public List<EvChargerDTO> search_data(@RequestBody Map<String, Double> map) {
//		log.info("search_data()");
//		log.info("lat => " + map.get("lat"));
//		Double lat = map.get("lat");
//		Double lng = map.get("lng");
//
//		List<EvChargerDTO> ev_list = new ArrayList<>();
//		ev_list = chargerService.ev_list(lat, lng);
//		log.info("ev_list => " + ev_list);
//
//		return ev_list;
//	}
}