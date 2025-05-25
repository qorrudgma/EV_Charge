package com.boot.favorite.dto;

import java.sql.Timestamp;
import lombok.Data;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class FavoriteDTO {
    private int favorite_id;
    private int user_no;
    private String stat_id;
    private String addr;
    private String addr_detail;
    private String location;
    private Double lat;
    private Double lng;
    private Timestamp created_at;

    // 충전소 상세정보 필드 (기존)
    private String stat_name;
    private String use_time;
    private String parking_free;
    private String bnm;           // 기관명
    private String busi_call;

    // --- 여기에 필드 추가 ---
    private String busi_nm;       // 운영기관명 (JSP에서 사용 중)

    // 충전기 정보 및 사용 현황 (충전소 단위 집계 정보)
    private Integer fastChargerCount;       // 급속 충전기 총 개수
    private Integer availableFastChargers;  // 사용 가능한 급속 충전기 개수
    private Integer slowChargerCount;       // 완속 충전기 총 개수
    private Integer availableSlowChargers;  // 사용 가능한 완속 충전기 개수

    // 충전기 타입 상세 정보 (가공된 문자열 형태)
    private String fastChargerTypeInfo;  // 예: "BC타입 (7핀, AC 완속)"
    private String slowChargerTypeInfo;  // 예: "C타입 (5핀, AC 완속)"
}