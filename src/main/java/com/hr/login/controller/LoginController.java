package com.hr.login.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
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
@SessionAttributes("loginModel")
public class LoginController {
	
	@Autowired
	private LoginService loginService;
	
	@GetMapping(path="/")
	public String mainPagePath() {
		return "redirect:/index";
	}
	
	@GetMapping(path="/login")
	public String loginPagePath() {
		return "/login";
	}
	
	@GetMapping(path="/index")
	public String redirectToMainPage(Model model) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String empNo = authentication.getName();
		LoginModel loginModel = loginService.getLoginModelByEmpNo(empNo);
		model.addAttribute("loginModel", loginModel);
		return "/index";
	}
	
	@GetMapping(value="/logout")
	public String logoutPage (HttpServletRequest request, HttpServletResponse response) {
	    Authentication auth = SecurityContextHolder.getContext().getAuthentication();
	    if (auth != null){    
	        new SecurityContextLogoutHandler().logout(request, response, auth);
	    }
	    return "/login";
	}
	
	@GetMapping(path="/test")
	public String test() {
		return "/test";
	}
}
