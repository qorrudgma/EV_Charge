package com.boot.elasticsearch;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
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

	@RequestMapping("/search")
	public ResponseEntity<List<ElasticsearchDTO>> search(@RequestBody Map<String, String> body) {
		String keyword = body.get("keyword");
		List<ElasticsearchDTO> results = searchService.searchStatNameWithFuzziness(keyword);
		log.info("@#$ keyword => " + keyword);

		return ResponseEntity.ok(results);
	}

}