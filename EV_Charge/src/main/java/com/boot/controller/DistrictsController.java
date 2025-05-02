package com.boot.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.boot.dto.DistrictsDTO;
import com.boot.service.DistrictsService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
public class DistrictsController {

	@Autowired
	private DistrictsService districtsService;

	@RequestMapping("/districts_list")
	public List<DistrictsDTO> getAllProvinces(@RequestParam String provinces_code) {
		log.info("districts_list()");
		List<DistrictsDTO> districts = districtsService.getDistricts(provinces_code);
		log.info(districts + "");
		return districts;
	}
}