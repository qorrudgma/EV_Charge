package com.boot.service;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.boot.dto.FavoriteDTO;

@Service
public class FavoriteService {

	@Autowired
	private SqlSession sqlSession;

	public void addFavorite(FavoriteDTO favorite) {
		sqlSession.insert("FavoriteMapper.insertFavorite", favorite);
	}
}