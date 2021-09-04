package com.hr.schedule.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.hr.login.model.LoginModel;
import com.hr.schedule.model.EmpBean;
import com.hr.schedule.model.FactSchedule;
import com.hr.schedule.service.ScheduleService;

@Controller
@SessionAttributes("loginModel")
public class ScheduleController {
	
	@Autowired
	private ScheduleService service;
	//去我的班表頁面
	@GetMapping(value="/schedule/MySchedule")
	public String queryAllSchedule(Model model, @ModelAttribute("loginModel") LoginModel loginModel) {
//		List<FactSchedule> schedule = service.findAllSchedule();
//		model.addAttribute("allSchedule",schedule);
//		return "schedule/MySchedule";
//		<!-- 以下兩個是一組的 --!>
		model.addAttribute("body", "schedule/MySchedule.jsp");
		return "layout/Template";
	}
	
	//看全部班表
	@GetMapping(value="/schedule/findAllScheduleAjax")
	public @ResponseBody List<FactSchedule> findAllSchedule(){
		return service.findAllSchedule();
	}
	
//	看該部門班表
	@GetMapping("/schedule/findScheduleByDeptNo")
	public @ResponseBody List<FactSchedule> findScheduleByDeptNo(@RequestParam("deptNo") Integer deptNo){
		return service.findScheduleByDeptNo(deptNo);
	}
	
	//去fullCalendar排班頁面，似乎沒用到
	@GetMapping("/schedule/getEmp")
	public String queryAllEmp(Model model) {
		List<EmpBean> Emps = service.findAllEmps();
		model.addAttribute("allEmps", Emps);
		return "schedule/TimelineScheduling";
	}
	
	//找所有員工，似乎沒用到
	@GetMapping("/schedule/findAllEmps")
	public @ResponseBody List<EmpBean> findAll(){
		return service.findAllEmps();
	}
	
//	新增單筆
	@PostMapping("/schedule/addSchedule")
	public @ResponseBody Map<String, String> saveSchedule(@RequestBody FactSchedule schedule) {
		Map<String, String> map = new HashMap<>();
		int n = 0;
		try {
			n = service.saveSchedule(schedule);
			if (n == 1) {
				map.put("success", "新增成功");
			} else if (n == -1) {
				map.put("fail", "新增失敗");
			}
		} catch (Exception e) {
			map.put("fail", e.getMessage());
			e.printStackTrace();
		}
		return map;
	}
	
//	刪除單筆
	@DeleteMapping("/schedule/{keySchedule}")
	public @ResponseBody Map<String, String> deleteScheduleByKey(@PathVariable(required = true) Integer keySchedule) {
		Map<String, String> map = new HashMap<>();
		try {
			service.deleteScheduleByKey(keySchedule);
			map.put("success","刪除成功");
		}catch (Exception e) {
			e.printStackTrace();
			map.put("fail", "刪除失敗");
			System.out.println("刪除失敗");
		}
		return map;
	}
	
	// 讀取並傳回單筆會員資料
	@GetMapping("/schedule/{keySchedule}")
	public @ResponseBody FactSchedule showEditSchedule(@PathVariable Integer keySchedule) {
		FactSchedule schedule = service.findSchedByPK(keySchedule);
		return schedule;
	}

	// 修改單筆會員資料
	@PutMapping(value = "/schedule/{keySchedule}", consumes = { "application/json" }, produces = { "application/json" })
	public @ResponseBody Map<String, String> updateSchedule(@RequestBody FactSchedule schedule, 
															@PathVariable Integer keySchedule) {
		FactSchedule sched = null;
		if (keySchedule != null) {
			sched = service.findSchedByPK(keySchedule);
			if (sched == null) {
				throw new RuntimeException("鍵值不存在, key=" + keySchedule);
			}
//			service.evictSchedule(sched);
		} else {
			throw new RuntimeException("鍵值不存在, key=" + keySchedule);
		}
//		copyUnupdateField(sched, schedule);

		Map<String, String> map = new HashMap<>();
		try {
			service.updateSchedule(schedule);
			map.put("success", "更新成功");
		} catch (Exception e) {
			e.printStackTrace();
			map.put("fail", "更新失敗");
		}
		return map;
	}
	
	//去fullCalendar排班頁面
	@GetMapping("/schedule/TimelineScheduling")
	public String toSchedule(Model model) {
		model.addAttribute("body", "schedule/TimelineScheduling.jsp");
		return "layout/Template";
	}
	//去表格排班葉面
	@GetMapping("/schedule/TableScheduling")
	public String TableScheduling(Model model) {
		model.addAttribute("body", "schedule/TableScheduling.jsp");
		return "layout/Template";
	}
	@GetMapping("/module")
	public String module() {
		return "module";
	}
	@GetMapping("/module-1")
	public String module_1() {
		return "module-1";
	}
	@GetMapping("/Template")
	public String template() {
		return "layout/Template";
	}
	
}//end of class
