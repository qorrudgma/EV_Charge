package com.boot.noticeboard.dto;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class NoticeBoardDTO {
	private int ev_notice_boardNo;
	private String ev_notice_boardName;
	private String ev_notice_boardTitle;
	private String ev_notice_boardContent;
	private Timestamp ev_notice_boardDate;
	private int ev_notice_boardHit;
	private int user_no;

}
