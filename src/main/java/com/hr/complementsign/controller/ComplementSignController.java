package com.hr.complementsign.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.hr.complementsign.model.PendingComplementSign;
import com.hr.complementsign.service.ComplementSignService;
import com.hr.login.model.LoginModel;

@Controller
@SessionAttributes("loginModel")
public class ComplementSignController {
	
	@Autowired
	ComplementSignService complementSignService;
	//表單申請&查詢部分
	@GetMapping(path = "/EmpSignApply")
	public String EmpComplementSign(Model model, LoginModel loginModel) {
//		String empNo = loginModel.getEmpNo();
//		List<PendingComplementSign> pendingComplementSign = complementSignService.findPartComplementSign(empNo);
//		model.addAttribute("pendingComplementSign", pendingComplementSign);
		
		return "complementSign/ComplementSignForm";
	}
	
	//查詢全部
	@GetMapping(path = "/EmpSignQuery")
	public String EmpQueryComplementSign() {
		return "";
	}
	
	@PostMapping(path = "/saveEmpComplementSign")
	public void savePendingComplementSign(@RequestBody PendingComplementSign pendingComplementSign,LoginModel loginModel) throws ParseException {
		String empName = "王曉明";
		String empNo = loginModel.getEmpNo();
		int managerEmpId = loginModel.getDepartmentDetail().getManagerEmpId();
		Date date = new Date();
		SimpleDateFormat sdfDate = new SimpleDateFormat("yyyy-MM-dd");
		String sDate = sdfDate.format(date);
		date = sdfDate.parse(sDate);
		pendingComplementSign.setEmpName(empName);
		pendingComplementSign.setEmpNo(empNo);
		pendingComplementSign.setDate(date);
		pendingComplementSign.setManagerNo(managerEmpId);
		pendingComplementSign.setStatus("pending");
		complementSignService.saveComplementSign(pendingComplementSign);
	}
	
//-------------------------------------------------管理員-------------------------------------------------------	
	
	@GetMapping(path = "/ManagerQuery")
	public String ManagerQuery() {
		return "" ;
	}
	@GetMapping(path = "")
	@ResponseBody
	public List<PendingComplementSign> MangerQueryApprove(PendingComplementSign pendingComplementSign,LoginModel loginModel) {
		int managerEmpId = loginModel.getDepartmentDetail().getManagerEmpId();
		List<PendingComplementSign> managerQuery = complementSignService.findAllComplementSign(managerEmpId);
		
		return managerQuery;
		
	}
	
	@PostMapping(path = "")
	@ResponseBody
	public void saveAudittedComplementSign(@RequestParam("type") String type , @RequestParam("id") int id) {
		 PendingComplementSign pendingComplementSign = complementSignService.findById(id);
		 complementSignService.saveAudittedComplementSign(pendingComplementSign ,type);
		 complementSignService.deletePendingComplementSign(pendingComplementSign);
		
	}
}
