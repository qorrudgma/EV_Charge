package com.boot.reservation.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.boot.reservation.dto.ReservationDTO;

public interface ReservationDAO {
	public void insertReservation(@Param("stat_id") String stat_id, @Param("user_no") int user_no,
			@Param("reservation_date") String reservation_date, @Param("reservation_time") String reservation_time,
			@Param("duration_minutes") int duration_minutes);

	public int find_reservation_by_stat(String stat_id, String chger_id);

	public int find_reservation_by_user(int user_no);

	public List<ReservationDTO> find_reservation_by_reserve_date_stat(
			@Param("reservation_date") String reservation_date, @Param("stat_id") String stat_id);

	public List<ReservationDTO> find_reservation_by_reserve_date(@Param("reservation_date") String reservation_date);
}
