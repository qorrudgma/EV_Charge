package com.boot.elasticsearch;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.elasticsearch.common.unit.Fuzziness;
import org.elasticsearch.index.query.BoolQueryBuilder;
import org.elasticsearch.index.query.MatchQueryBuilder;
import org.elasticsearch.index.query.QueryBuilders;
import org.openkoreantext.processor.OpenKoreanTextProcessorJava;
import org.openkoreantext.processor.tokenizer.KoreanTokenizer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.elasticsearch.core.ElasticsearchOperations;
import org.springframework.data.elasticsearch.core.SearchHits;
import org.springframework.data.elasticsearch.core.query.NativeSearchQuery;
import org.springframework.data.elasticsearch.core.query.NativeSearchQueryBuilder;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;
import scala.collection.Seq;

@Slf4j
@Service
public class EvChargerSearchService {

	@Autowired
	private ElasticsearchOperations elasticsearchOperations;

	@Autowired
	private KeyboardMapper keyboardMapper;

	@Autowired
	private HangulComposer hangulComposer;

	public List<ElasticsearchDTO> searchStatNameWithFuzziness(String keyword) {
		log.info("keyword(입력한 데이터) => " + keyword);

		// 한영키
		keyword = keyboardMapper.convertEngToKor(keyword);
		// 위에서 변환한거 합치기
		keyword = hangulComposer.combine(keyword);

		// 형태소 분석
		CharSequence normalized = OpenKoreanTextProcessorJava.normalize(keyword);
		log.info("normalized => " + normalized);
		Seq<KoreanTokenizer.KoreanToken> tokens = OpenKoreanTextProcessorJava.tokenize(normalized);
		log.info("tokens(토큰으로 나누기) => " + tokens);
		List<String> tokenList = OpenKoreanTextProcessorJava.tokensToJavaStringList(tokens);
		log.info("tokenList(분리된 입력값) => " + tokenList);

		// 지역 조합 로직
		Set<String> matchedRegions = new HashSet<>();
//		Set<Integer> usedTokenIndexes = new HashSet<>();

		int n = tokenList.size();

//		for (int i = 0; i < n; i++) {
//			StringBuilder sb = new StringBuilder();
//			for (int j = i; j < n && j - i < 3; j++) { // 최대 3개까지 붙이기
//				sb.append(tokenList.get(j));
//				String candidate = sb.toString();
////				log.info("candidate => " + candidate);
////				if (candidate.length() >= 2 && regionDictionary.contains(candidate)) {
//				if (candidate.length() >= 2) {
//					log.info("candidate => " + candidate);
//					matchedRegions.add(candidate);
//				}
//			}
//		}
		for (int i = 0; i < n; i++) {
			StringBuilder sb = new StringBuilder();
			for (int j = i; j < n && j - i < 3; j++) {
				sb.append(tokenList.get(j));
				String candidate = sb.toString();

				if (candidate.length() >= 2) {
//					log.info("두글자 이상");
					MatchQueryBuilder matchQuery = QueryBuilders.matchQuery("name", candidate)
//							.fuzziness(Fuzziness.fromEdits(1));
							.fuzziness(Fuzziness.fromEdits(1));

					Pageable limit = PageRequest.of(0, 1);

					NativeSearchQuery searchQuery = new NativeSearchQueryBuilder().withQuery(matchQuery)
							.withPageable(limit).build();

					SearchHits<RegionDTO> searchHits = elasticsearchOperations.search(searchQuery, RegionDTO.class);

					if (!searchHits.isEmpty()) {
						// 첫 번째 결과 가져오기
						RegionDTO region = searchHits.getSearchHit(0).getContent();
//						log.info("region => " + region);
						String regionName = region.getRegion();
//						log.info("regionName => " + regionName);
						matchedRegions.add(regionName);
						// 여기서 keyword - candidate
						keyword = keyword.replaceFirst(candidate, "").trim();
						log.info("keyword - candidate => " + keyword);
//						for (int k = i; k <= j; k++) {
//							usedTokenIndexes.add(k);
//						}
						break;
					}
				}
			}
		}

//		List<String> remainingKeywords = new ArrayList<>();
//		for (int i = 0; i < tokenList.size(); i++) {
//			if (!usedTokenIndexes.contains(i)) {
//				remainingKeywords.add(tokenList.get(i));
//			}
//		}

		log.info("matchedRegions => " + matchedRegions);
//		log.info("remainingKeywords => " + remainingKeywords);

//		MatchQueryBuilder matchQuery = QueryBuilders.matchQuery("stat_name", keyword).fuzziness(Fuzziness.fromEdits(2));
//
//		// 결과수 제한
//		Pageable limit = PageRequest.of(0, 100);
//
//		NativeSearchQuery searchQuery = new NativeSearchQueryBuilder().withQuery(matchQuery).withPageable(limit)
//				.build();
//
//		SearchHits<ElasticsearchDTO> searchHits = elasticsearchOperations.search(searchQuery, ElasticsearchDTO.class);
//
//		List<ElasticsearchDTO> results = new ArrayList<>();
//		searchHits.forEach(hit -> results.add(hit.getContent()));
//		return results;
		// 지역 필터
		BoolQueryBuilder regionShouldQuery = QueryBuilders.boolQuery();
		for (String region : matchedRegions) {
//			regionShouldQuery.should(QueryBuilders.matchQuery("addr", region).fuzziness(Fuzziness.fromEdits(1)));
			regionShouldQuery.should(QueryBuilders.matchPhrasePrefixQuery("addr", region));

		}

		// stat_name 필터 (나머지 키워드를 하나의 문장으로 결합해서 검색)
		BoolQueryBuilder boolQuery = QueryBuilders.boolQuery().must(regionShouldQuery);

//		if (!remainingKeywords.isEmpty()) {
		if (!keyword.isEmpty()) {
//			String remaining = String.join(" ", remainingKeywords);
//			boolQuery.must(QueryBuilders.matchQuery("stat_name", remaining).fuzziness(Fuzziness.fromEdits(1)));
			log.info("!@#$ " + keyword);
			boolQuery.must(QueryBuilders.matchQuery("stat_name", keyword).fuzziness(Fuzziness.fromEdits(1)));
		}

		// 실행
		Pageable limit = PageRequest.of(0, 100);
		NativeSearchQuery searchQuery = new NativeSearchQueryBuilder().withQuery(boolQuery).withPageable(limit).build();

		SearchHits<ElasticsearchDTO> searchHits = elasticsearchOperations.search(searchQuery, ElasticsearchDTO.class);

		List<ElasticsearchDTO> results = new ArrayList<>();
		searchHits.forEach(hit -> results.add(hit.getContent()));
		return results;
	}
}