package com.boot.dto;

import lombok.Data;

@Data
public class FavoriteDTO {
    private int userNo;
    private String stnAddr;
    private String stnPlace;
    private int rapidCnt;
    private int slowCnt;
    private String carType;
}
