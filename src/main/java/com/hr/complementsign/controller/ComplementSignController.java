package com.hr.complementsign.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.hr.complementsign.model.AudittedComplementSign;
import com.hr.complementsign.model.PendingComplementSign;
import com.hr.complementsign.repository.Impl.AudittedSignRepository;
import com.hr.complementsign.repository.Impl.PendingSignRepository;
import com.hr.complementsign.service.ComplementSignService;
import com.hr.login.model.LoginModel;
import com.hr.overtime.model.OverTimePending;
import com.hr.overtime.service.bean.PublicReponse;

@Controller
@SessionAttributes("loginModel")
public class ComplementSignController {
	
	@Autowired
	ComplementSignService complementSignService;
	//表單申請&查詢部分
	@GetMapping(path = "/EmpSignApply")
	public String EmpComplementSign(Model model, LoginModel loginModel) {
		String empNo = loginModel.getEmpNo();
		List<PendingComplementSign> pendingComplementSign = complementSignService.findPartPendingComplementSign(empNo);
		model.addAttribute("pendingComplementSign", pendingComplementSign);
		List<AudittedComplementSign> audittedComplementSign = complementSignService.findPartAudittedComplementSign(empNo);
		model.addAttribute("audittedComplementSign", audittedComplementSign);
		
		return "complementSign/complementSignForm";
	}
	
	//查詢全部
	@GetMapping(path = "/EmpSignQuery")
	public String EmpQueryComplementSign() {
		return "complementSign/employeeSign";
	}
	
	@PostMapping(path = "/saveEmpComplementSign")
	public void savePendingComplementSign(@RequestBody PendingComplementSign pendingComplementSign,LoginModel loginModel) throws ParseException {
		String empName = loginModel.getName();
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
	@Autowired
	PendingSignRepository  pendingSignRepository;
	
	@Autowired
	AudittedSignRepository audittedSignRepository;
	
	@GetMapping(path = "/empPendingQuery")
	@ResponseBody
	public PublicReponse EmpFindAllByPendingComplementSign(@RequestParam(value="pageNo",required = false)String pageNo,
			@RequestParam(value="keyword",required = false)String keyword,@RequestParam(value="date",required = false)String date,
			LoginModel loginModel) {
		String empNo = loginModel.getEmpNo();
		int pageNumber = pageNo == null || "null".equals(pageNo) ? 0 : Integer.parseInt(pageNo) -1;
		Sort sort = Sort.by(Direction.DESC, "date");
		Pageable page = PageRequest.of(pageNumber, 5, sort);
		Page<PendingComplementSign> result = pendingSignRepository.findPendingSignByEmpNo(page, empNo, date, null);
		List<PendingComplementSign> pendingComplementSign = result.getContent();
		PublicReponse response = new PublicReponse();
		
		response.setCurrentPage(pageNumber +1);
		response.setResult(pendingComplementSign);
		response.setTotalPage(result.getTotalPages());
		
		return response ;
	}
	
	@GetMapping(path = "/empAudittedQuery")
	@ResponseBody
	public PublicReponse EmpFindAllByAudittedComplementSign(@RequestParam(value="pageNo",required = false)String pageNo,
			@RequestParam(value="keyword",required = false)String keyword,@RequestParam(value="date",required = false)String date,LoginModel loginModel) {
		String empNo = loginModel.getEmpNo();
		int pageNumber = pageNo == null || "null".equals(pageNo) ? 0 : Integer.parseInt(pageNo) -1;
		Sort sort = Sort.by(Direction.DESC, "date");
		Pageable page = PageRequest.of(pageNumber, 5, sort);
		Page<AudittedComplementSign> result = audittedSignRepository.findAudittedSignByEmpNo(page, empNo, date, null);
		List<AudittedComplementSign> audittedComplementSign = result.getContent();
		PublicReponse response = new PublicReponse();
		
		response.setCurrentPage(pageNumber +1);
		response.setResult(audittedComplementSign);
		response.setTotalPage(result.getTotalPages());
		
		return response ;
	}
	
//-------------------------------------------------管理員-------------------------------------------------------	
	
	@GetMapping(path = "/ManagerSignAllQuery")
	public String ManagerQuery() {
		return "complementSign/managerSign" ;
	}
	@GetMapping(path = "/ManagerSignQuery")
	@ResponseBody
	public PublicReponse MangerQueryApprove(@RequestParam(value="pageNo",required = false)String pageNo,
			@RequestParam(value="keyword",required = false)String keyword,@RequestParam(value="date",required = false)String date,
			LoginModel loginModel) {
		int managerEmpId = loginModel.getDepartmentDetail().getManagerEmpId();
		int pageNumber = pageNo == null || "null".equals(pageNo) ? 0 : Integer.parseInt(pageNo) -1;
		Sort sort = Sort.by(Direction.DESC, "date");
		Pageable page = PageRequest.of(pageNumber, 5, sort);
		Page<PendingComplementSign> result = pendingSignRepository.findPendingSignByEmpNo(page, null, date, managerEmpId);
		List<PendingComplementSign> pendingComplementSign = result.getContent();
		PublicReponse response = new PublicReponse();
		
		response.setCurrentPage(pageNumber +1);
		response.setResult(pendingComplementSign);
		response.setTotalPage(result.getTotalPages());
		
		return response ;
		
	}
	
	@PostMapping(path = "/ManagerSignAudit")
	@ResponseBody
	public void saveAudittedComplementSign(@RequestParam("type") String type , @RequestParam("id") int id) throws Exception{
		 PendingComplementSign pendingComplementSign = complementSignService.findById(id);
		 complementSignService.saveAudittedComplementSign(pendingComplementSign ,type);
		 complementSignService.deletePendingComplementSign(pendingComplementSign);
		
		 complementSignService.updateCheckSystemTime(pendingComplementSign,type);
		 
			
	}
}
