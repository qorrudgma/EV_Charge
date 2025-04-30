package com.boot.board.dao;

import java.util.ArrayList;

import com.boot.board.dto.BoardDTO;
import com.boot.board.dto.Criteria;

public interface PageDAO {
//	Criteria 객체를 이용해서 페이징 처리
	public ArrayList<BoardDTO> listWithPaging(Criteria cri);

	public int totalList(Criteria cri);
}
