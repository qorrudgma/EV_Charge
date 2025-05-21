package com.boot.reservation.controller;

import java.util.LinkedHashMap;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class ReservationController {

	@RequestMapping("/chart")
	public String chart() {
		return "chart";
	}

	@GetMapping("/reservation/data")
	@ResponseBody
	public Map<String, Integer> getReservationData() {
		Map<String, Integer> data = new LinkedHashMap<>();
		data.put("09:00", 5);
		data.put("09:30", 7);
		data.put("10:00", 3);
		data.put("10:30", 10);
		data.put("11:00", 12);
		data.put("11:30", 6);
		return data;
	}
}
