package com.boot.noticeboard.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.boot.dto.MemberDTO;
import com.boot.noticeboard.dto.NoticeBoardDTO;
import com.boot.noticeboard.service.NoticeBoardService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class NoticeBoardController {
	@Autowired
	private NoticeBoardService service;

	@RequestMapping("/notice_list_old")
	public String list(Model model) {
		log.info("@# list()");

		ArrayList<NoticeBoardDTO> list = service.notice_list();
		model.addAttribute("list", list);

		return "notice_list";
	}

	@RequestMapping("/notice_write")
//	public String write(@RequestParam HashMap<String, String> param) {
	public String write(NoticeBoardDTO boardDTO) {
		log.info("@# write()");
		log.info("@# boardDTO=>" + boardDTO);

//		service.write(param);
		service.notice_write(boardDTO);

		return "redirect:notice_list";
	}

	@RequestMapping("/notice_write_view")
	public String write_view(HttpServletRequest request, Model model) {
		log.info("@# write_view()");

		HttpSession session = request.getSession();
		MemberDTO dto = (MemberDTO) session.getAttribute("user");
		String user_name = dto.getUser_name();
		model.addAttribute("user_name", user_name);

		return "notice_write_view";
	}

	@RequestMapping("/notice_content_view")
	public String content_view(@RequestParam HashMap<String, String> param, Model model, HttpServletRequest request) {
		log.info("@# content_view()");
		log.info("@# param" + param);

		MemberDTO user = (MemberDTO) request.getAttribute("user");

		NoticeBoardDTO dto = service.notice_contentView(param);
		model.addAttribute("content_view", dto);
		model.addAttribute("user", user);

//		content_view.jsp 에서 pageMaker 를 가지고 페이징 처리
		model.addAttribute("pageMaker", param);

		return "notice_content_view";
	}

	@RequestMapping("/notice_modify")
	public String modify(@RequestParam HashMap<String, String> param, RedirectAttributes rttr) {
		log.info("@# modify()");
		log.info("@# param" + param);

		service.notice_modify(param);

//		페이지 이동시 뒤에 페이지번호, 글 갯수 추가 
		rttr.addAttribute("pageNum", param.get("ev_pageNum"));
		rttr.addAttribute("amount", param.get("ev_amount"));
		rttr.addAttribute("boardNo", param.get("ev_boardNo"));

		return "redirect:notice_list";
	}

	@RequestMapping("/notice_delete")
	public String delete(@RequestParam HashMap<String, String> param, RedirectAttributes rttr) {
		log.info("@# delete()");
		log.info("@# param=>" + param);
		log.info("@# boardNo=>" + param.get("boardNo"));

		rttr.addAttribute("pageNum", param.get("ev_pageNum"));
		rttr.addAttribute("amount", param.get("ev_amount"));
		rttr.addAttribute("boardNo", param.get("ev_boardNo"));

//		게시글 삭제, 댓글 삭제
		service.notice_delete(param);

		return "redirect:notice_list";
	}
}
