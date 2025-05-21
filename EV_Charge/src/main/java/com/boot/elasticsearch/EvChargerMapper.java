package com.boot.elasticsearch;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface EvChargerMapper {
	List<ElasticsearchDTO> selectAll();
}