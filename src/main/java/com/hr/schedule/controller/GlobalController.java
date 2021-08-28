package com.hr.schedule.controller;

import java.util.Iterator;
import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.hr.leave.model.ListBean;
import com.hr.leave.service.LeaveService;
import com.hr.login.model.Authorities;
import com.hr.login.model.LoginModel;
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

	@GetMapping(value="/findAUTHByEmpNo",produces= {"application/json; charset=UTF-8"})
	public @ResponseBody boolean isAuthMoreThanGEN(@ModelAttribute("loginModel") LoginModel loginModel) {
		  LoginModel loginM = loginService.getLoginModelByEmpNo(loginModel.getEmpNo());
		  
		  Set<Authorities> set = loginM.getAuthorities();
//		  Iterator<Authorities> iterator = set.iterator();
//		  boolean check = false;
		  boolean moreThanGen = false;
		  System.out.println(set.size());
		  if(set.size() > 1) {
			  moreThanGen = true;
		  }
//		  while(iterator.hasNext()){
//		      String s = iterator.next().getAuthorityName();
//		      System.out.println(s.toString());
//		      if(s.equals("ROLE_GENERAL")) {
//		       check = true;
//		      }
//		  }
		  return moreThanGen;
	}
	
}