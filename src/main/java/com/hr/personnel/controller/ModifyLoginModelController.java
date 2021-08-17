package com.hr.personnel.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.hr.login.model.LoginModel;
import com.hr.personnel.service.ModifyLoginModelService;

@Controller
@SessionAttributes("loginModel")
public class ModifyLoginModelController {
	
	@Autowired
	ModifyLoginModelService modifyLoginModelService;
	
	@GetMapping("/modifyLoginModel")
	public String editLoginModePage() {
		return "/personnel/modifyLoginModel";
	}
	
	@PostMapping(path="/searchLoginModel", produces="application/json")
	public @ResponseBody Map<String, String> searchLoginModel(
			@RequestBody String inputEmpNo
			) {
		LoginModel loginModel = modifyLoginModelService.loadByEmpNo(inputEmpNo);
		Map<String, String> map = new HashMap<String, String>();
		return map;
	}
}
