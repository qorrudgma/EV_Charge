package com.boot.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class FavoriteDTO {
	private int user_no;
	private String stnAddr;
	private String stnPlace;
	private int rapidCnt;
	private int slowCnt;
	private String carType;
}
