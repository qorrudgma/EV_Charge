package com.boot.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.boot.dto.FavoritesDTO;
import com.boot.service.FavoritesService;

@RestController
public class FavoritesController {

	@Autowired
	FavoritesService service;

	@RequestMapping("/favorites")
	public String favorites() {
		return "/favorites";
	}

	@PostMapping("/favorites/add")
	public ResponseEntity<String> addFavorite(@RequestBody FavoritesDTO dto) {
		service.addFavorite(dto);
		return ResponseEntity.ok("added");
	}

	@PostMapping("/favorites/remove")
	public ResponseEntity<String> removeFavorite(@RequestBody FavoritesDTO dto) {
		service.removeFavorite(dto);
		return ResponseEntity.ok("removed");
	}

	@RequestMapping("/favorites/list")
	@ResponseBody
	public List<FavoritesDTO> getFavorites(@RequestParam int user_no, @RequestParam String user_id) {
		FavoritesDTO dto = new FavoritesDTO();
		dto.setUser_no(user_no);
		dto.setUser_id(user_id);
		return service.getFavorites(dto);
	}
}
