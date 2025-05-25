package com.boot.reservation.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.boot.reservation.dao.ReservationDAO;
import com.boot.reservation.dto.ReservationDTO;

@Service("ReservationService")
public class ReservationServiceImpl implements ReservationService {

	@Autowired
	private SqlSession sqlSession;

	@Override
	@Transactional
	public void insertReservation(String stat_id, int user_no, String reservation_date, String reservation_time,
			int duration_minutes) {
		ReservationDAO dao = sqlSession.getMapper(ReservationDAO.class);

		dao.insertReservation(stat_id, user_no, reservation_date, reservation_time, duration_minutes);
	}

	@Override
	public int find_reservation_by_stat(String stat_id, String chger_id) {
		ReservationDAO dao = sqlSession.getMapper(ReservationDAO.class);
		int count = dao.find_reservation_by_stat(stat_id, chger_id);
		return count;
	}

	@Override
	public int find_reservation_by_user(int user_no) {
		ReservationDAO dao = sqlSession.getMapper(ReservationDAO.class);
		int count = dao.find_reservation_by_user(user_no);
		return count;
	}

	@Override
	public List<ReservationDTO> find_reservation_by_reserve_date(String reservation_date) {
		ReservationDAO dao = sqlSession.getMapper(ReservationDAO.class);
		List<ReservationDTO> reservation_list = dao.find_reservation_by_reserve_date(reservation_date);
		return reservation_list;
	}

	@Override
	public List<ReservationDTO> find_reservation_by_reserve_date_stat(String reservation_date, String stat_id) {
		ReservationDAO dao = sqlSession.getMapper(ReservationDAO.class);
		List<ReservationDTO> reservation_list = dao.find_reservation_by_reserve_date_stat(reservation_date, stat_id);
		return reservation_list;
	}

}
