package com.hr.schedule.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hr.schedule.model.EmpBean;
import com.hr.schedule.model.FactSchedule;
import com.hr.schedule.service.ScheduleService;

@Controller
public class ScheduleController {
	
	@Autowired
	private ScheduleService service;
	

	@GetMapping(value="/schedule/MySchedule")
	public String queryAllSchedule(Model model) {
		List<FactSchedule> schedule = service.findAllSchedule();
		model.addAttribute("allSchedule",schedule);
		return "schedule/MySchedule";
	}
	@GetMapping(value="/schedule/findAllScheduleAjax")
	public @ResponseBody List<FactSchedule> findAllSchedule(){
		return service.findAllSchedule();
	}
	
	@GetMapping("/schedule/getEmp")
	public String queryAllEmp(Model model) {
		List<EmpBean> Emps = service.findAllEmps();
		model.addAttribute("allEmps", Emps);
		return "schedule/TimelineScheduling";
	}
	@GetMapping("/schedule/getEmp/findAll")
	public @ResponseBody List<EmpBean> findAll(){
		return service.findAllEmps();
	}
	
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
		}
		return map;
	}

	@GetMapping("/schedule/TimelineScheduling")
	public String toSchedule() {
		return "schedule/TimelineScheduling";
	}
	@GetMapping("/schedule/tableScheduling")
	public String tableScheduling() {
		return "schedule/tableScheduling";
	}
	@GetMapping("/module")
	public String module() {
		return "module";
	}
	@GetMapping("/module-1")
	public String module_1() {
		return "module-1";
	}
	@GetMapping("/template")
	public String template() {
		return "schedule/template";
	}
	
}//end of class
