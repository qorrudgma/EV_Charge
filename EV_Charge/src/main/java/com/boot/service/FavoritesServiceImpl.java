package com.boot.service;

import java.util.List;	

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.boot.dao.FavoritesDAO;
import com.boot.dto.FavoritesDTO;

@Service
public class FavoritesServiceImpl implements FavoritesService {

	@Autowired
	private SqlSession sqlSession;

	@Override
	public void addFavorite(FavoritesDTO dto) {
		sqlSession.getMapper(FavoritesDAO.class).addFavorite(dto);
	}

	@Override
	public void removeFavorite(FavoritesDTO dto) {
		sqlSession.getMapper(FavoritesDAO.class).removeFavorite(dto);
	}

	@Override
	public List<FavoritesDTO> getFavorites(FavoritesDTO dto) {
		return sqlSession.getMapper(FavoritesDAO.class).getFavorites(dto);
	}
}
