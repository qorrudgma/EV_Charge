package com.boot.evelasticsearch;

import org.springframework.data.annotation.Id;
import org.springframework.data.elasticsearch.annotations.Document;

import lombok.Data;

@Data
@Document(indexName = "test-index")
public class SampleDocument {
	@Id
	private String id;
	private String message;

	public SampleDocument() {
	}

	public SampleDocument(String id, String message) {
		this.id = id;
		this.message = message;
	}
}