package com.boot.favorite.dto;

import lombok.Data;

@Data
public class FavoriteRequestDTO {
    private int user_no;
    private String stat_id;
    private String stat_name;
    private String addr;
    private String addr_detail;
    private String location;
    private Double lat;
    private Double lng;
}