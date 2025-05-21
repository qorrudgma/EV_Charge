package com.boot.elasticsearch;

import java.util.List;

import org.springframework.data.elasticsearch.repository.ElasticsearchRepository;

public interface EvChargerRepository extends ElasticsearchRepository<ElasticsearchDTO, String> {
	List<ElasticsearchDTO> findBystatNameContaining(String statName);
}
