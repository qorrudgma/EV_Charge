package com.boot.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.boot.dto.FavoriteDTO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class FavoriteService {

	@Autowired
	private SqlSession sqlSession;

	public void addFavorite(FavoriteDTO favorite) {
		sqlSession.insert("FavoriteMapper.insertFavorite", favorite);
	}

	// 삭제 메소드
	public void deleteFavorite(FavoriteDTO favorite) {
		sqlSession.delete("FavoriteMapper.deleteFavorite", favorite);
	}

	public List<FavoriteDTO> getFavoritesByUserNo(int user_no) {
		log.info("FavoriteService userNo => " + user_no);
		log.info("return => " + sqlSession.selectList("FavoriteMapper.getFavoritesByUserNo", user_no));
		return sqlSession.selectList("FavoriteMapper.getFavoritesByUserNo", user_no);
	}
}
