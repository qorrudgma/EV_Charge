package com.boot.service;

import java.util.List;

import com.boot.dto.ProvincesDTO;

public interface ProvincesService {
	public List<ProvincesDTO> getAllProvinces();

	public String getProvincesCode(String metroCd);
}