package com.hr.personnel.service.impl;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;

import javax.persistence.EntityManager;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hr.login.model.Authorities;
import com.hr.login.model.LoginModel;
import com.hr.personnel.model.DepartmentDetail;
import com.hr.personnel.model.Personnel;
import com.hr.personnel.repository.AddNewPersonnelRepository;
import com.hr.personnel.service.AddNewPersonnelService;

@Service
@Transactional
public class AddNewPersonnelServiceImpl implements AddNewPersonnelService{
	
	@Autowired
	AddNewPersonnelRepository addNewPersonnelRepository;
	
	@Autowired
	PasswordEncoder passwordEncoder;
	
	@Override
	public boolean createNewPersonnel(Map<String, String> inputMap) {
		LoginModel checkLoginModel = addNewPersonnelRepository.getLoginModelByEmpNo(inputMap.get("empNo"));
		if(checkLoginModel != null) {
			return false;
		}
		
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		String employedDate = sdf.format(date);
		
		String empNo = inputMap.get("empNo");
		CharSequence rawPassword = "password";
		String encryptedPassword = passwordEncoder.encode(rawPassword);
		
		DepartmentDetail departmentDetail = addNewPersonnelRepository.findDepartment(Integer.parseInt(inputMap.get("departmentDetail")));
		
		Set<Authorities> authorities = getInputAuthorities(inputMap);
		
		Personnel personnel = new Personnel();
		LoginModel loginModel = new LoginModel(
				null, 
				null, 
				inputMap.get("role"), 
				inputMap.get("personalIdNumber"), 
				inputMap.get("name"), 
				inputMap.get("gender"),
				empNo, 
				encryptedPassword, 
				departmentDetail, 
				null,
				employedDate, 
				true, 
				true,
				true, 
				employedDate, 
				true
				);
		personnel.setLoginModelInfo(loginModel);
		loginModel.setPersonnel(personnel);
		Iterator<Authorities> iterator = authorities.iterator();
		while(iterator.hasNext()) {
			Authorities authority = iterator.next();
			authority.setLoginModel(loginModel);
		}
		loginModel.setAuthorities(authorities);
		boolean flowCheck = addNewPersonnelRepository.createNewPersonnel(loginModel);
		return flowCheck;
	}

	private Set<Authorities> getInputAuthorities(Map<String, String> inputMap) {
		// Creating a set of keys of the inputMap
		Set<String> keySet = inputMap.keySet();
		Iterator<String> keySetIterator = keySet.iterator();
		Set<Authorities> result = new HashSet<Authorities>();
		while(keySetIterator.hasNext()) {
			String s = keySetIterator.next();
			// Only the true of authorities will be save to authorities
			if(inputMap.get(s).equals("true")) {
				Authorities authorities = new Authorities();
				authorities.setAuthorityName("ROLE_" + s.toUpperCase());
				result.add(authorities);
			}
		}
		return result;
	}

	@Override
	public LoginModel getLoginModelByEmpNo(String empNo) {
		LoginModel loginModel = addNewPersonnelRepository.getLoginModelByEmpNo(empNo);
		return loginModel;
	}
	
}
