package com.boot.noticeboard.dao;

import java.util.ArrayList;

import com.boot.noticeboard.dto.NoticeBoardDTO;
import com.boot.noticeboard.dto.NoticeCriteria;

public interface NoticePageDAO {
//	Criteria 객체를 이용해서 페이징 처리
	public ArrayList<NoticeBoardDTO> notice_listWithPaging(NoticeCriteria cri);

	public int notice_totalList(NoticeCriteria cri);
}
