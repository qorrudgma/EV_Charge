package com.boot.service;

import java.util.List;

import com.boot.dto.FavoritesDTO;

public interface FavoritesService {
	void addFavorite(FavoritesDTO dto);
	void removeFavorite(FavoritesDTO dto);
	List<FavoritesDTO> getFavorites(FavoritesDTO dto);
}
