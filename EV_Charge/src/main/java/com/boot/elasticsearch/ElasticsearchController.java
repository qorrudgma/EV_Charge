package com.boot.elasticsearch;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequiredArgsConstructor
public class ElasticsearchController {

	private final EvChargerSyncService syncService;

	@GetMapping("/sync")
	public String sync() {
		syncService.syncAllDataToElasticsearch();
		return "sync complete";
	}
}
