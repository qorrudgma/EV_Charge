package com.boot.dao;

import java.util.List;

import com.boot.dto.ProvincesDTO;

public interface ProvincesDAO {
	public List<ProvincesDTO> getAllProvinces();

	public String getProvincesCode(String metroCd);
}
