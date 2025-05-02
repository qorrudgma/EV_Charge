package com.boot.service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.boot.dao.FavoriteDAO;
import com.boot.dto.FavoriteDTO;

@Service
public class FavoriteServiceImpl implements FavoriteService {
    
    @Autowired
    private FavoriteDAO favoriteDAO;

    @Override
    @Transactional
    public Map<String, Object> addFavorite(FavoriteDTO favorite) {
        Map<String, Object> result = new HashMap<>();
        
        // 중복 검사
        int duplicateCount = favoriteDAO.checkDuplicate(favorite);
        if(duplicateCount > 0) {
            result.put("status", "error");
            result.put("message", "이미 등록된 충전소입니다");
            return result;
        }
        
        // 등록 처리
        try {
            int insertResult = favoriteDAO.insertFavorite(favorite);
            result.put("status", insertResult > 0 ? "success" : "error");
            result.put("message", insertResult > 0 ? "등록 성공" : "등록 실패");
        } catch (Exception e) {
            result.put("status", "error");
            result.put("message", "데이터베이스 오류: " + e.getMessage());
        }
        return result;
    }
}
