package com.hr.overtime.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.hr.login.model.LoginModel;
import com.hr.overtime.model.OverTimePending;
import com.hr.overtime.repository.Impl.OverTimePendingRepository;
import com.hr.overtime.service.OverTimeService;
import com.hr.overtime.service.bean.PublicReponse;
@Controller
@SessionAttributes("loginModel")
public class ManagerController {

	@Autowired
	OverTimeService overTimeService;
	
	@Autowired
	HttpServletRequest request;
	//管理員審核(抓當下id)
	
	@PostMapping(path = "/manageAudit")
	@ResponseBody
	public void saveOvertimeAuditted(@RequestParam("type")String type ,@RequestParam("id")int id ,LoginModel loginModel) {
		
		System.out.println("start");
//		HttpSession httpSession = request.getSession(true);
//		String empNo = (String)httpSession.getAttribute("empNo");
//		empNo = "123";
		OverTimePending overTimePending = overTimeService.findById(id);
		
		overTimeService.saveAuditted(overTimePending ,type);
		overTimeService.deletePending(overTimePending);
		
		System.out.println("finished");
		
	}
	
	@Autowired
	OverTimePendingRepository overTimePendingRepository;
	
	//管理員查詢屬於自己部門所有未審核資料
	@GetMapping(path = "/manageQuery")
	public @ResponseBody PublicReponse findOvertimeByResult(@RequestParam(value="pageNo",required = false)String pageNo,
			@RequestParam(value="depart",required = false)String depart,
			@RequestParam(value="keyword",required = false)String keyword,@RequestParam(value="date",required = false)String date,
			LoginModel loginModel){
		
		int pageNumber = pageNo == null || "null".equals(pageNo) ? 0 : Integer.parseInt(pageNo) -1;
		
		Pageable page = PageRequest.of(pageNumber, 5);
		
		int managerEmpId = loginModel.getDepartmentDetail().getManagerEmpId();
		
		Page<OverTimePending> result = overTimePendingRepository.findByEmpNo(page, null, date, depart,managerEmpId);
		
		List<OverTimePending> overtimepending = result.getContent();
		
		PublicReponse response = new PublicReponse();
		response.setResult(overtimepending);
		response.setTotalPage(result.getTotalPages());
		response.setCurrentPage(pageNumber + 1);
		
		return response;
	}
	
	@GetMapping(path = "/ManagersystemOvertime") 
	public String Test() {
		return "overtime/managerQuery";
	}
}
