package com.hr.checksystem.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
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
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.hr.checksystem.model.Checksystem;
import com.hr.checksystem.repository.Impl.CheckSystemRepository;
import com.hr.checksystem.service.CheckService;
import com.hr.login.model.LoginModel;
import com.hr.overtime.service.bean.PublicReponse;
import com.hr.schedule.model.FactSchedule;

@Controller
@SessionAttributes("loginModel")
public class ChecksystemController {

	@Autowired
	CheckService checkService;
	
	@Autowired
	HttpServletRequest request;
	
	@GetMapping(path = "/checkInto")
	public String checkInto(Model model ,LoginModel loginModel) {
//		HttpSession httpSession = request.getSession(true);
		String empNo = loginModel.getEmpNo();
//		String empNo = (String)httpSession.getAttribute("empNo");
//		empNo = "123";
		
		Date time = new Date();
		SimpleDateFormat sdfDate = new SimpleDateFormat("yyyy-MM-dd");
		String today = sdfDate.format(time).toString();
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.DATE,   -1);
		String yesterday = new SimpleDateFormat("yyyy-MM-dd").format(cal.getTime());
		FactSchedule factSchedule = checkService.getFactSchedule(yesterday, loginModel.getPk());
		FactSchedule factScheduleToday = checkService.getFactSchedule(today, loginModel.getPk());
		model.addAttribute("factSchedule" ,factScheduleToday);
		
		System.out.println(loginModel.getPk());
		//???????????????????????????????????????  ???????????????
		if(factSchedule != null) {
			
			Checksystem checksystem1 = checkService.findYesterdayCheckSystemByEmpno(empNo);
			
			String errorMsg = null;
			
			if(checksystem1 == null) {
				//?????????
				errorMsg = "????????????!!?????????~????????????????????????";
				
			}else {
				
				System.out.println(checksystem1.getCheckInTime());
				
				if(checksystem1.getCheckInTime() == null || checksystem1.getCheckOutTime() == null) {
					errorMsg = "????????????!!?????????~????????????????????????";
				}
				
			}
			
			model.addAttribute("errorMsg",errorMsg);
			
		}
		
		List<Checksystem> checksystem = checkService.findPartCheckSystem(empNo,5);
		model.addAttribute("Checksystem",checksystem);
		
