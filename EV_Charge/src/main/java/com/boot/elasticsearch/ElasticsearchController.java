package com.boot.elasticsearch;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequiredArgsConstructor
public class ElasticsearchController {

	@Autowired
	private EvChargerSearchService searchService;

	private final EvChargerSyncService syncService;

	@GetMapping("/sync")
	public String sync() {
		syncService.syncAllDataToElasticsearch();
		return "sync complete";
	}

	@GetMapping("/search")
	public ResponseEntity<List<ElasticsearchDTO>> search(@RequestParam String keyword) {
		List<ElasticsearchDTO> results = searchService.searchStatNameWithFuzziness(keyword);
		log.info("@#$ keyword => " + keyword);

		return ResponseEntity.ok(results);
	}

}