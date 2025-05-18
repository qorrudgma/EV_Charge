package com.boot.service;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.boot.dao.EvChargerDAO;
import com.boot.dto.EvChargerDTO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service("EvChargerService")
public class EvChargerServiceImpl implements EvChargerService {
	@Autowired
	private SqlSession sqlSession;

	@Override
	public void ev_charger_update(List<EvChargerDTO> ev_charger_data) {
		EvChargerDAO dao = sqlSession.getMapper(EvChargerDAO.class);
		for (EvChargerDTO dto : ev_charger_data) {
			dao.ev_charger_update(dto);
		}
	}

	// 경도위도 근처 충전소 정보
	@Override
	public List<EvChargerDTO> ev_list(Double lat, Double lng) {
		EvChargerDAO dao = sqlSession.getMapper(EvChargerDAO.class);
		List<EvChargerDTO> ev_list = new ArrayList<>();
		ev_list = dao.ev_list(lat, lng);

		return ev_list;
	}
}