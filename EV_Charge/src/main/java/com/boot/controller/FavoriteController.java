package com.boot.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.boot.dto.FavoriteDTO;
import com.boot.service.FavoriteService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/favorite")
public class FavoriteController {

	private final FavoriteService favoriteService;

	@Autowired
	public FavoriteController(FavoriteService favoriteService) {
		this.favoriteService = favoriteService;
	}

	@PostMapping("/add")
	public ResponseEntity<Map<String, String>> addFavorite(@RequestBody FavoriteDTO favorite) {
		// 받은 즐겨찾기 정보 출력 (디버깅용)
		System.out.println("받은 즐겨찾기 정보: " + favorite);

		// 서비스 호출
		favoriteService.addFavorite(favorite);

		// 성공 응답
		Map<String, String> response = new HashMap<>();
		response.put(null, "즐겨찾기 저장 완료!");
		return ResponseEntity.ok(response);
	}

	@PostMapping("/delete")
	public ResponseEntity<Map<String, String>> deleteFavorite(@RequestBody FavoriteDTO favorite) {
		favoriteService.deleteFavorite(favorite);
		Map<String, String> resp = new HashMap<>();
		resp.put(null, "즐겨찾기 삭제 완료!");
		return ResponseEntity.ok(resp);
	}

	@GetMapping("/list")
	@ResponseBody
	public List<FavoriteDTO> getFavoriteList(@RequestParam("user_no") int user_no) {
		log.info("getFavoriteList() userNo => " + user_no);
		log.info("" + favoriteService.getFavoritesByUserNo(user_no));
		return favoriteService.getFavoritesByUserNo(user_no);
	}

//	@PostMapping("/list")
//	public List<FavoriteDTO> getFavoriteList(@RequestBody Map<String, Integer> user) {
//		int userNo = user.get("userNo");
//		log.info("userNo = " + userNo);
//		return favoriteService.getFavoritesByUserNo(userNo);
//	}
}