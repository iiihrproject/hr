package com.hr.personnel.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.hr.login.model.LoginModel;
import com.hr.personnel.service.AddNewPersonnelService;

@Controller
@SessionAttributes({"loginModel" ,"modifiedLoginModel"})
public class AddNewPersonnelController {
	
	@Autowired
	AddNewPersonnelService addNewPersonnelService;
	
	@GetMapping(path="/addNewPersonnel")
	public String addNewPersonnel() {
		return "/personnel/addNewPersonnel";
	}
	
	@PostMapping(path="/createNewPersonnel", produces="application/json", consumes="application/json")
	public @ResponseBody Map<String, String> createNewPersonnel(
			@RequestBody Map<String, String> inputMap,
			Model model
			) {		
		boolean flowCheck = addNewPersonnelService.createNewPersonnel(inputMap);
		LoginModel loginModel = null;
		Map<String, String> map = new HashMap<String, String>();;
		if(flowCheck) {
			loginModel = addNewPersonnelService.getLoginModelByEmpNo(inputMap.get("empNo"));
			if(loginModel != null) {
				map.put("role", loginModel.getRole());
				map.put("personalIdNumber", loginModel.getPersonalIdNumber());
				map.put("name", loginModel.getName());
				map.put("gender", loginModel.getGender());
				map.put("empNo", loginModel.getEmpNo());
				map.put("departmentNumber", loginModel.getDepartmentDetail().getDepartmentNumber().toString());
				model.addAttribute("modifiedLoginModel", loginModel);
			}
			else {
				map.put("result", "Loading new personnel failed");
			}
		}
		else {
			map.put("result", "Creating new personnel failed");
		}
		return map;
	}
	
}
