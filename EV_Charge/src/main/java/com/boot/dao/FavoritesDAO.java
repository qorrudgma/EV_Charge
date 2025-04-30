package com.boot.dao;

import java.util.List;

import com.boot.dto.FavoritesDTO;

public interface FavoritesDAO {
	void addFavorite(FavoritesDTO dto);
	void removeFavorite(FavoritesDTO dto);
	List<FavoritesDTO> getFavorites(FavoritesDTO dto);
}
