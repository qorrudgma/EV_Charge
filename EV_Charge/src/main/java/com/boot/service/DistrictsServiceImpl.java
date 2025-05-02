package com.boot.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.boot.dao.DistrictsDAO;
import com.boot.dto.DistrictsDTO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service("DistrictsService")
public class DistrictsServiceImpl implements DistrictsService {
	@Autowired
	private SqlSession sqlSession;

	@Override
	public List<DistrictsDTO> getDistricts(String provinces_code) {
		DistrictsDAO dao = sqlSession.getMapper(DistrictsDAO.class);
		List<DistrictsDTO> districts_list = dao.getDistricts(provinces_code);

		return districts_list;
	}
}