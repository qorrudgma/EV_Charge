package com.boot;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cache.annotation.EnableCaching;

//redis
@EnableCaching
@SpringBootApplication
@MapperScan("com.boot.elasticsearch")
@MapperScan("com.boot.favorite.dao")
public class EvChargeApplication {
	public static void main(String[] args) {
		SpringApplication.run(EvChargeApplication.class, args);
	}
}