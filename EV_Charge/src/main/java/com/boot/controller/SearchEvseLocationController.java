package com.boot.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.boot.dto.EvseLocationDto;
import com.boot.dto.MemberDTO;
import com.boot.dto.SearchStationsDto;
import com.boot.service.SearchEvseLocationService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
public class SearchEvseLocationController {

	private final SearchEvseLocationService searchEvseLocationService;

	@GetMapping("/sidebar")
	@ResponseBody
	public List<EvseLocationDto> searchNearbyStations(@RequestParam("address") String address,
			@RequestParam("radiusKm") String radiusKm, Model model, HttpServletRequest request) {
		SearchStationsDto dto = new SearchStationsDto();
		log.info("@# address => " + address);
		dto.setAddress(address);
		dto.setRadiusKm(Integer.parseInt(radiusKm));

		List<EvseLocationDto> ELList = searchEvseLocationService.searchNearbyStations(dto);
		model.addAttribute("stationList", ELList);

		HttpSession session = request.getSession();
		MemberDTO user_sto = (MemberDTO) session.getAttribute("user");

		log.info("@# user_sto => " + user_sto);
		log.info("@# ELList =>" + ELList);
		return ELList;
	}
}