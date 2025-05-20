package com.boot.elasticsearch;

import org.springframework.data.elasticsearch.repository.ElasticsearchRepository;

public interface EvChargerRepository extends ElasticsearchRepository<ElasticsearchDTO, String> {
}