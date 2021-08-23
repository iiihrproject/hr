package com.hr.leave.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.hr.leave.model.LeaveBean;
import com.hr.leave.model.ListBean;
import com.hr.leave.service.LeaveService;
import com.hr.login.model.LoginModel;
import com.hr.login.service.LoginService;
import com.hr.personnel.model.Personnel;

@Controller
@RequestMapping("/Leave")
@SessionAttributes("loginModel")
public class LeaveController {

	@Autowired
	private LeaveService service;
	@Autowired
	private LoginService loginService;

//	@DeleteMapping("/leave/{applicationNo}")
//	public String deleteOne(@RequestParam("applicationNo") String applicationNo) {
//		service.delete(applicationNo);
//		return "redirect:/LeavaApplication/GetList";
//	}
	
//	找清單內容
	@GetMapping(value="/findListByCAT",produces= {"application/json; charset=UTF-8"})
	public @ResponseBody List<ListBean> findListByCategory(@RequestParam("category") String category) {
		return service.findListByCategory(category);
	}
	
//	找同事的email
	@GetMapping(value="/findEmpByPk")
	public @ResponseBody List<Personnel> findEmpByPk(@RequestParam("empId") Integer empId) {
		return service.findEmpByPk(empId);
	}
	
//	找員工資訊
	@GetMapping(value="/findEmpByEmpNo")
	public @ResponseBody LoginModel findEmpByEmpNo(@RequestParam("empNo") String empNo) {
		return loginService.getLoginModelByEmpNo(empNo);
	}
	
//	找同部門的同事
	@GetMapping(value="/findEmpsByDept")
	public @ResponseBody List<LoginModel> findEmpsByDept(@RequestParam("departmentNumber") Integer departmentNumber) {
		return service.findEmpsByDept(departmentNumber);
	}
	
//  頁面到請假申請
	@GetMapping("/")
	public String toLeaveApplication(Model m) {
		m.addAttribute("body", "leave/ApplyList.jsp");
		return "layout/Template";
	}
//	頁面到查詢詳情
	@GetMapping("/LeaveResult")
	public String InsertLeaveResult(Model model) {
		model.addAttribute("body", "leave/LeaveResult.jsp");
		return "layout/Template";
	}
//	查詢所有請假紀錄
	@GetMapping("/findAllLeave")
	public @ResponseBody List<LeaveBean> findAllLeave() {
		return service.findAllLeave();
	}
	
//	查詢部門的請假紀錄
	@GetMapping("/findLeaveByDeptNo")
	public @ResponseBody List<LeaveBean> findLeaveByDeptNo(@RequestParam("departmentNumber") Integer departmentNumber) {
		return service.findLeaveByDeptNo(departmentNumber);
	}
	
//	查詢本人的請假紀錄
	@GetMapping("/findLeaveByEmpNo")
	public @ResponseBody List<LeaveBean> findLeaveByEmpNo(@ModelAttribute("loginModel") LoginModel loginModel) {
		return service.findLeaveByEmpNo(loginModel.getEmpNo());
	}

	@PostMapping("/Insert")
	public @ResponseBody Map<String, String> save(@RequestBody LeaveBean leave) {
		Map<String, String> map = new HashMap<>();
		String result = "";
		try {
			System.out.println(leave);
			service.save(leave);
			result = "新增成功";
			map.put("success", result);
		} catch (Exception e) {
			e.printStackTrace();
			result = e.getMessage();
			map.put("fail", result);
		}
		return map;
	}

//	@GetMapping("/Leave/GetOne")
//	public String GetOne(@RequestParam("applicationNo") String applicationNo, Model m) {
//		LeaveBean leave = service.select(applicationNo);
//		m.addAttribute("reasonList", leaveBeanDao.getReasonList());
//		m.addAttribute("leave", leave);
//		return "LeaveApplication/EditLeaveForm";
//	}
//
//	@PostMapping("/Insert")
//	public String Insert(HttpServletRequest request, @RequestParam("reason") String reason_id,
//			@RequestParam("startDate") String startDate, @RequestParam("startTime") String startTime,
//			@RequestParam("endDate") String endDate, @RequestParam("endTime") String endTime,
//			@RequestParam("comments") String comments, @RequestParam("hand-off") String handOff,
//			@RequestParam("hand-offemail") String handOffemail, @RequestParam("supportingDoc") String supportingDoc,
//			Model m) throws ParseException {
//		try {
//			HttpSession session2 = request.getSession();
//			String empNo = (String) session2.getAttribute("empid");
//			LeaveBean leave = service.insert(empNo, reason_id, startDate, startTime, endDate, endTime, comments,
//					handOff, handOffemail, supportingDoc);
//			m.addAttribute("leave", leave);
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		return "LeaveApplication/InsertLeaveResult";
//	}
//
//	@PostMapping("/Leave/update")
//	public String Update(@RequestParam("applicationNo") String applicationNo, @RequestParam("reason") String reason,
//			@RequestParam("startDate") String startDate, @RequestParam("startTime") String startTime,
//			@RequestParam("endDate") String endDate, @RequestParam("endTime") String endTime,
//			@RequestParam("comments") String comments, @RequestParam("hand-off") String handOff,
//			@RequestParam("hand-offemail") String handOffemail, @RequestParam("supportingDoc") String supportingDoc,
//			HttpServletRequest request, Model m) throws ParseException {
//		HttpSession session2 = request.getSession();
//		String empNo = (String) session2.getAttribute("empid");
//		String days = "0.5";
//		try {
//			LeaveBean leave = service.update(empNo, applicationNo, reason, startDate, startTime, endDate, endTime, days,
//					comments, handOff, handOffemail, supportingDoc);
//			m.addAttribute("leave", leave);
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		return "LeaveApplication/InsertLeaveResult";
//	}

//	@PostMapping("/LeaveApplication/")
//	public String SetSession(@RequestParam("account") String empNo, HttpServletRequest request) {
//		HttpSession session = request.getSession();
//		session.setAttribute("empid", empNo);
//		return "frame/index";
//	}
}
