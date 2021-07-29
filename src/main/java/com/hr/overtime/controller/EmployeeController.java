package com.hr.overtime.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

import com.hr.overtime.model.OverTimePending;
import com.hr.overtime.service.OverTimeService;

@Controller
public class EmployeeController {

	@Autowired
	OverTimeService overTimeService;
	
	@PostMapping(path = "/EmployeeInserContrallerAction")
	private void processAction(@RequestBody OverTimePending overTimePending ,HttpServletRequest request) {
		System.out.println("sucssess");
		HttpSession httpSession = request.getSession(true);
		String empNo = (String)httpSession.getAttribute("empNo");
		empNo = "123";
		
		overTimePending.setEmpNo(empNo);
		
		overTimeService.savePending(overTimePending);
		
//		return "Y" "N失敗"; 
		
	}
	@GetMapping(path = "yyy") //測試
	public String Test() {
		return "EmployeeUser";
	}
	
	@GetMapping(path = "/") //測試
	public String Test2() {
		return "EmployeeUser";
	}
}