		return "checksystem/checksystem";
	}
	
	@PostMapping(path ="/saveCheckSystem")
	@ResponseBody
	public String saveCheckSystem(@RequestParam("type") String type, Model model,LoginModel loginModel) throws Exception {
//		HttpSession httpSession = request.getSession(true);
//		String empNo = (String)httpSession.getAttribute("empNo");
		String empNo = loginModel.getEmpNo();
		String empName = loginModel.getName();
		Date time = new Date();
		String depName = loginModel.getDepartmentDetail().getName();
		SimpleDateFormat sdfDate = new SimpleDateFormat("yyyy-MM-dd");
		SimpleDateFormat sdfTime = new SimpleDateFormat("HH:mm:ss");
		String sDAte = sdfDate.format(time).toString();
		String sTime = sdfTime.format(time).toString();
		
		Checksystem checksystem = checkService.findTodayCheckSystemByEmpno(empNo);
		System.out.println(checksystem);
		//yyyy-MM-dd HH:mm:ss
		Date checkTime = checkService.getTimeByType(type,sDAte,loginModel.getPk());
		
		System.out.println("checkTime = " + checkTime);
		
		//???????????????????????????????????????
		if(checkTime == null) return "????????????????????????????????????????????????!";
		
		
		double times = checkService.judgmentDate(checkTime, time);
		
		//??????????????????
		if(checksystem == null ) {
			
			//?????? or ????????????
			
						//Y,N
//				String checklate = null;
//				if (times > 0) {
//					checklate = "Y";
//				}
//				else {
//					checklate = "N";
//				}
			//????????????????????????????????? ??????
			boolean isNotOnTime = false;
			if("checkIn".equals(type)) {
				isNotOnTime = times > 0;
			}else {
				isNotOnTime = times >= 0;
			}
			String isLate = isNotOnTime ? "Y" : "N";
			
			checksystem = new Checksystem();
			checksystem.setEmpName(empName);
			checksystem.setEmpNo(empNo);
			checksystem.setDepName(depName);
			
			if("checkIn".equals(type)) {
				checksystem.setCheckInTime(time);
				checksystem.setIsLateCheckIn(isLate);
			}else if("checkOut".equals(type)) {
				checksystem.setCheckOutTime(time);
				checksystem.setIsOnTimeCheckOut(isLate);
			}
			 
			checkService.saveChecksystem(checksystem);
			
			
			//???????????? ??????????????????????????????????????????
		}else {
			
			if("checkIn".equals(type)) {
				//????????????<????????????
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
						System.out.println("??????");
						return "????????????????????????????????????????????????!!";

					}
				}
				
			}else {
				
				checksystem.setCheckOutTime(time);
				checksystem.setIsOnTimeCheckOut(times >= 0 ? "Y" : "N");
				checkService.saveChecksystem(checksystem);
				System.out.println(times);
			}
			
		}
		return "Success";
		
	}
	
	@GetMapping(path = "/findCheckByEmpno")
	public @ResponseBody List<Checksystem> findCheckSystemByEmpNo(LoginModel loginModel) {
//		HttpSession httpSession = request.getSession(true);
//		String empNo = (String)httpSession.getAttribute("empNo");
//		empNo = "123";
		String empNo = loginModel.getEmpNo();
		List<Checksystem> checksystem = checkService.findCheckSystemByEmp(empNo);
		
		return checksystem ;
	}

	@Autowired
	CheckSystemRepository checkSystemRepository ;
	
	@GetMapping(path = "/findCheckByEmp")
	public String findCheckSystemByEmpno(Model model,@RequestParam(value="pageNo",required = false)Integer pageNo,
			@RequestParam(value="date",required = false)String date,LoginModel loginModel) {
//		HttpSession httpSession = request.getSession(true);
//		String empNo = (String)httpSession.getAttribute("empNo");
//		empNo = "123";
		String empNo = loginModel.getEmpNo();
		
		pageNo = pageNo == null ? 0 : pageNo-1;
		
		Pageable page = PageRequest.of(pageNo, 10);
		
		Page<Checksystem> checkSystemPage = checkSystemRepository.findByEmpNo(page, empNo,date);
		
		List<Checksystem> checksystem = checkSystemPage.getContent();
		
		model.addAttribute("Checksystem", checksystem );
		model.addAttribute("totalPage", checkSystemPage.getTotalPages());
		
		return  "checksystem/CheckResult";
	}
//	<-------------------------------------------------?????????----------------------------------------------------->
	
	@GetMapping(path = "/mangerCheckQuery")
	public String managerCheckSystem() {
		return "checksystem/managerCheck";
	}
	
	
	@GetMapping(path = "/findAllCheck")
	public @ResponseBody PublicReponse findCheckSystem(@RequestParam(value="pageNo",required = false)String pageNo,
			@RequestParam(value="depName",required = false)String depName,@RequestParam(value="date",required = false)String date,
			LoginModel loginModel) {
		
		System.out.println("date = " + date);
		 
		int pageNumber = pageNo == null || "null".equals(pageNo) ? 0 : Integer.parseInt(pageNo) -1;
		Pageable page = PageRequest.of(pageNumber, 5);
		Page<Checksystem> CheckResult = checkSystemRepository.findAllCheck(page, date, depName);
		List<Checksystem> managerCheckQuery = CheckResult.getContent();
		
		PublicReponse response = new PublicReponse();
		response.setResult(managerCheckQuery);
		response.setTotalPage(CheckResult.getTotalPages());
		response.setCurrentPage(pageNumber + 1);
		
		return response ;
	}
//	<-------------------------------------------------????????????----------------------------------------------------->	
	@GetMapping(path = "/empCheck")
	public String empCheckSystem() {
		return "checksystem/empCheckResult";
	}
	
	//????????????
	@GetMapping(path = "/intoQuery")
	public String intoQuery() {
		return "exceptionquery";
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
