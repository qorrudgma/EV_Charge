package com.boot.board.service;

import java.util.ArrayList;
import java.util.HashMap;

import com.boot.board.dto.CommentDTO;

public interface CommentService {
	public void save(HashMap<String, String> param);

	public ArrayList<CommentDTO> findAll(HashMap<String, String> param);
}
