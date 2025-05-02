package com.boot.dto;

import lombok.Data;

//불필요한 @JsonProperty 제거
@Data
public class FavoriteDTO {
 private int userNo;
 private String userId;
 private String stationAddress;
}

