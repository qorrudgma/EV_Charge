package com.boot.dto;

import java.io.Serializable;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class EvChargerDTO implements Serializable{
	private int ev_charger_id; 		// 자동증가 기본키
	private String stat_id; 		// 충전소ID
	private String chger_id; 		// 충전기ID
	private String stat_name; 		// 충전소명
	private String chger_type;		// 충전기타입
	private String addr; 			// 주소
	private String addr_detail; 	// 주소상세
	private String location; 		// 상세위치
	private Double lat; 			// 위도
	private Double lng; 			// 경도
	private String use_time; 		// 이용가능시간
	private String busi_id; 		// 기관 아이디
	private String bnm; 			// 기관명
	private String busi_nm; 		// 운영기관명
	private String busi_call; 		// 운영기관연락처
	private String output;			// 충전용량
	private String method; 			// 충전방식
	private String zcode; 			// 지역코드
	private String zscode; 			// 지역구분 상세 코드
	private String kind; 			// 충전소 구분 코드
	private String kind_detail; 	// 충전소 구분 상세코드
	private String parking_free; 	// 주차료무료 (Y/N)
	private String note; 			// 충전소 안내
	private String limit_yn; 		// 이용자 제한 여부 (Y/N)
	private String limit_detail; 	// 이용제한 사유
	private String del_yn; 			// 삭제 여부 (Y/N)
	private String del_detail; 		// 삭제 사유
	private String traffic_yn;	 	// 편의제공 여부 (Y/N)
	private int year; 				// 설치년도
}