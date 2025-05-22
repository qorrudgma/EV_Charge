package com.boot.elasticsearch;

import org.springframework.data.elasticsearch.repository.ElasticsearchRepository;

public interface SampleDocumentRepository extends ElasticsearchRepository<SampleDocument, String> {
}