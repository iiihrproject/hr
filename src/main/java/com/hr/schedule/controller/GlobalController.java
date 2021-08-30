package com.hr.schedule.controller;

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
import com.hr.personnel.model.Personnel;

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
	
//	找同事的email
	@GetMapping(value="/findEmpByPk")
	public @ResponseBody Personnel findEmpByPk(@RequestParam("empId") Integer empId) {
		return leaveService.findEmpByPk(empId);
	}
	
//	找員工資訊
	@GetMapping(value="/findEmpByEmpNo")
	public @ResponseBody LoginModel findEmpByEmpNo(@RequestParam("empNo") String empNo) {
		return loginService.getLoginModelByEmpNo(empNo);
	}
	
//	找同部門的同事
	@GetMapping(value="/findEmpsByDept")
	public @ResponseBody List<LoginModel> findEmpsByDept(@RequestParam("departmentNumber") Integer departmentNumber) {
		return leaveService.findEmpsByDept(departmentNumber);
	}

//	判斷角色是否不只General
	@GetMapping(value = "/findAUTHByEmpNo", produces = { "application/json; charset=UTF-8" })
	public @ResponseBody boolean isAuthMoreThanGEN(@ModelAttribute("loginModel") LoginModel loginModel) {
		LoginModel loginM = loginService.getLoginModelByEmpNo(loginModel.getEmpNo());

		Set<Authorities> set = loginM.getAuthorities();
//		  Iterator<Authorities> iterator = set.iterator();
//		  boolean check = false;
		boolean moreThanGen = false;
//		System.out.println(set.size());
		if (set.size() > 1) {
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