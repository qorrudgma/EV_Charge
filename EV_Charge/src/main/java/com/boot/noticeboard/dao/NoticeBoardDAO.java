package com.boot.noticeboard.dao;

import java.util.ArrayList;
import java.util.HashMap;

import com.boot.noticeboard.dto.NoticeBoardDTO;

public interface NoticeBoardDAO {
	public ArrayList<NoticeBoardDTO> notice_list();

//	public void write(HashMap<String, String> param);
	public void notice_writeNotice(NoticeBoardDTO noticeBoardDTO);

	public NoticeBoardDTO notice_contentView(HashMap<String, String> param);

	public void notice_modify(HashMap<String, String> param);

	public void notice_delete(HashMap<String, String> param);
}
