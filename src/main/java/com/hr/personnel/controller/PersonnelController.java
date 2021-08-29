package com.hr.personnel.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.hr.login.model.LoginModel;
import com.hr.personnel.model.Personnel;
import com.hr.personnel.service.PersonnelService;

@Controller
@SessionAttributes("loginModel")
public class PersonnelController {
	
	@Autowired
	PersonnelService personnelService;

	@GetMapping(path="/editPersonalInfo")
	public String editPersonalInfo() {
		return "/personnel/editPersonalInfo";
	}
	
	@GetMapping(path="/personnel")
	public String personnel() {
		return "/personnel/personnel";
	}
	
	@GetMapping(path="/personnelAuthorization", produces = { "application/json; charset=UTF-8" })
	public @ResponseBody Map<String, String> personnelAuthorization(
			@ModelAttribute("loginModel") LoginModel loginModel
			) {
		Boolean result = personnelService.personnelAuthorization(loginModel);
		Map<String, String> map = new HashMap<String, String>();
		map.put("result", result.toString());
		return map;
	}
	
	/**
	 * This map problem should be done in service
	 * I will later on to amend below 2 methods and delete this note if it's finished
	 * Please do not hesitate about amending if seeing this note
	 * @param loginModel
	 * @return
	 */
	@GetMapping(path="/personalInformation")
	public @ResponseBody Map<String, String> personalInformation(@ModelAttribute("loginModel") LoginModel loginModel) {
		Personnel personnel = personnelService.loadPersonalInfoByPk(loginModel.getPk());
		Map<String, String> map = new HashMap<String, String>();
		map.put("phoneNumber", personnel.getPhoneNumber());
		map.put("email", personnel.getEmail());
		map.put("address", personnel.getAddress());
		return map;
	}
	
	@PutMapping(path="/personalInformationUpdate", produces = { "application/json; charset=UTF-8" }, consumes = { "application/json; charset=UTF-8" })
	public @ResponseBody Map<String, String> personalInformationUpdate(
			@ModelAttribute("loginModel") LoginModel loginModel, 
			@RequestBody Personnel personnel) {
		personnel.setEmpId(loginModel.getPk());
		
		boolean updateResult = personnelService.personalInformationUpdate(personnel);
		
		Personnel updatedPersonnel = personnelService.loadPersonalInfoByPk(loginModel.getPk());
		Map<String, String> map = new HashMap<String, String>();
		map.put("phoneNumber", updatedPersonnel.getPhoneNumber());
		map.put("email", updatedPersonnel.getEmail());			
		map.put("address", updatedPersonnel.getAddress());
		
		if(!updateResult) {	
			map.put("result", "Update failed");
			return map;
		}
		
		map.put("result", "Update successfull");
		return map;
		
	}
	
}
