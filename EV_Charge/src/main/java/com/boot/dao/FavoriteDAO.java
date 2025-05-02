package com.boot.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.boot.dto.FavoriteDTO;

@Mapper
public interface FavoriteDAO {
    int insertFavorite(FavoriteDTO favorite);
    int checkDuplicate(FavoriteDTO favorite);
    List<FavoriteDTO> getFavoritesByUser(String userId);
}
