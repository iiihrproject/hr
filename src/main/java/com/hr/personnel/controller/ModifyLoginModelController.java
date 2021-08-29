package com.hr.personnel.controller;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.hr.login.model.Authorities;
import com.hr.login.model.LoginModel;
import com.hr.personnel.service.ModifyLoginModelService;

@Controller
@SessionAttributes({"loginModel" ,"modifiedLoginModel"})
public class ModifyLoginModelController {
	
	@Autowired
	ModifyLoginModelService modifyLoginModelService;
	
	@GetMapping("/modifyLoginModel")
	public String editLoginModePage() {
		return "/personnel/modifyLoginModel";
	}

	@PostMapping(path="/searchLoginModel", produces="application/json")
	public @ResponseBody Map<String, String> searchLoginModel(
			@RequestParam(value = "inputEmpNo") String inputEmpNo,
			Model model
			) {
		LoginModel loginModel = modifyLoginModelService.loadByEmpNo(inputEmpNo);
		Map<String, String> map = new HashMap<String, String>();
		if(loginModel != null) {
			map = modifyLoginModelService.getReturnMap(loginModel);
			model.addAttribute("modifiedLoginModel", loginModel);
		}
		else {
			map.put("result", "Employee number not found");
		}
		return map;
	}
	
	@PutMapping(path="/modify", produces="application/json", consumes="application/json")
	public @ResponseBody Map<String, String> modify(
			Model model,
			@RequestBody Map<String, String> inputMap,
			@ModelAttribute("modifiedLoginModel") LoginModel modifiedLoginModel
			) {
		boolean flowCheckUpdateLoginModel = modifyLoginModelService.updateLoginModel(inputMap, modifiedLoginModel);
		boolean flowCheckUpdateAuthorities = modifyLoginModelService.updateAuthorities(inputMap, modifiedLoginModel);
		LoginModel loginModel = null;
		if(flowCheckUpdateLoginModel && flowCheckUpdateAuthorities) {
			loginModel = modifyLoginModelService.loadByPk(modifiedLoginModel.getPk());
		}
		Map<String, String> map = new HashMap<String, String>();
		
		if(loginModel != null) {
			map = modifyLoginModelService.getReturnMap(loginModel);
			model.addAttribute("modifiedLoginModel", loginModel);
		}
		else {
			map.put("result", "Employee update failure");
		}
		return map;		
	}
	
	@PostMapping(path="/findAuthorities", produces="application/json")
	public @ResponseBody List<String> findAuthorities(
			@ModelAttribute("modifiedLoginModel") LoginModel modifiedLoginModel
			){
		List<String> list = modifyLoginModelService.findAuthorities(modifiedLoginModel);
		return list;
	}
	
	@PostMapping(path="/findNewAuthorities", produces="application/json")
	public @ResponseBody List<String> findNewAuthorities(
			@ModelAttribute("modifiedLoginModel") LoginModel modifiedLoginModel
			){
		List<String> list = modifyLoginModelService.findNewAuthorities(modifiedLoginModel);
		return list;
	}
}
