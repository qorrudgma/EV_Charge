package com.boot.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.boot.dao.ProvincesDAO;
import com.boot.dto.ProvincesDTO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service("ProvincesService")
public class ProvincesServiceImpl implements ProvincesService {
	@Autowired
	private SqlSession sqlSession;

	@Override
	public List<ProvincesDTO> getAllProvinces() {
		ProvincesDAO dao = sqlSession.getMapper(ProvincesDAO.class);
		List<ProvincesDTO> provinces_list = dao.getAllProvinces();

		return provinces_list;
	}

	@Override
	public String getProvincesCode(String metroCd) {
		ProvincesDAO dao = sqlSession.getMapper(ProvincesDAO.class);
		String provinces_code = dao.getProvincesCode(metroCd);

		return provinces_code;
	}
}