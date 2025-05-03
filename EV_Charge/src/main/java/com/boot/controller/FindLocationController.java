package com.boot.controller;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.boot.dto.MemberDTO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
public class FindLocationController {

	@Value("${kakao.api.key}") // API Key를 application.properties에서 주입
	private String kakaoApiKey;

	@Value("${api.key}") // API Key를 application.properties에서 주입
	private String key;

	// 주소를 경도 위도로 변환
	@PostMapping("/updateMapCoordinates_two")
	public String updateMapCoordinates_two(@RequestBody List<List<String>> address) {
		log.info("변환하러 오긴했음");
		log.info("@# 받은값 =>" + address);

		// getJSONResponse_two 호출하여 좌표 정보 가져오기
		JSONArray resultArray = getJSONResponse_two(address);
		log.info("@# 좌표정보에 있는 데이터들 => " + resultArray);

		if (resultArray == null || resultArray.length() == 0) {
			return new JSONObject().put("error", "주소에 대한 좌표를 찾을 수 없습니다.(two)").toString();
		}

		// 결과 객체 생성
		JSONObject result = new JSONObject();
		JSONArray coordinatesArray = new JSONArray();

		// 각 주소의 결과 처리
		for (int i = 0; i < resultArray.length(); i++) {
			try {
				JSONObject addressResult = resultArray.getJSONObject(i);

				// 좌표 정보가 있는 경우에만 처리
				if (addressResult.has("latitude") && addressResult.has("longitude")) {
					JSONObject coordObj = new JSONObject();

					// 주소 정보 추가
					coordObj.put("address", addressResult.getString("address"));

					// 좌표 정보 추가
					coordObj.put("latitude", addressResult.getString("latitude"));
					coordObj.put("longitude", addressResult.getString("longitude"));

					// 장소명 정보가 있는 경우 추가
					if (addressResult.has("name")) {
						coordObj.put("name", addressResult.getString("name"));
					}
					// 급속 충전기
					if (addressResult.has("rapid")) {
						coordObj.put("rapid", addressResult.getString("rapid"));
					}
					// 완속 충전기
					if (addressResult.has("slow")) {
						coordObj.put("slow", addressResult.getString("slow"));
					}
					// 지원 차종
					if (addressResult.has("car")) {
						coordObj.put("car", addressResult.getString("car"));
					}

					coordinatesArray.put(coordObj);
				}
			} catch (JSONException e) {
				e.printStackTrace();
				log.error("JSON 처리 중 오류가 발생했습니다.(two): " + e.getMessage());
			}
		}

		result.put("coordinates", coordinatesArray);
		log.info("@# updateMapCoordinates_two() 가 보내는값 =>" + result.toString());
		return result.toString();
	}

