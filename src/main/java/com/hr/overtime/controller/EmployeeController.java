package com.hr.overtime.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.hr.login.model.LoginModel;
import com.hr.overtime.model.OverTimeAuditted;
import com.hr.overtime.model.OverTimePending;
import com.hr.overtime.repository.Impl.OverTimeAuditingRepository;
import com.hr.overtime.repository.Impl.OverTimePendingRepository;
import com.hr.overtime.service.OverTimeService;
import com.hr.overtime.service.bean.OverTimeReponse;

@Controller
@SessionAttributes("loginModel")
public class EmployeeController {

	@Autowired
	OverTimeService overTimeService;
	
	@Autowired
	HttpServletRequest request;
	
	@PostMapping(path = "/saveOvertime")
	private void saveOvertimePending(@RequestBody OverTimePending overTimePending,LoginModel loginModel) throws ParseException {
		Date date = new Date();
		SimpleDateFormat sdfDate = new SimpleDateFormat("yyyy-MM-dd");
		String sDate = sdfDate.format(date);
		date = sdfDate.parse(sDate);
		String empNo = loginModel.getEmpNo();
		String empName = loginModel.getName();
		int managerEmpId = loginModel.getDepartmentDetail().getManagerEmpId();
		System.out.println(managerEmpId);
		overTimePending.setDateOfApplication(date);
		overTimePending.setEmpNo(empNo);
		overTimePending.setEmpName(empName);
		overTimePending.setManagerEmpId(managerEmpId);
		
		overTimeService.savePending(overTimePending);
		
//		return "Y" "N失敗"; 
		
	}
	
	@Autowired
	OverTimePendingRepository overTimePendingRepository;
	
	@Autowired
	OverTimeAuditingRepository overTimeAuditingRepository;
	
	@GetMapping(path="/findEmpOvertime")
	@ResponseBody
	public OverTimeReponse findEmpOvertimeBypending(@RequestParam(value="pageNo",required = false)String pageNo,
			@RequestParam(value="depart",required = false)String depart,
			@RequestParam(value="keyword",required = false)String keyword,@RequestParam(value="date",required = false)String date,
			LoginModel loginModel) {
		
		String empNo = loginModel.getEmpNo();
		
		int pageNumber = pageNo == null || "null".equals(pageNo) ? 0 : Integer.parseInt(pageNo) -1;
//		depart = "null".equals(depart) ? null : depart;
//		date = "null".equals(date) ? null : date;
		
		Pageable page = PageRequest.of(pageNumber, 10);
		
		Page<OverTimePending> result = overTimePendingRepository.findByEmpNo(page, empNo, date, depart,null);
		
		List<OverTimePending> overtimepending = result.getContent();
		
		OverTimeReponse response = new OverTimeReponse();
		
		response.setCurrentPage(pageNumber +1);
		response.setResult(overtimepending);
		response.setTotalPage(result.getTotalPages());
		
		return response ;
	}
	
	@GetMapping(path="/findEmpOvertime2")
	@ResponseBody
	public OverTimeReponse findEmpOvertimeByauditted(@RequestParam(value="pageNo",required = false)String pageNo,
			@RequestParam(value="depart",required = false)String depart,
			@RequestParam(value="keyword",required = false)String keyword,@RequestParam(value="date",required = false)String date,
			LoginModel loginModel) {
		
		String empNo = loginModel.getEmpNo();
		
		int pageNumber = pageNo == null || "null".equals(pageNo) ? 0 : Integer.parseInt(pageNo) -1;
//		depart = "null".equals(depart) ? null : depart;
//		date = "null".equals(date) ? null : date;
		
		Pageable page = PageRequest.of(pageNumber, 10);	
		
		Page<OverTimeAuditted> result = overTimeAuditingRepository.findByEmpNo(page, empNo, date, depart);
		
		List<OverTimeAuditted> overtimepending = result.getContent();
		
		System.out.println("depart = " + depart);
		
		OverTimeReponse response = new OverTimeReponse();
		
 		response.setCurrentPage(pageNumber + 1);
		response.setResult(overtimepending);
		response.setTotalPage(result.getTotalPages());
		
		return response ;
	}
	
	
	//-----------------------------------------------入口->jsp--------------------------------------
	@GetMapping(path = "/employeeQuery") 
	public String employeeQuery() {
		return "overtime/employeeQuery";
	}
	//員工加班 並查詢近五筆送出資料
	@GetMapping(path = "/employeeOvertime") 
	public String employeeOvertime(Model model,LoginModel loginModel) {
//		HttpSession httpSession = request.getSession(true);
//		String empNo = (String)httpSession.getAttribute("empNo");
//		empNo = "123";
		String empNo = loginModel.getEmpNo();
		System.out.println(empNo);
		
		List<OverTimePending> overtimePartPending = overTimeService.findPartByEmpnoPending(empNo);
		System.out.println(overtimePartPending.size());
		model.addAttribute("overtimePartPending" , overtimePartPending );
		return "overtime/employeeUser";
	}
}
