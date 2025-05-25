package com.boot.reservation.dto;

import java.security.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ReservationDTO {
	private int reservation_id;
	private String stat_id;
	private int user_no;
	private String reservation_date;
	private String reservation_time;
	private int duration_minutes;
	private String status;
	private Timestamp created_at;
	private Timestamp updated_at;

}