	// kakao API를 이용해서 주소값을 위도와 경도를 가진 JSON 배열로 반환하는 메소드
	public JSONArray getJSONResponse_two(List<List<String>> addr_list) {
		JSONArray resultArray = new JSONArray();

		for (List<String> addr_item : addr_list) {
			if (addr_item == null || addr_item.isEmpty()) {
				continue;
			}

			// 각 항목의 첫 번째 요소가 addr 주소임
			String addr = addr_item.get(0);

			try {
				String encodedAddress = java.net.URLEncoder.encode(addr, "UTF-8");
				String apiUrl = "https://dapi.kakao.com/v2/local/search/address.json?query=" + encodedAddress;

				URL url = new URL(apiUrl);
				HttpURLConnection connection = (HttpURLConnection) url.openConnection();
				connection.setRequestMethod("GET");
				connection.setRequestProperty("Authorization", "KakaoAK " + kakaoApiKey); // Kakao API Key

				BufferedReader in = new BufferedReader(new InputStreamReader(connection.getInputStream()));
				String inputLine;
				StringBuffer response = new StringBuffer();

				while ((inputLine = in.readLine()) != null) {
					response.append(inputLine);
				}
				in.close();

				// JSON 응답 파싱
				JSONObject jsonResponse = new JSONObject(response.toString());
				JSONArray documents = jsonResponse.getJSONArray("documents");

				if (documents.length() > 0) {
					JSONObject firstDocument = documents.getJSONObject(0);

					// 결과 객체 생성
					JSONObject resultItem = new JSONObject();
					resultItem.put("address", addr);

					// 위치 정보가 있는 경우에만 추가
					if (firstDocument.has("x") && firstDocument.has("y")) {
						resultItem.put("longitude", firstDocument.getString("x"));
						resultItem.put("latitude", firstDocument.getString("y"));
					}

					// 장소명
					resultItem.put("name", addr_item.get(1));
					// 급속 충전기
					resultItem.put("rapid", addr_item.get(2));
					// 완속 충전기
					resultItem.put("slow", addr_item.get(3));
					// 지원 차종
					resultItem.put("car", addr_item.get(4));

					resultArray.put(resultItem);
				}

			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		log.info("@# getJSONResponse_two() 에서 보내는 데이터 => " + resultArray);
		return resultArray; // 모든 주소 처리 후 결과 반환
	}

	@PostMapping("/updateMapCoordinates")
	public String updateMapCoordinates(@RequestBody MemberDTO address) {
		String[] coordinates = new String[2]; // [0] -> latitude, [1] -> longitude

		try {
//         String addressString = "서울특별시 강남구 선릉로 121길 12";
			String addressString = buildAddress(address, true);
			JSONArray documents = getJSONResponse(addressString);

			if (documents == null || documents.length() == 0) {
				// 읍/면/동이 없는 주소로 fallback
				addressString = buildAddress(address, false);
				documents = getJSONResponse(addressString);
			}

			if (documents != null && documents.length() > 0) {
				JSONObject firstDocument = documents.getJSONObject(0);
				coordinates[0] = firstDocument.getString("y"); // 위도
				coordinates[1] = firstDocument.getString("x"); // 경도
			} else {
				return new JSONObject().put("error", "주소에 대한 좌표를 찾을 수 없습니다.").toString();
			}

		} catch (JSONException e) {
			e.printStackTrace();
			return new JSONObject().put("error", "응답에서 JSON 파싱 중 오류가 발생했습니다.").toString();
		} catch (Exception e) {
			e.printStackTrace();
			return new JSONObject().put("error", "알 수 없는 오류가 발생했습니다.").toString();
		}

		// 성공적으로 위도와 경도를 반환
		return new JSONObject().put("latitude", coordinates[0]).put("longitude", coordinates[1]).toString();
	}

	public JSONArray getJSONResponse(String addressString) {
		try {
			String encodedAddress = java.net.URLEncoder.encode(addressString, "UTF-8");
			String apiUrl = "https://dapi.kakao.com/v2/local/search/address.json?query=" + encodedAddress;

			// API 요청
			URL url = new URL(apiUrl);
			HttpURLConnection connection = (HttpURLConnection) url.openConnection();
			connection.setRequestMethod("GET");
			connection.setRequestProperty("Authorization", "KakaoAK " + kakaoApiKey); // Kakao API Key

			// 응답 받기
			BufferedReader in = new BufferedReader(new InputStreamReader(connection.getInputStream()));
			String inputLine;
			StringBuffer response = new StringBuffer();

			while ((inputLine = in.readLine()) != null) {
				response.append(inputLine);
			}
			in.close();

			// JSON 응답 파싱
			JSONObject jsonResponse = new JSONObject(response.toString());
			JSONArray documents = jsonResponse.getJSONArray("documents");

			return documents;

		} catch (Exception e) {
			e.printStackTrace();
		}

		return null;
	}

	// 읍면동 주소값이 있는지 없는지 판별하는 메소드
	private String buildAddress(MemberDTO address, boolean includeEmd) {
		String addr = address.getArea_ctpy_nm() + " " + address.getArea_sgg_nm();
		if (includeEmd && address.getArea_emd_nm() != null && !address.getArea_emd_nm().isEmpty()) {
			addr += " " + address.getArea_emd_nm();
		}
		return addr;
	}

	// 센터점 주변 충전소 찾기
	@RequestMapping("/findStationsNear")
	@ResponseBody
	public List<List<String>> findStationsNear(@RequestParam String area_ctpy_nm, @RequestParam String area_sgg_nm) {

		log.info("@# area_ctpy_nm =>" + area_ctpy_nm);
		log.info("@# area_sgg_nm =>" + area_sgg_nm);

		// 결과를 담을 리스트
		List<List<String>> addr_place_list = new ArrayList<>();

		try {
			// URL 연결
			String p_url = "https://bigdata.kepco.co.kr/openapi/v1/EVcharge.do?apiKey=" + key
					+ "&returnType=json&metroCd=" + area_ctpy_nm + "&cityCd=" + area_sgg_nm;

			URL url = new URL(p_url);
			log.info(p_url + "");
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("GET");

			// 결과 읽기
			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
			StringBuilder sb = new StringBuilder();
			String line;
			while ((line = br.readLine()) != null) {
				sb.append(line);
			}
			br.close();

			// JSON 파싱
			JSONObject jsonObj = new JSONObject(sb.toString());
			JSONArray dataArr = jsonObj.getJSONArray("data");

			for (int i = 0; i < dataArr.length(); i++) {
				List<String> addr_place = new ArrayList<>();
				JSONObject item = dataArr.getJSONObject(i);
				String addr = item.getString("stnAddr");
				String place = item.getString("stnPlace");
				String rapid = Integer.toString(item.getInt("rapidCnt"));
				String slow = Integer.toString(item.getInt("slowCnt"));
				String car = item.getString("carType");
				addr_place.add(addr);
				addr_place.add(place);
				addr_place.add(rapid);
				addr_place.add(slow);
				addr_place.add(car);
				addr_place_list.add(addr_place);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		log.info("findStationsNear() : " + addr_place_list);
		return addr_place_list;
	}

	@RequestMapping("/update")
	public void dataUpdate() {
		// 파일 저장
		try {
			String urlString = "https://apis.data.go.kr/B552584/EvCharger/getChargerStatus?serviceKey=ha6Vs0w2TW5hmQMnGjVefZDfIMjkFiXLXhNYfw0kPcJd470rlZfa95pVgwgLfQYMXmMVe0%2BjwHptLmAGdhXaCw%3D%3D&pageNo=1&numOfRows=10&period=5&zcode=11";
			URL url = new URL(urlString);

			InputStream inputStream = url.openStream();
			String savePath = "C:\\Users\\user\\test.xml"; // 예: "C:/data/page1.xml"
			Files.copy(inputStream, Paths.get(savePath));
			inputStream.close();

			System.out.println("파일 저장 완료: " + savePath);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}