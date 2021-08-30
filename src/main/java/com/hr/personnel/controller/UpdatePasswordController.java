package com.hr.personnel.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

@Controller
@SessionAttributes("loginModel")
public class UpdatePasswordController {
	
	@GetMapping("/updatePassword")
	public String updatePassword() {
		return "/personnel/updatePassword";
	}
	
	@PutMapping("/updateNewPassword")
	public @ResponseBody Map<String, String> updateNewPassword(@RequestParam("newPassword") int newPassword) {
		Map<String, String> map = new HashMap<String, String>();
		return map;
	}
	
	

}
