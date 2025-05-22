package com.boot.elasticsearch;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class SampleController {

	@Autowired
	private SampleService sampleService;

	@GetMapping("/sample")
	public String saveSample() {
		sampleService.saveSample();
		return "Saved sample document!";
	}
}