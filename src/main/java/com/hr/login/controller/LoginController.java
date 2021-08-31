package com.hr.login.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.hr.login.model.LoginModel;
import com.hr.login.service.LoginService;
import com.hr.overtime.service.OverTimeService;

@Controller
@SessionAttributes({"loginModel" ,"sumHours" ,"remainingHours"})
public class LoginController {
	
	@Autowired
	private LoginService loginService;
	
	@Autowired
	private OverTimeService overTimeService;
	
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
		Double sumHours = overTimeService.sumOverTimeHours(empNo);
		Double remainingHours = 46 - sumHours ;

		model.addAttribute("sumHours",sumHours);
		model.addAttribute("remainingHours",remainingHours);
		model.addAttribute("loginModel", loginModel);
		return "/index";
	}

	@GetMapping(path="/logout")
	public String logoutPage (HttpServletRequest request, HttpServletResponse response) {
	    Authentication auth = SecurityContextHolder.getContext().getAuthentication();
	    if (auth != null){    
	        new SecurityContextLogoutHandler().logout(request, response, auth);
	    }
	    return "/login";
	}
	
	@GetMapping(path="/pages")
	public String loginPage() {
		return "pages";

	}	
}
