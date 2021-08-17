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

import com.hr.schedule.model.DimShift;
import com.hr.schedule.service.ShiftService;

@Controller
public class ShiftController {
	public ShiftController() {}
		ShiftService service;
		
	@Autowired
	public void setService(ShiftService service) {
		this.service= service;
	}
	@GetMapping(value="/schedule/shifts")
	public String queryAllShift(Model model) {
//		List<DimShift> shifts = service.findAllShifts();
//		model.addAttribute("allShift", shifts);
//		return "schedule/ShiftList";
		model.addAttribute("body", "schedule/ShiftList.jsp");
		return "layout/Template";
	}
	@GetMapping(value="/schedule/shifts/findAll")
	public @ResponseBody List<DimShift> findAllShifts(){
		return service.findAllShifts();
	}
	
	@PostMapping("/schedule/shifts/addShift")
	public @ResponseBody Map<String, String> save(@RequestBody DimShift shift) {
		Map<String, String> map = new HashMap<>();
		int n = 0;
		try {
			n = service.saveShift(shift);
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
}// end of class
