package com.boot.dao;

import org.apache.ibatis.annotations.Param;

public interface FavoriteDAO {
	public FavoriteDAO getFavoritesByUserNo(@Param("userNo") int userNo);
}