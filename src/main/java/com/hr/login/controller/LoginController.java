package com.hr.login.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.hr.login.model.LoginModel;
import com.hr.login.service.LoginService;

@Controller
public class LoginController {
	
	@GetMapping(path={"/login", "/"})
	public String loginPagePath() {
		return "/login/login";
	}
	
	@PostMapping(path="/index")
	public String redirectToMainPage() {
		
		return "/index/index";
	}
	
}
