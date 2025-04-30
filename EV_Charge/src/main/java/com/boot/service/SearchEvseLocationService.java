package com.boot.service;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;

import com.boot.dto.EvseLocationDto;
import com.boot.dto.SearchStationsDto;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@Service
public class SearchEvseLocationService {

	private final GeoCodingService geoCodingService;
	private final KepcoEvseProvider kepcoEvseProvider;

	public List<EvseLocationDto> searchNearbyStations(SearchStationsDto request) {

		double[] coords = geoCodingService.convertFromAddressToGeoCoordinate(request.getAddress());
		double userLat = coords[0];
		double userLng = coords[1];

		// TODO: metroCd, cityCd 추출 또는 설정 필요
		String metroCd = "11"; // 예: 서울특별시
		String cityCd = "11"; // 예: 종로구

		List<EvseLocationDto> allStations = kepcoEvseProvider.getStationsByRegion(metroCd, cityCd);

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
