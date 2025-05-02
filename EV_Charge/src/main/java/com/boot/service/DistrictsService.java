package com.boot.service;

import java.util.List;

import com.boot.dto.DistrictsDTO;

public interface DistrictsService {
	public List<DistrictsDTO> getDistricts(String provinces_code);
}