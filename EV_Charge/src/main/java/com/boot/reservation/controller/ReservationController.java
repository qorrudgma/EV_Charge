package com.boot.reservation.controller;

import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.boot.dto.MemberDTO;
import com.boot.reservation.dto.ReservationDTO;
import com.boot.reservation.service.ReservationService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class ReservationController {

	@Autowired
	private ReservationService service;

	@RequestMapping("/reservation")
	public String reservation(Model model) {
		LocalDateTime localDateTime = LocalDateTime.now();
		Date current_date = Date.from(localDateTime.atZone(ZoneId.systemDefault()).toInstant());

		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		String formatDate = formatter.format(current_date);

		List<ReservationDTO> current_reservation_list = service.find_reservation_by_reserve_date(formatDate);

		model.addAttribute("current_date", formatDate);
		model.addAttribute("current_reservation_list", current_reservation_list);

		log.info("@# current_date =>" + current_date);
		log.info("@# current_reservation_list =>" + current_reservation_list);
		return "reservation";
	}

	@RequestMapping("/reservation_ok")
	public String reservation_ok(@RequestParam("stat_id") String stat_id,
			@RequestParam("reservation_date") String reservation_date,
			@RequestParam("reservation_time[]") String[] reservation_time_list, HttpServletRequest request) {

		log.info("@# reservation_ok() stat_id" + stat_id);
		log.info("@# reservation_ok() reservation_date" + reservation_date);
		for (int i = 0; i < reservation_time_list.length; i++) {
			log.info("@# reservation_ok() reservation_time_list" + i + " =>" + reservation_time_list[i]);
		}

		HttpSession session = request.getSession();
		MemberDTO user = (MemberDTO) session.getAttribute("user");
		int user_no = user.getUser_no();
		int duration_minutes = reservation_time_list.length * 30;
		String reservation_time = reservation_time_list[0];

		service.insertReservation(stat_id, user_no, reservation_date, reservation_time, duration_minutes);

		return "redirect:/mypage";
	}

	@RequestMapping("/change_date")
	@ResponseBody
	public List<String> change_date(@RequestParam("reservation_date") String reservation_date,
			@RequestParam("stat_id") String stat_id) {
		log.info("@# change_date() reservation_date => " + reservation_date);
		log.info("@# change_date() stat_id => " + stat_id);

		List<ReservationDTO> list = service.find_reservation_by_reserve_date_stat(reservation_date, stat_id);

		List<String> reservedTime = list.stream().map(ReservationDTO::getReservation_time).collect(Collectors.toList());

		return reservedTime;
	}
}
