package com.boot.service;

import com.boot.dto.FavoriteDTO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
}
