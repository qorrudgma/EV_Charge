package com.boot.elasticsearch;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class EvChargerSyncService {

	@Autowired
	private EvChargerMapper evChargerMapper; // 이제 List<ElasticsearchDTO> 반환

	@Autowired
	private EvChargerRepository elasticsearchRepository;

	public void syncAllDataToElasticsearch() {
		// MyBatis에서 바로 ElasticsearchDTO 리스트 가져오기
		List<ElasticsearchDTO> elasticsearchDTOList = evChargerMapper.selectAll();

		int batchSize = 1000;
		for (int i = 0; i < elasticsearchDTOList.size(); i += batchSize) {
			int end = Math.min(i + batchSize, elasticsearchDTOList.size());
			List<ElasticsearchDTO> batch = elasticsearchDTOList.subList(i, end);
			if (i == 1) {
				log.info("!@#$!@#$" + batch);
			}
			try {
				elasticsearchRepository.saveAll(batch);
			} catch (Exception e) {
				log.error("Error saving batch from {} to {}", i, end, e);
			}
		}
	}

}