package com.hr.personnel.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.hr.login.model.LoginModel;
import com.hr.personnel.service.PersonnelService;
import com.hr.personnel.service.UpdatePasswordService;

@Controller
@SessionAttributes("loginModel")
public class UpdatePasswordController {
	
	@Autowired
	UpdatePasswordService updatePasswordService;
	
	@GetMapping(path="/updatePassword")
	public String updatePassword() {
		return "/personnel/updatePassword";
	}
	
	@PutMapping(path="/updateNewPassword", produces="application/json")
	public @ResponseBody Map<String, String>updateNewPassword(
			@RequestParam("newPassword") String newPassword,
			@ModelAttribute("loginModel") LoginModel loginModel,
			Model model
			){
		boolean result = updatePasswordService.updateNewPassword(loginModel, newPassword);
		Map<String, String> map = new HashMap<String, String>();
		if(result) {
			map.put("result", "password update is successful");
			loginModel = updatePasswordService.findNewLoginModel(loginModel);
			if(loginModel == null) {
				map.put("result", "password update is failed");
			}
			else {
				model.addAttribute(loginModel);
				map.put("password", loginModel.getEmployeePassword().toString());
				map.put("result", "password update is successful");
			}
	    }
	    else {
	        map.put("result", "password update is failed");
	    }
	    return map;
	}
}
