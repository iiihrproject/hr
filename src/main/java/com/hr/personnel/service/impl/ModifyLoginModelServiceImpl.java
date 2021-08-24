package com.hr.personnel.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hr.login.model.Authorities;
import com.hr.login.model.LoginModel;
import com.hr.personnel.model.DepartmentDetail;
import com.hr.personnel.repository.ModifyLoginModelRepository;
import com.hr.personnel.service.ModifyLoginModelService;

@Service
@Transactional
public class ModifyLoginModelServiceImpl implements ModifyLoginModelService {

	@Autowired
	ModifyLoginModelRepository modifyLoginModelRepository;

	@Override
	public LoginModel loadByEmpNo(String inputEmpNo) {
		return modifyLoginModelRepository.loadByEmpNo(inputEmpNo);
	}

	@Override
	public LoginModel loadByPk(Integer pk) {
		return modifyLoginModelRepository.loadByPk(pk);
	}


	@Override
	public boolean updateLoginModel(Map<String, String> inputMap, LoginModel modifiedLoginModel) {
		if(inputMap.get("role") != "") {
			modifiedLoginModel.setRole(inputMap.get("role"));
		}
		if(inputMap.get("name") != "") {
			modifiedLoginModel.setName(inputMap.get("name"));
		}
		if(inputMap.get("departmentDetail").toString() != "") {
			try {
				DepartmentDetail departmentStatus = modifyLoginModelRepository.loadByDepartmentNumber(Integer.parseInt(inputMap.get("departmentDetail").toString()));
				if(departmentStatus == null) {	
					return false;
				}
				modifiedLoginModel.setDepartmentDetail(departmentStatus);		
			}
			catch(Exception e) {
				return false;
			}
		}
		if(inputMap.get("isEnable").toString() != "") {
			modifiedLoginModel.setIsEnable(Boolean.parseBoolean(inputMap.get("IsEnable")));
		}
		
		LoginModel loginModel = modifyLoginModelRepository.updateModifiedLoginModel(modifiedLoginModel);
		if(modifiedLoginModel.equals(loginModel)) {
			return true;
		}		
		return false;
	}

	@Override
	public Map<String, String> getReturnMap(LoginModel loginModel) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("role", loginModel.getRole());
		map.put("name", loginModel.getName());
		map.put("departmentNumber", loginModel.getDepartmentDetail().getDepartmentNumber().toString());
		map.put("departmentName", loginModel.getDepartmentDetail().getName());
		map.put("isEnable", loginModel.getIsEnable().toString());
		return map;
	}

	@Override
	public List<String> findAuthorities(LoginModel modifiedLoginModel) {
		List<String> list = new ArrayList<String>();
		Set<Authorities> set = modifiedLoginModel.getAuthorities();
		Iterator<Authorities> iterator = set.iterator();
		while(iterator.hasNext()) {
			Authorities authority = iterator.next();
			list.add(authority.getAuthorityName().substring(5).toLowerCase());
		}
		return list;
	}
}
