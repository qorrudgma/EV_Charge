package com.boot.evelasticsearch;

import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

@Component
public class ElasticsearchTestRunner implements CommandLineRunner {

	private final SampleDocumentRepository repository;

	public ElasticsearchTestRunner(SampleDocumentRepository repository) {
		this.repository = repository;
	}

	@Override
	public void run(String... args) throws Exception {
		SampleDocument doc = new SampleDocument("1", "엘라스틱서치 연동 성공!");
		repository.save(doc);

		System.out.println("저장 완료!");
	}
}