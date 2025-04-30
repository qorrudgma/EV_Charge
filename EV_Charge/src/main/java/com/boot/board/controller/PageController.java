package com.boot.board.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.boot.board.dto.Criteria;
import com.boot.board.dto.PageDTO;
import com.boot.board.service.PageService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class PageController {
	@Autowired
	private PageService service;

	@RequestMapping("/list")
	public String list(Criteria cri, Model model) {
		log.info("@# list()");
		log.info("@# cri" + cri);

		model.addAttribute("list", service.listWithPaging(cri));
		model.addAttribute("pageMaker", new PageDTO(service.totalList(cri), cri));

		return "list";
	}
}
