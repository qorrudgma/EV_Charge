package com.boot.service;

import java.util.Map;

import com.boot.dto.FavoriteDTO;

public interface FavoriteService {
    Map<String, Object> addFavorite(FavoriteDTO favorite);
}
