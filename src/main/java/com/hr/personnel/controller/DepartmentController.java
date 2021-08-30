package com.hr.personnel.controller;

import java.util.HashMap;
import java.util.Map;

import javax.websocket.server.PathParam;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.hr.login.model.LoginModel;
import com.hr.personnel.model.DepartmentDetail;
import com.hr.personnel.service.DepartmentService;


@Controller
public class DepartmentController {
	
	@Autowired
	DepartmentService departmentService;
	
	@GetMapping(path="/department")
	public String department() {
		
		return "/personnel/departmentDetail";
	}
	
	/**
	 * This controller is meant to find the table of department name and the name of the manager of the department
	 * @return
	 */
	@GetMapping(path="/departmentDetail", produces="application/json")
	public @ResponseBody Map<Integer, Map<String, String>> editDepartmentDetail() {
		Map<Integer, Map<String, String>> map = new HashMap<Integer, Map<String, String>>();
		map = departmentService.findAllDepartmentDetail();
		
		return map;
	}
	
	@PutMapping(path="/departmentManagerNoUpdate", produces="application/json", consumes="application/json")
	public @ResponseBody Map<Integer, Map<String, String>> departmentManagerIdUpdate(
			@RequestBody Map<String, String> inputMap
			) {
		Map<Integer, Map<String, String>> map = new HashMap<Integer, Map<String, String>>();
		map = departmentService.findAllDepartmentDetailWithReplacementOfNewManager(inputMap);
		
		return map;
	}
	
	@GetMapping(path="/addNewDepartment")
	public String addNewDepartment() {
		
		return "/personnel/addNewDepartment";
	}
	
	@PostMapping(path="/createNewDepartment", consumes="application/json", produces="application/json")
	public @ResponseBody Map<String, String> createNewDepartment(
			@RequestBody Map<Integer, Map<String, String>> inputMap
			) {
		boolean flowCheck = false;
		flowCheck = departmentService.insertNewDepartments(inputMap);
		Map<String, String> map = new HashMap<String, String>();
		if(flowCheck) {
			map.put("result", "Update success");
			return map;
		}
		map.put("result", "Update failure");
		return map;
	}	
}