package com.boot.elasticsearch;

import org.springframework.data.annotation.Id;
import org.springframework.data.elasticsearch.annotations.Document;
import org.springframework.data.elasticsearch.annotations.Field;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Document(indexName = "ev_chargers")
public class ElasticsearchDTO {

	@Id
	private String id;

	private String stat_id;
	private String chger_id;
	@Field(name = "stat_name")
	private String statName;
	private String chger_type;
	private String addr;
	private String addr_detail;
	private String location;
	private Double lat;
	private Double lng;
	private String use_time;
	private String busi_id;
	private String bnm;
	private String busi_nm;
	private String busi_call;
	private String output;
	private String method;
	private String zcode;
	private String zscode;
	private String kind;
	private String kind_detail;
	private String parking_free;
	private String note;
	private String limit_yn;
	private String limit_detail;
	private String del_yn;
	private String del_detail;
	private String traffic_yn;
	private int year;

}