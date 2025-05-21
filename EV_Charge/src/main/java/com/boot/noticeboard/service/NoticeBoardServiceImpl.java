package com.boot.noticeboard.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.boot.noticeboard.dao.NoticeBoardDAO;
import com.boot.noticeboard.dto.NoticeBoardDTO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service("NoticeBoardService")
public class NoticeBoardServiceImpl implements NoticeBoardService {
	@Autowired
	private SqlSession sqlSession;

	@Override
	public ArrayList<NoticeBoardDTO> notice_list() {
		NoticeBoardDAO dao = sqlSession.getMapper(NoticeBoardDAO.class);
		ArrayList<NoticeBoardDTO> list = dao.notice_list();
		return list;
	}

	@Override
//	public void write(HashMap<String, String> param) {
//	파일업로드는 파라미터를 DTO 사용
	public void notice_write(NoticeBoardDTO boardDTO) {
		log.info("@# BoardServiceImpl boardDTO=>" + boardDTO);

		NoticeBoardDAO dao = sqlSession.getMapper(NoticeBoardDAO.class);

//		dao.write(param);
		dao.notice_writeNotice(boardDTO);
	}

	@Override
	public NoticeBoardDTO notice_contentView(HashMap<String, String> param) {
		NoticeBoardDAO dao = sqlSession.getMapper(NoticeBoardDAO.class);
		NoticeBoardDTO dto = dao.notice_contentView(param);

		return dto;
	}

	@Override
	public void notice_modify(HashMap<String, String> param) {
		NoticeBoardDAO dao = sqlSession.getMapper(NoticeBoardDAO.class);
		dao.notice_modify(param);
	}

	@Override
	public void notice_delete(HashMap<String, String> param) {
		log.info("@# delete param=>" + param);

		NoticeBoardDAO dao = sqlSession.getMapper(NoticeBoardDAO.class);

//		게시글 삭제
		dao.notice_delete(param);
	}

}
