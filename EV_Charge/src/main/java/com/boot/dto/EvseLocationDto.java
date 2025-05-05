package com.boot.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class EvseLocationDto {
	private String stationId;
	private String stationName;
	private String stationAddress;
	private double evseLocationLatitude;
	private double evseLocationLongitude;
	private String rapid;
	private String slow;
	private String car;
}