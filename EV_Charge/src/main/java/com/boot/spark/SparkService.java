package com.boot.spark;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.boot.dto.EvChargerDTO;
import com.boot.reservation.dto.ReservationDTO;

public interface SparkService {
	public List<EvChargerDTO> select_data_by_stat(@Param("stat_id") String stat_id);

	public List<EvChargerDTO> select_stats_by_addr(@Param("addr") String addr);

	public List<ReservationDTO> select_reserve_by_stat_id(@Param("stat_id") String stat_id);
}
