package com.boot;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cache.annotation.EnableCaching;

//redis
@EnableCaching
@SpringBootApplication
//@EnableElasticsearchRepositories(basePackages = "com.boot.elasticsearch")
public class EvChargeApplication {
	public static void main(String[] args) {
		SpringApplication.run(EvChargeApplication.class, args);
	}
}