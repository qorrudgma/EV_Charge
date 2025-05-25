package com.boot.reservation.service;

import java.util.List;

import com.boot.reservation.dto.ReservationDTO;

public interface ReservationService {
	public void insertReservation(String stat_id, int user_no, String reservation_date, String reservation_time,
			int duration_minutes);

	public int find_reservation_by_stat(String stat_id, String chger_id);

	public int find_reservation_by_user(int user_no);

	public List<ReservationDTO> find_reservation_by_reserve_date_stat(String reservation_date, String stat_id);

	public List<ReservationDTO> find_reservation_by_reserve_date(String reservation_date);
}
