package com.boot.noticeboard.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.boot.dto.MemberDTO;
import com.boot.noticeboard.dto.NoticeCriteria;
import com.boot.noticeboard.dto.NoticePageDTO;
import com.boot.noticeboard.service.NoticePageService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class NoticePageController {
	@Autowired
	private NoticePageService service;

	@RequestMapping("/notice_list")
	public String list(NoticeCriteria cri, Model model, HttpServletRequest request) {
		log.info("@# list()");
		log.info("@# cri" + cri);

		HttpSession session = request.getSession();
		MemberDTO dto = (MemberDTO) session.getAttribute("user");

		log.info("@# notice_list => ", dto);

		model.addAttribute("user", dto);
		model.addAttribute("list", service.notice_listWithPaging(cri));
		model.addAttribute("pageMaker", new NoticePageDTO(service.notice_totalList(cri), cri));

		return "notice_list";
	}
}
