package com.boot.controller;

import java.util.Collections;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.boot.dto.FavoriteDTO;
import com.boot.service.FavoriteService;

@RestController
@RequestMapping("/api/favorites")
public class FavoriteController {
    
    @Autowired
    private FavoriteService favoriteService;

 // FavoriteController.java 수정
    @PostMapping
    public ResponseEntity<?> addFavorite(
        @RequestBody FavoriteDTO favoriteDto,
        HttpSession session) {

        // 세션 검증 강화
        String userId = (String) session.getAttribute("userId");
        if(userId == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                .body(Collections.singletonMap("error", "로그인 후 이용 가능합니다"));
        }
        
        // 필수 필드 검증
        if(favoriteDto.getStationAddress() == null || favoriteDto.getStationAddress().isEmpty()) {
            return ResponseEntity.badRequest()
                .body(Collections.singletonMap("error", "충전소 정보가 유효하지 않습니다"));
        }

        favoriteDto.setUserId(userId);
        Map<String, Object> result = favoriteService.addFavorite(favoriteDto);
        
        return ResponseEntity.ok(result);
    }

}
