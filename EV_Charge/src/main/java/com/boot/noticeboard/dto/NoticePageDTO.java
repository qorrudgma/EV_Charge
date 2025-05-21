package com.boot.noticeboard.dto;

import lombok.Data;

@Data
//@AllArgsConstructor
//@NoArgsConstructor
public class NoticePageDTO {
	private int ev_startPage; // 시작페이지 : 1, 11
	private int ev_endPage; // 끝페이지 : 10, 20
	private boolean ev_prev, ev_next;
	private int ev_total;
	private NoticeCriteria ev_cri;

	public NoticePageDTO(int ev_total, NoticeCriteria ev_cri) {
		this.ev_total = ev_total;
		this.ev_cri = ev_cri;

//		ex> 3페이지 = 3/10 -> 0.3 -> 1*10 = 10(끝페이지)
//		ex> 11페이지 = 11/10 -> 1.1 -> 2*10 = 20(끝페이지)
		this.ev_endPage = (int) Math.ceil((ev_cri.getEv_pageNum() / 10.0)) * 10;

//		ex> 10-9 = 1페이지
//		ex> 20-9 = 11페이지
		this.ev_startPage = this.ev_endPage - 9;

//		ex> total : 300, 현재 페이지 : 3 -> endPage : 10 => 300 * 1.0 / 10 => 30페이지
//		ex> total : 70, 현재 페이지 : 3 -> endPage : 10 => 70 * 1.0 / 10 => 7페이지
		int realEnd = (int) Math.ceil((ev_total * 1.0) / ev_cri.getEv_amount());
		if (realEnd <= this.ev_endPage) {
			this.ev_endPage = realEnd;
		}

//		1페이지보다 크면 존재 -> 참이고 아님 거짓으로 없음
		this.ev_prev = this.ev_startPage > 1;

//		ex>10페이지 < 30페이지
		this.ev_next = this.ev_endPage < realEnd;
	}

}
