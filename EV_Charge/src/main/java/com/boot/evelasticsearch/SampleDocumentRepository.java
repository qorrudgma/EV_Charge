package com.boot.evelasticsearch;

import org.springframework.data.elasticsearch.repository.ElasticsearchRepository;

public interface SampleDocumentRepository extends ElasticsearchRepository<SampleDocument, String> {
}