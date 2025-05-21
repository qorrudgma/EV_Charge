package com.boot.noticeboard.service;

import java.util.ArrayList;

import com.boot.noticeboard.dto.NoticeBoardDTO;
import com.boot.noticeboard.dto.NoticeCriteria;

public interface NoticePageService {
	public ArrayList<NoticeBoardDTO> notice_listWithPaging(NoticeCriteria cri);

	public int notice_totalList(NoticeCriteria cri);
}
