package com.boot.elasticsearch;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class SampleService {

	@Autowired
	private SampleDocumentRepository repository;

	public void saveSample() {
		SampleDocument doc = new SampleDocument("1", "Hello Elasticsearch");
		repository.save(doc);
	}
}