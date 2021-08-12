package com.hr.checksystem.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hr.checksystem.model.Checksystem;
import com.hr.checksystem.repository.Impl.CheckSystemRepository;
import com.hr.checksystem.service.CheckService;

@Controller
public class ChecksystemController {

	@Autowired
	CheckService checkService;
	
	@Autowired
	HttpServletRequest request;
	
	@GetMapping(path = "/checkInto")
	public String checkInto(Model model) {
		HttpSession httpSession = request.getSession(true);
		String empNo = (String)httpSession.getAttribute("empNo");
		empNo = "123";
		Checksystem checksystem1 = checkService.findYesterdayCheckSystemByEmpno(empNo);
		
		String errorMsg = null;
		
		if(checksystem1 == null) {
			//沒打卡
			errorMsg = "昨天沒打卡 扣1000";
			
		}else {
			
			System.out.println(checksystem1.getCheckInTime());
			
			if(checksystem1.getCheckInTime() == null || checksystem1.getCheckOutTime() == null) {
				errorMsg = "昨天沒打卡 扣1000";
			}
			
		}
		List<Checksystem> checksystem = checkService.findPartCheckSystem(empNo,4);
		System.out.println("size = " + checksystem.size());
		
		model.addAttribute("Checksystem",checksystem);
		model.addAttribute("errorMsg",errorMsg);
		
		return "checksystem/checksystem";
	}
	
	@PostMapping(path ="/saveCheckSystem")
	@ResponseBody
	public String saveCheckSystem(@RequestParam("type") String type, Model model) throws Exception {
		System.out.println(type);
		HttpSession httpSession = request.getSession(true);
		String empNo = (String)httpSession.getAttribute("empNo");
		Date time = new Date();
		SimpleDateFormat sdfDate = new SimpleDateFormat("yyyy-MM-dd");
		SimpleDateFormat sdfTime = new SimpleDateFormat("HH:mm:ss");
		String sDAte = sdfDate.format(time).toString();
		String sTime = sdfTime.format(time).toString();
		empNo = "123";
		
		Checksystem checksystem = checkService.findTodayCheckSystemByEmpno(empNo);
		System.out.println(checksystem);
		//yyyy-MM-dd HH:mm:ss
		Date checkTime = checkService.getTimeByType(type);
		System.out.println(type);
		
		double times = checkService.judgmentDate(checkTime, time);
		
		
		//空的直接新增
		if(checksystem == null ) {
			
			//上班 or 下班時間
			
						//Y,N
//			String checklate = null;
//			if (times > 0) {
//				checklate = "Y";
//			}
//			else {
//				checklate = "N";
//			}
			//判斷是否上班或下班遲到 早退
			boolean isNotOnTime = false;
			if("checkIn".equals(type)) {
				isNotOnTime = times > 0;
			}else {
				isNotOnTime = times > 0;
			}
			String isLate = isNotOnTime ? "Y" : "N";
			
			checksystem = new Checksystem();
			checksystem.setEmpNo(empNo);
			
			if("checkIn".equals(type)) {
				checksystem.setCheckInTime(time);
				checksystem.setIsLateCheckIn(isLate);
			}else if("checkOut".equals(type)) {
				checksystem.setCheckOutTime(time);
				checksystem.setIsOnTimeCheckOut(isLate);
			}
			 
			checkService.saveChecksystem(checksystem);
			
			
			//不是空的 判斷打卡時間是否小於上班時間
		}else {
			
			if("checkIn".equals(type)) {
				//打卡時間<上班時間
				if( time.compareTo(checkTime) == -1 ) {
					
					checksystem.setCheckInTime(time);
					checksystem.setIsLateCheckIn(times > 0 ? "Y" : "N");
					checkService.saveChecksystem(checksystem);
				}else {
					
					if(checksystem.getCheckInTime() == null) {
						checksystem.setCheckInTime(time);
						checksystem.setIsLateCheckIn(times > 0 ? "Y" : "N");
						checkService.saveChecksystem(checksystem);
					}else {
						System.out.println("重複");
						return "今天已經打過上班了，不能重複打卡!!";

					}
				}
				
			}else {
				
				checksystem.setCheckOutTime(time);
				checksystem.setIsOnTimeCheckOut(times > 0 ? "Y" : "N");
				checkService.saveChecksystem(checksystem);
				System.out.println(times);
			}
			
		}
		return "Success";
		
	}
	
	@GetMapping(path = "/findCheckByEmpno")
	public @ResponseBody List<Checksystem> findCheckSystemByEmpNo() {
		HttpSession httpSession = request.getSession(true);
		String empNo = (String)httpSession.getAttribute("empNo");
		empNo = "123";
		List<Checksystem> checksystem = checkService.findCheckSystemByEmp(empNo);
		
		return checksystem ;
	}

	@Autowired
	CheckSystemRepository checkSystemRepository ;
	
	@GetMapping(path = "/findCheckByEmp")
	public String findCheckSystemByEmpno(Model model,@RequestParam(value="pageNo",required = false)Integer pageNo,
			@RequestParam(value="date",required = false)String date) {
		HttpSession httpSession = request.getSession(true);
		String empNo = (String)httpSession.getAttribute("empNo");
		empNo = "123";
		
		pageNo = pageNo == null ? 0 : pageNo-1;
		
		Pageable page = PageRequest.of(pageNo, 10);
		
		Page<Checksystem> checkSystemPage = checkSystemRepository.findByEmpNo(page, empNo,date);
		
		List<Checksystem> checksystem = checkSystemPage.getContent();
		
		model.addAttribute("Checksystem", checksystem );
		model.addAttribute("totalPage", checkSystemPage.getTotalPages());
		
		return  "checksystem/CheckResult";
	}
//	<-------------------------------------------------管理員----------------------------------------------------->
	@GetMapping(path = "/findAllCheck")
	public @ResponseBody List<Checksystem> findCheckSystem() {
		List<Checksystem> checksystem = checkService.findAllCheckSystem();
		
		return checksystem ;
	}
//	<-------------------------------------------------員工查詢----------------------------------------------------->	
	@GetMapping(path = "/empCheck")
	public String manageCheckSystem() {
		return "checksystem/empCheckResult";
	}
	
//	@GetMapping(path = "/manageCheck1")
//	public String manageCheckSystem1(Model model) {
//		String empNo = "123";
//		List<Checksystem> checksystem = checkService.findPartCheckSystem(empNo,4);
//		System.out.println("size = " + checksystem.size());
//		
//		model.addAttribute("Checksystem",checksystem);
//		return "checksystem/pages";
//	}
	
//	public static void main(String args[]) throws Exception {
//		String time = "09:00:00";
//		
//		SimpleDateFormat sdf = new SimpleDateFormat("HH:mm:ss");
//		Date date = sdf.parse(time);
//		
//		System.out.println(date);
//	}

}
