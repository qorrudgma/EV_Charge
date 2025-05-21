package com.boot.reservation.dto;

import java.security.Timestamp;
import java.sql.Date;
import java.sql.Time;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ReservationDTO {
	private int reservation_id;
	private int station_id;
	private int user_no;
	private int charger_id;
	private Date reservation_date;
	private Time reservation_time;
	private int duration_minutes;
	private String status;
	private Timestamp created_at;
	private Timestamp updated_at;

}
