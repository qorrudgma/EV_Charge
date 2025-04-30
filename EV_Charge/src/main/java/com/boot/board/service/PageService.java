package com.boot.board.service;

import java.util.ArrayList;

import com.boot.board.dto.BoardDTO;
import com.boot.board.dto.Criteria;

public interface PageService {
	public ArrayList<BoardDTO> listWithPaging(Criteria cri);

	public int totalList(Criteria cri);
}
