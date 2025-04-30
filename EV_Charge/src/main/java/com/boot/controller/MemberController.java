package com.boot.controller;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.boot.dto.MemberDTO;
import com.boot.service.MemberService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class MemberController {

	@Autowired
	private MemberService memberService;

	// main.jsp
	@RequestMapping("/main")
	public String main() {
		log.info("main");
		return "main";
	}

	// regist.jsp
	@RequestMapping("/registe")
	public String registe(Model model) {
		log.info("registe");
		return "registe";
	}

	// login.jsp
	@RequestMapping("/login")
	public String login() {
		log.info("login");
		return "login";
	}

	// 로그인 가능여부
	@RequestMapping("/login_yn")
	public String login_yn(@RequestParam("user_id") String user_id, @RequestParam("user_password") String user_password,
			HttpServletRequest request) {
		int result = memberService.login(user_id, user_password);
		log.info("@# result =>" + result);
		if (result != 0) {
			System.out.println(user_id);
			HttpSession session = request.getSession();
			MemberDTO dto = memberService.member_find(user_id);
			session.setAttribute("user", dto);

			log.info("@# user => " + session.getAttribute("user"));
			return "redirect:/main";
		}
		return "redirect:/login";
	}

	// 로그아웃
	@RequestMapping("/logout")
	public String logout(HttpServletRequest request) {
		log.info("logout");
		HttpSession session = request.getSession(false); // 기존 세션이 있을 때만 가져오기
		if (session != null) {
			session.invalidate(); // 세션 완전 삭제
		}
		return "redirect:/main"; // 메인 페이지로 이동
	}

	// 회원가입
	@RequestMapping("/registe_user")
	public String registe_user(@RequestParam HashMap<String, String> param) {

		memberService.registUser(param);

		return "main";
	}

	// 마이페이지
	@RequestMapping("/mypage")
	public String mypage(Model model, HttpServletRequest request) {
		HttpSession session = request.getSession();
		MemberDTO dto = (MemberDTO) session.getAttribute("user");
		model.addAttribute("memberDTO", dto);

		return "mypage";
	}

	// 회원정보 수정창 이동
	@RequestMapping("/editInfo")
	public String editInfo(Model model, HttpServletRequest request) {
		HttpSession session = request.getSession();
		MemberDTO dto = (MemberDTO) session.getAttribute("user");
		model.addAttribute("memberDTO", dto);

		return "editInfo";
	}

	// 회원정보 수정실행
	@RequestMapping("/updateMember")
	public String updateMember(@RequestParam HashMap<String, String> param, HttpServletRequest request) {
		HttpSession session = request.getSession();
		memberService.update_ok(param);
		if (session != null) {
			session.invalidate(); // 세션 완전 삭제
		}

		return "redirect:/main";
	}

	// 아이디 중복체크
	@RequestMapping("/user_id_check")
	@ResponseBody
	public String user_id_check(@RequestParam("user_id") String id) {
		int count = memberService.user_id_check(id);
		if (count == 0) {
			return "ok";
		} else {
			return "fail";
		}
	}
}