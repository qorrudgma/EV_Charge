package com.boot.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.boot.dto.DistrictsDTO;

public interface DistrictsService {
	public List<DistrictsDTO> getDistricts(String provinces_code);

	public String getDistrictsCode(@Param("provinces") String provinces, @Param("F_cityCd") String F_cityCd);
}