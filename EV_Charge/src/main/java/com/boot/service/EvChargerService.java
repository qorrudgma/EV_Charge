package com.boot.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.boot.dto.EvChargerDTO;

public interface EvChargerService {
	public void ev_charger_update(List<EvChargerDTO> ev_charger_data);

	// 경도위도 근처 충전소 정보
//	public List<EvChargerDTO> ev_list(@Param("lat") Double lat, @Param("lng") Double lng);
	public List<EvChargerDTO> ev_list(@Param("lat") Double lat, @Param("lng") Double lng, @Param("lat_n") Double lat_n,
			@Param("lng_n") Double lng_n);
}