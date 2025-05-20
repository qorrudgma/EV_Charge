package com.boot.spark;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/spark")
public class SparkController {

	private SparkService sparkService;

	public SparkController(SparkServiceImpl sparkService) {
		this.sparkService = sparkService;
	}

	@GetMapping("/test")
	public String testSpark() throws Exception {

		return "Spark job executed!";
	}
}
