package com.boot.controller;

import java.util.Collections;
import java.util.HashMap;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.boot.dto.MemberDTO;
import com.boot.favorite.service.FavoriteService;
import com.boot.service.MemberService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class MemberController {

	@Autowired
	private MemberService memberService;
	
	@Autowired
	private FavoriteService favoriteService;
	
	
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
			HttpServletRequest request, Model model) { // Model 추가 (로그인 실패 메시지 전달용)
		log.info("login_yn 시도: 사용자 ID = {}", user_id);
		int result = memberService.login(user_id, user_password);
		log.info("@# 로그인 결과 (0이면 실패): {}", result);

		if (result != 0) { // 로그인 성공
			// System.out.println("로그인 성공한 사용자 ID: " + user_id);
			HttpSession session = request.getSession(); // 세션이 없으면 새로 생성
			MemberDTO dto = memberService.member_find(user_id);
			
			if (dto != null) {
			    session.setAttribute("user", dto);
			    log.info("@# 사용자 정보 세션에 저장됨: {}", dto);

			    try {
			        Set<String> favoriteStationIds = favoriteService.getFavoriteStationIdsByUserNo(dto.getUser_no());
			        session.setAttribute("userFavoriteStationIds", favoriteStationIds);
			        log.info("@# 사용자 {}의 즐겨찾기 ID 목록 ({}개) 세션에 저장됨: {}", user_id, favoriteStationIds.size(), favoriteStationIds);
			    } catch (Exception e) {
			        log.error("@# 사용자 {}의 즐겨찾기 목록 조회 중 오류 발생", user_id, e);
			        // 즐겨찾기 목록 조회에 실패하더라도 로그인은 계속 진행하도록 빈 Set 저장
			        session.setAttribute("userFavoriteStationIds", Collections.emptySet());
			    }
			    
			    return "redirect:/main";
			} else {
			    log.warn("@# 로그인 성공했으나 사용자 ID '{}'에 해당하는 회원 정보를 찾을 수 없습니다.", user_id);
			    model.addAttribute("loginError", "사용자 정보를 가져오는 데 실패했습니다. 다시 시도해주세요.");
			    return "login"; // 로그인 페이지로 다시 이동 (에러 메시지와 함께)
			}
		}
		
		// 로그인 실패
		log.warn("@# 사용자 ID '{}' 로그인 실패", user_id);
		model.addAttribute("loginError", "아이디 또는 비밀번호가 일치하지 않습니다.");
		return "login"; // 로그인 페이지로 다시 이동 (에러 메시지와 함께)
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