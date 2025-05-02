package com.boot.dao;

import java.util.List;

import com.boot.dto.DistrictsDTO;

public interface DistrictsDAO {
	public List<DistrictsDTO> getDistricts(String provinces_code);
}