//package com.boot.elasticsearch;
//
//import javax.annotation.PreDestroy;
//
//import org.apache.http.HttpHost;
//import org.elasticsearch.client.RestClient;
//import org.springframework.beans.factory.annotation.Value;
//import org.springframework.context.annotation.Bean;
//import org.springframework.context.annotation.Configuration;
//
//import co.elastic.clients.elasticsearch.ElasticsearchClient;
//import co.elastic.clients.json.jackson.JacksonJsonpMapper;
//import co.elastic.clients.transport.rest_client.RestClientTransport;
//
//@Configuration
//public class ElasticSearchConfig {
//
//	@Value("${spring.elasticsearch.rest.uris}")
//	private String elasticsearchUris;
//
//	@Value("${spring.elasticsearch.rest.username}")
//	private String username;
//
//	@Value("${spring.elasticsearch.rest.password}")
//	private String password;
//
//	private RestClient restClient;
//
//	@Bean
//	public ElasticsearchClient elasticsearchClient() {
//		// URI에서 호스트랑 포트 추출 (예: http://localhost:9200)
//		HttpHost httpHost = HttpHost.create(elasticsearchUris);
//
//		// RestClient 생성 (인증정보 포함)
//		restClient = RestClient.builder(httpHost).setHttpClientConfigCallback(
//				httpClientBuilder -> httpClientBuilder.setDefaultCredentialsProvider(credentialsProvider -> {
//					credentialsProvider.setCredentials(
//							new org.apache.http.auth.AuthScope(httpHost.getHostName(), httpHost.getPort()),
//							new org.apache.http.auth.UsernamePasswordCredentials(username, password));
//				})).build();
//
//		// Transport 생성 (JacksonJsonpMapper로 JSON 처리)
//		RestClientTransport transport = new RestClientTransport(restClient, new JacksonJsonpMapper());
//
//		// ElasticsearchClient 생성 및 반환
//		return new ElasticsearchClient(transport);
//	}
//
//	@PreDestroy
//	public void close() throws Exception {
//		if (restClient != null) {
//			restClient.close();
//		}
//	}
//}
