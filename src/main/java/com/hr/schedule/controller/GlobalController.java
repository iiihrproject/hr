package com.hr.schedule.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.hr.leave.model.ListBean;
import com.hr.leave.service.LeaveService;
import com.hr.login.service.LoginService;

@Controller
@RequestMapping("/G")
@SessionAttributes("loginModel")
public class GlobalController {
	
	@Autowired
	private LeaveService leaveService;
	
	@Autowired
	private LoginService loginService;
	
//	找清單內容
	@GetMapping(value="/findListByCAT",produces= {"application/json; charset=UTF-8"})
	public @ResponseBody List<ListBean> findListByCategory(@RequestParam("category") String category) {
		return leaveService.findListByCategory(category);
	}
}
