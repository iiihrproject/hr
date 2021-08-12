package com.hr.personnel.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.hr.login.model.LoginModel;

@Controller
public class PersonnelController {

	@GetMapping(path="/editPersonalInfo")
	public String editPersonalInfo() {
		return "/personnel/editPersonalInfo";
	}
	
	@GetMapping(path="/personnel")
	public String personnel() {
		return "/personnel/personnel";
	}
	
}
