package com.boot.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.boot.dto.EvChargerDTO;

public interface EvChargerDAO {
	public void ev_charger_update(EvChargerDTO ev_charger_data);

	// 경도위도 근처 충전소 정보
	public List<EvChargerDTO> ev_list(@Param("lat") Double lat, @Param("lng") Double lng);
}