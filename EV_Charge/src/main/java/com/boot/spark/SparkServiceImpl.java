package com.boot.spark;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.boot.dto.EvChargerDTO;
import com.boot.reservation.dto.ReservationDTO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service("SparkService")
public class SparkServiceImpl implements SparkService {

	@Autowired
	private SqlSession sqlSession;

	@Override
	public List<EvChargerDTO> select_data_by_stat(String stat_id) {
		SparkDAO dao = sqlSession.getMapper(SparkDAO.class);
		List<EvChargerDTO> dtos = dao.select_data_by_stat(stat_id);

		return dtos;
	}

	@Override
	public List<EvChargerDTO> select_stats_by_addr(String addr) {
		SparkDAO dao = sqlSession.getMapper(SparkDAO.class);
		List<EvChargerDTO> dtos = dao.select_stats_by_addr(addr);
		return dtos;
	}

	@Override
	public List<ReservationDTO> select_reserve_by_stat_id(String stat_id) {
		SparkDAO dao = sqlSession.getMapper(SparkDAO.class);
		List<ReservationDTO> dtos = dao.select_reserve_by_stat_id(stat_id);
		return dtos;
	}

}
