package com.boot.noticeboard.dto;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
//@NoArgsConstructor
public class NoticeCriteria {
	private int ev_pageNum;// 페이지 번호
	private int ev_amount;// 페이지당 글 갯수

	private String ev_type;
	private String ev_keyword;

	public NoticeCriteria() {
		this(1, 10);
	}

	public NoticeCriteria(int ev_pageNum, int ev_amount) {
		super();
		this.ev_pageNum = ev_pageNum;
		this.ev_amount = ev_amount;
	}
}
