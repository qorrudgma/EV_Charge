package com.boot.elasticsearch;

import org.springframework.data.annotation.Id;
import org.springframework.data.elasticsearch.annotations.Document;

import com.boot.dto.EvChargerDTO;

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
	private String stat_name;
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

	public ElasticsearchDTO(EvChargerDTO dto) {
		this.id = dto.getStat_id() + "_" + dto.getChger_id();
		this.stat_id = dto.getStat_id();
		this.chger_id = dto.getChger_id();
		this.stat_name = dto.getStat_name();
		this.chger_type = dto.getChger_type();
		this.addr = dto.getAddr();
		this.addr_detail = dto.getAddr_detail();
		this.location = dto.getLocation();
		this.lat = dto.getLat();
		this.lng = dto.getLng();
		this.use_time = dto.getUse_time();
		this.busi_id = dto.getBusi_id();
		this.bnm = dto.getBnm();
		this.busi_nm = dto.getBusi_nm();
		this.busi_call = dto.getBusi_call();
		this.output = dto.getOutput();
		this.method = dto.getMethod();
		this.zcode = dto.getZcode();
		this.zscode = dto.getZscode();
		this.kind = dto.getKind();
		this.kind_detail = dto.getKind_detail();
		this.parking_free = dto.getParking_free();
		this.note = dto.getNote();
		this.limit_yn = dto.getLimit_yn();
		this.limit_detail = dto.getLimit_detail();
		this.del_yn = dto.getDel_yn();
		this.del_detail = dto.getDel_detail();
		this.traffic_yn = dto.getTraffic_yn();
		this.year = dto.getYear();
	}
}