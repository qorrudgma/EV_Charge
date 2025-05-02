package com.boot.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.boot.dto.ProvincesDTO;
import com.boot.service.ProvincesService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
public class ProvincesController {

	@Autowired
	private ProvincesService provincesService;

	@RequestMapping("/provinces_list")
	public List<ProvincesDTO> getAllProvinces() {
		log.info("provinces_list()");
		List<ProvincesDTO> provinces = provincesService.getAllProvinces();
		log.info(provinces + "");
		return provinces;
	}
}