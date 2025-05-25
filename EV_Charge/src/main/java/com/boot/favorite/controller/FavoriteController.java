package com.boot.favorite.controller;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.boot.dto.MemberDTO;
import com.boot.favorite.dto.FavoriteDTO;
import com.boot.favorite.dto.FavoriteRequestDTO;
import com.boot.favorite.service.FavoriteService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class FavoriteController {

    @Autowired
    private FavoriteService favoriteService;

//    @PostMapping("/favorites/toggle")
//    @ResponseBody
//    public ResponseEntity<Map<String, Object>> toggleFavorite(@RequestBody FavoriteRequestDTO favoriteRequest, HttpSession session) {
//        log.info("즐겨찾기 토글 요청 수신: {}", favoriteRequest); 
//        MemberDTO loginUser = (MemberDTO) session.getAttribute("user");
//        if (loginUser == null) {
//            return ResponseEntity.status(401).body(Map.of("status", "error", "message", "로그인이 필요합니다."));
//        }
//        if (loginUser.getUser_no() != favoriteRequest.getUser_no()) {
//            return ResponseEntity.status(403).body(Map.of("status", "error", "message", "권한이 없습니다."));
//        }
//
//        Map<String, Object> result = favoriteService.toggleFavorite(favoriteRequest);
//        return ResponseEntity.ok(result);
//    }
    @PostMapping("/favorites/toggle")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> toggleFavorite(@RequestBody FavoriteRequestDTO favoriteRequest, HttpSession session) {
        log.info("즐겨찾기 토글 요청 수신: {}", favoriteRequest);
        MemberDTO loginUser = (MemberDTO) session.getAttribute("user");

        if (loginUser == null) {
            log.warn("/favorites/toggle: 비로그인 사용자의 접근 시도.");
            return ResponseEntity.status(401).body(Map.of("status", "error", "message", "로그인이 필요합니다."));
        }
        // 요청의 user_no와 세션의 user_no가 일치하는지 확인 (보안 강화)
        if (loginUser.getUser_no() != favoriteRequest.getUser_no()) {
            log.warn("/favorites/toggle: 요청된 user_no({})와 세션 user_no({}) 불일치.", favoriteRequest.getUser_no(), loginUser.getUser_no());
            return ResponseEntity.status(403).body(Map.of("status", "error", "message", "권한이 없습니다."));
        }

        Map<String, Object> result;
        try {
            result = favoriteService.toggleFavorite(favoriteRequest); // 이 메소드는 추가/삭제 후 그 결과를 Map으로 반환한다고 가정

            if (result != null && "success".equals(result.get("status"))) { // 서비스 메소드가 성공 상태를 반환한다고 가정
                log.info("즐겨찾기 토글 DB 작업 성공. 사용자 {}의 세션 즐겨찾기 목록 갱신 시도.", loginUser.getUser_id());
                try {
                    // DB에서 해당 사용자의 최신 즐겨찾기 ID 목록을 다시 조회
                    Set<String> updatedFavoriteIds = favoriteService.getFavoriteStationIdsByUserNo(loginUser.getUser_no());
                    
                    if (updatedFavoriteIds == null) {
                        log.error("@# [토글 후 세션 갱신 오류] FavoriteService가 사용자 {}에 대해 null을 반환! 빈 Set으로 세션 저장.", loginUser.getUser_id());
                        session.setAttribute("userFavoriteStationIds", Collections.emptySet());
                    } else {
                        session.setAttribute("userFavoriteStationIds", updatedFavoriteIds);
                        log.info("@# [토글 후 세션 갱신] 사용자 {}의 즐겨찾기 ID 목록 ({}개) 세션에 갱신 완료: {}", loginUser.getUser_id(), updatedFavoriteIds.size(), updatedFavoriteIds);
                    }
                } catch (Exception e_session_update) {
                    log.error("@# [토글 후 세션 갱신] 사용자 {}의 즐겨찾기 목록 세션에 갱신 중 오류 발생", loginUser.getUser_id(), e_session_update);
                }
            } else {
                log.warn("즐겨찾기 토글 DB 작업 실패 또는 서비스에서 성공 상태 반환 안 함. result: {}", result);
                if (result == null) {
                     result = Map.of("status", "error", "message", "즐겨찾기 처리 중 서버 내부 오류가 발생했습니다.");
                     return ResponseEntity.status(500).body(result);
                }
            }
            return ResponseEntity.ok(result);

        } catch (Exception e) {
            log.error("즐겨찾기 토글 처리 중 예외 발생: {}", favoriteRequest, e);
            return ResponseEntity.status(500).body(Map.of("status", "error", "message", "즐겨찾기 처리 중 오류가 발생했습니다."));
        }
    }
    

    // 기존 /favorites/list GET 매핑 (JSON 응답, 사이드바용) - AJAX 호출용
    @GetMapping("/favorites/list")
    @ResponseBody // JSON 응답
    public ResponseEntity<?> getUserFavoritesForSidebar(HttpSession session) {
        MemberDTO loginUser = (MemberDTO) session.getAttribute("user");
        if (loginUser == null) {
            return ResponseEntity.status(401).body(Map.of("status", "error", "message", "로그인이 필요합니다."));
        }
        try {
            List<FavoriteDTO> favoriteList = favoriteService.getFavoriteDetailsList(loginUser.getUser_no());
            return ResponseEntity.ok(favoriteList);
        } catch (Exception e) {
            log.error("Error fetching favorites list for sidebar for user {}: {}", loginUser.getUser_no(), e.getMessage());
            return ResponseEntity.status(500).body(Map.of("status", "error", "message", "목록 조회 중 오류 발생"));
        }
    }


    // --- 새로운 즐겨찾기 페이지를 위한 GET 매핑 ---
    @RequestMapping("/favorites") // header.jsp의 링크 경로와 일치
    public String showFavoritesPage(HttpSession session, Model model) {
        MemberDTO loginUser = (MemberDTO) session.getAttribute("user");

        if (loginUser == null) {
            return "redirect:/login";
        }

        try {
            List<FavoriteDTO> favoritesList = favoriteService.getFavoriteDetailsList(loginUser.getUser_no());
            model.addAttribute("favoritesList", favoritesList);
            model.addAttribute("pageTitle", "나의 즐겨찾기"); // 페이지 제목 설정
        } catch (Exception e) {
            log.error("Error fetching favorites page for user {}: {}", loginUser.getUser_no(), e.getMessage(), e);
            model.addAttribute("errorMessage", "즐겨찾기 목록을 불러오는 중 오류가 발생했습니다.");
            model.addAttribute("favoritesList", new ArrayList<FavoriteDTO>()); // 오류 시 빈 리스트 전달
        }
        
        return "favorites_page";
    }
    
//    @GetMapping("/favorites/markerInfo")
//    @ResponseBody
//    public ResponseEntity<?> getFavoriteDetailForMap(String statId, HttpSession session) {
//        MemberDTO loginUser = (MemberDTO) session.getAttribute("user");
//        if (loginUser == null) {
//            return ResponseEntity.status(401).body(Map.of("status", "error", "message", "로그인이 필요합니다."));
//        }
//
//        try {
//            FavoriteDTO dto = favoriteService.getFavoriteDetailByStatId(loginUser.getUser_no(), statId);
//            if (dto != null) {
//                return ResponseEntity.ok(List.of(dto)); // 항상 배열로 반환 (addMarker_two가 배열 기대)
//            } else {
//                return ResponseEntity.status(404).body(Map.of("status", "error", "message", "충전소 정보를 찾을 수 없습니다."));
//            }
//        } catch (Exception e) {
//            return ResponseEntity.status(500).body(Map.of("status", "error", "message", "오류 발생"));
//        }
//    }
    
    @GetMapping("/favorites/markerInfo") // 또는 API 경로를 /station/markerInfo 등으로 변경 고려
    @ResponseBody
    public ResponseEntity<?> getStationDetailForMap(String statId, HttpSession session) { // 메소드명도 변경 고려
        MemberDTO loginUser = (MemberDTO) session.getAttribute("user"); // 로그인 정보는 즐겨찾기 여부 표시에 사용 가능

        try {
            // 서비스 계층에서 statId로 충전소 상세 정보(FavoriteDTO 구조)를 가져오는 메소드 호출
            FavoriteDTO dto = favoriteService.getStationDetailByStatId(statId); // 새로운 서비스 메소드
            log.info("getStationDetailByStatId 결과 DTO: {}", dto);

            if (dto != null) {
                // 만약 로그인한 사용자라면, 이 충전소가 즐겨찾기 되어 있는지 여부를 확인해서 DTO에 추가 정보를 세팅할 수 있음
                // 예: if (loginUser != null) { boolean isFavorite = favoriteService.isUserFavorite(loginUser.getUser_no(), statId); dto.setFavorite(isFavorite); }
                // (FavoriteDTO에 isFavorite 같은 필드 추가 필요)

                return ResponseEntity.ok(List.of(dto)); // 배열 형태로 반환
            } else {
                return ResponseEntity.status(404).body(Map.of("status", "error", "message", "충전소 정보를 찾을 수 없습니다."));
            }
        } catch (Exception e) {
            log.error("충전소 상세 조회 중 오류, stat_id: " + statId, e);
            return ResponseEntity.status(500).body(Map.of("status", "error", "message", "오류 발생"));
        }
    }
    
    @RequestMapping("/favorite_page")
    public String favorite_page() {
		return "favorite_page";
	}


}