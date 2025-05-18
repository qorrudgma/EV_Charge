package com.boot.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.boot.dto.EvChargerDTO;
import com.boot.service.EvChargerService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
//@Controller
public class SearchDataController {

	@Autowired
	private EvChargerService chargerService;

	@RequestMapping("/search_data")
	public List<EvChargerDTO> search_data(@RequestBody Map<String, Double> map) {
		log.info("search_data()");
		log.info("lat => " + map.get("lat"));
		Double lat = map.get("lat");
		Double lng = map.get("lng");

		List<EvChargerDTO> ev_list = new ArrayList<>();
		ev_list = chargerService.ev_list(lat, lng);
		log.info("ev_list => " + ev_list);

		return ev_list;
	}
}