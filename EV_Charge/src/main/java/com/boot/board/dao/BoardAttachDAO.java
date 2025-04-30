package com.boot.board.dao;

import java.util.List;

import com.boot.board.dto.BoardAttachDTO;

public interface BoardAttachDAO {
//	파일업로드는 파라미터를 DTO 사용
	public void insertFile(BoardAttachDTO vo);

	public List<BoardAttachDTO> getFileList(int boardNo);

	public void deleteFile(String boardNo);
}
