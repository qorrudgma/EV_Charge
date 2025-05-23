package com.boot.elasticsearch;

import java.util.ArrayList;
import java.util.List;

import org.elasticsearch.common.unit.Fuzziness;
import org.elasticsearch.index.query.MatchQueryBuilder;
import org.elasticsearch.index.query.QueryBuilders;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.elasticsearch.core.ElasticsearchOperations;
import org.springframework.data.elasticsearch.core.SearchHits;
import org.springframework.data.elasticsearch.core.query.NativeSearchQuery;
import org.springframework.data.elasticsearch.core.query.NativeSearchQueryBuilder;
import org.springframework.stereotype.Service;

@Service
public class EvChargerSearchService {

	@Autowired
	private ElasticsearchOperations elasticsearchOperations;

	public List<ElasticsearchDTO> searchStatNameWithFuzziness(String keyword) {
		MatchQueryBuilder matchQuery = QueryBuilders.matchQuery("stat_name", keyword).fuzziness(Fuzziness.fromEdits(2));

		// 결과수 제한
		Pageable limit = PageRequest.of(0, 100);

		NativeSearchQuery searchQuery = new NativeSearchQueryBuilder().withQuery(matchQuery).withPageable(limit)
				.build();

		SearchHits<ElasticsearchDTO> searchHits = elasticsearchOperations.search(searchQuery, ElasticsearchDTO.class);

		List<ElasticsearchDTO> results = new ArrayList<>();
		searchHits.forEach(hit -> results.add(hit.getContent()));
		return results;
	}
}
