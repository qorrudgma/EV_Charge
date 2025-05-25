package com.boot.favorite.service;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional; // Important for data consistency

import com.boot.favorite.dao.FavoriteDAO;
import com.boot.favorite.dto.FavoriteDTO;
import com.boot.favorite.dto.FavoriteRequestDTO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class FavoriteServiceImpl implements FavoriteService {

    @Autowired
    private FavoriteDAO favoriteDAO;

    @Override
    @Transactional // Ensures the whole operation is a single transaction
    public Map<String, Object> toggleFavorite(FavoriteRequestDTO favoriteRequest) {
        Map<String, Object> response = new HashMap<>();
        Map<String, Object> params = new HashMap<>();
        params.put("user_no", favoriteRequest.getUser_no());
        params.put("stat_id", favoriteRequest.getStat_id());

        FavoriteDTO existingFavorite = favoriteDAO.findFavorite(params);

        if (existingFavorite != null) {
            // Favorite exists, so remove it
            int deletedRows = favoriteDAO.deleteFavorite(params);
            if (deletedRows > 0) {
                response.put("status", "success");
                response.put("action", "removed");
                response.put("message", "즐겨찾기에서 삭제되었습니다.");
            } else {
                response.put("status", "error");
                response.put("message", "즐겨찾기 삭제에 실패했습니다.");
            }
        } else {
            // Favorite does not exist, so add it
            FavoriteDTO newFavorite = new FavoriteDTO();
            newFavorite.setUser_no(favoriteRequest.getUser_no());
            newFavorite.setStat_id(favoriteRequest.getStat_id());
            newFavorite.setStat_name(favoriteRequest.getStat_name());
            newFavorite.setAddr(favoriteRequest.getAddr());
            newFavorite.setAddr_detail(favoriteRequest.getAddr_detail());
            newFavorite.setLocation(favoriteRequest.getLocation());
            newFavorite.setLat(favoriteRequest.getLat());
            newFavorite.setLng(favoriteRequest.getLng());

            int insertedRows = favoriteDAO.insertFavorite(newFavorite);
            if (insertedRows > 0) {
                response.put("status", "success");
                response.put("action", "added");
                response.put("message", "즐겨찾기에 추가되었습니다.");
            } else {
                response.put("status", "error");
                response.put("message", "즐겨찾기 추가에 실패했습니다.");
            }
        }
        return response;
    }
    
    @Override
    public List<FavoriteDTO> getFavoriteDetailsList(int user_no) {
        log.info("Fetching all favorite details for user_no: {}", user_no);
        List<FavoriteDTO> favorites = favoriteDAO.findAllFavoritesByUserNo(user_no);
        return favorites != null ? favorites : new ArrayList<>(); // null 대신 빈 리스트 반환
    }

	@Override
	public FavoriteDTO getFavoriteDetailByStatId(int userNo, String statId) {
	    return favoriteDAO.getFavoriteDetailByStatId(userNo, statId); 

	}
	
	@Override
	public FavoriteDTO getStationDetailByStatId(String statId) {
	    return favoriteDAO.getStationDetailByStatId(statId);
	}
	
//	@Override
//    public List<String> getFavoriteStationIdsByUserNo(int user_no) { // 파라미터명을 user_no로 통일 (인터페이스와 일치)
//        log.info("사용자 번호 {}의 즐겨찾기 stat_id 목록 조회 서비스 실행", user_no);
//        try {
//            Set<String> stationIds = favoriteDAO.findFavoriteStationIdsByUserNo(user_no);
//            
//            if (stationIds == null) {
//                log.warn("DAO의 findFavoriteStationIdsByUserNo가 사용자 번호 {}에 대해 null을 반환했습니다. 빈 Set으로 대체합니다.", user_no);
//                return Collections.emptySet(); // null 대신 빈 Set 반환
//            }
//            
//            log.info("사용자 번호 {}의 즐겨찾기 ID 목록 {}개 조회 완료: {}", user_no, stationIds.size(), stationIds);
//            return stationIds;
//
//
//        } catch (Exception e) {
//            log.error("사용자 번호 {}의 즐겨찾기 ID 목록 조회 중 예외 발생", user_no, e);
//            return Collections.emptySet(); // 예외 발생 시 안전하게 빈 Set 반환
//        }
//    }
	@Override
	public Set<String> getFavoriteStationIdsByUserNo(int user_no) {
	    List<String> list = favoriteDAO.findFavoriteStationIdsByUserNo(user_no);
	    return list != null ? new HashSet<>(list) : Collections.emptySet();
	}

}