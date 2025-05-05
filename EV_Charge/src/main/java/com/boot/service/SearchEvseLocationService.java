package com.boot.service;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.boot.dto.EvseLocationDto;
import com.boot.dto.SearchStationsDto;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@Service
public class SearchEvseLocationService {
	@Autowired
	private ProvincesService provincesService;
	@Autowired
	private DistrictsService districtsService;

	private final GeoCodingService geoCodingService;
	private final KepcoEvseProvider kepcoEvseProvider;

	public List<EvseLocationDto> searchNearbyStations(SearchStationsDto request) {
		log.info("@# request => " + request);
		double[] coords = geoCodingService.convertFromAddressToGeoCoordinate(request.getAddress());
		double userLat = coords[0];
		double userLng = coords[1];
		String address = geoCodingService.convertFromAddressToGeoCoordinate_address(request.getAddress());

//		서울 종로구 관철동
		log.info("지역코드 짜는데 필요한 주소 => " + address);

		String[] f_address = address.split(" ");

		String metroCd = f_address[0]; // 예: 서울특별시
		String F_cityCd = f_address[1];
//		String S_cityCd = f_address[2];
//		log.info(F_cityCd + "/" + S_cityCd);
//		String cityCd = "85"; // 예: 종로구

		log.info("코드로 변환될 주소 두개 => " + metroCd + ", " + F_cityCd);
		// 긴 시/도 명을 짧게 만들기
		char[] metroCdChar = metroCd.toCharArray();
		String metroCd_s = String.valueOf(metroCdChar[0]) + String.valueOf(metroCdChar[1]);

		// 시/도 코드 가져오기
		String provinces = provincesService.getProvincesCode(metroCd_s);
		log.info("들어갈 시/도 코드 => " + provinces);

		String districts = districtsService.getDistrictsCode(provinces, F_cityCd);
		log.info("들어갈 시/군/구 코드 => " + districts);

//		metroCd = "11";
//		cityCd = "11"; // 예: 종로구

//		List<EvseLocationDto> allStations = kepcoEvseProvider.getStationsByRegion(metroCd, cityCd);
		// 여기서 코드를 활용해 데이터
		List<EvseLocationDto> allStations = kepcoEvseProvider.getStationsByRegion(provinces, districts);

		return allStations.stream().filter(station -> haversine(userLat, userLng, station.getEvseLocationLatitude(),
				station.getEvseLocationLongitude()) <= request.getRadiusKm()).collect(Collectors.toList());
	}

	private double haversine(double lat1, double lon1, double lat2, double lon2) {
		final int R = 6371;
		double dLat = Math.toRadians(lat2 - lat1);
		double dLon = Math.toRadians(lon2 - lon1);
		double a = Math.sin(dLat / 2) * Math.sin(dLat / 2) + Math.cos(Math.toRadians(lat1))
				* Math.cos(Math.toRadians(lat2)) * Math.sin(dLon / 2) * Math.sin(dLon / 2);
		return R * 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
	}
}
