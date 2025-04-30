package com.boot.dto;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class MemberDTO {
	private int user_no;
	private String user_id;
	private String user_password;
	private String user_name;
	private String user_email;
	private String area_ctpy_nm;
	private String area_sgg_nm;
	private String area_emd_nm;
	private List<String> addrList;

}