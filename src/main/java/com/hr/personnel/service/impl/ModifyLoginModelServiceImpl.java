package com.hr.personnel.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
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

		if(!inputMap.get("role").equals("")) {
			modifiedLoginModel.setRole(inputMap.get("role"));
		}
		if(!inputMap.get("name").equals("")) {
			modifiedLoginModel.setName(inputMap.get("name"));
		}
		if(!inputMap.get("departmentDetail").toString().equals("")) {
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
		if(!inputMap.get("isEnable").equals("")) {
			modifiedLoginModel.setIsEnable(Boolean.parseBoolean(inputMap.get("isEnable")));
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

	@Override
	public boolean updateAuthorities(Map<String, String> inputMap, LoginModel modifiedLoginModel) {
		// Getting the authorities of this loginModel and use iterator to run through each of it
		Set<Authorities> authoritiesSet = modifiedLoginModel.getAuthorities();
		// So creating a string set of authority name
		// And using a map to take the authority as value and authority name as key
		Set<String> authoritiesStringSet = new HashSet<String>();
		Map<String, Authorities> authorityMap = new HashMap<String, Authorities>();
		// Starting run through each one
		Iterator<Authorities> authoritiesIterator = authoritiesSet.iterator();
		while(authoritiesIterator.hasNext()) {
			Authorities eachAuthorities = authoritiesIterator.next();
			String authorities = eachAuthorities.getAuthorityName().substring(5).toLowerCase();
			// The authorities is "admin", "hr", and ect. for authoritiesStringSet and keys of authorityMap
			authoritiesStringSet.add(authorities);
			authorityMap.put(authorities, eachAuthorities);
		}
		// Using iterator to get only authorities value by checking true or false
		Map<String, Boolean> authoritiesBooleanMap = new HashMap<String, Boolean>();
		inputMap.remove("isEnable");
		Set<String> inputMapValue = inputMap.keySet();
		Iterator<String> inputMapValueIterator = inputMapValue.iterator();
		while(inputMapValueIterator.hasNext()) {
			String key = inputMapValueIterator.next();
			String autoritiesValue = inputMap.get(key);
			if(autoritiesValue.equals("true") || autoritiesValue.equals("false")) {
				// So this map only contains the authorities string
				authoritiesBooleanMap.put(key, Boolean.valueOf(autoritiesValue));
			}
		}
		// Getting the authoritiesMap now and is able to running this map for checking boolean of each authority
		// The keys are "admin", "hr", and ect..
		Set<String> inputAutoritiesValue = authoritiesBooleanMap.keySet();
		Iterator<String> inputAutoritiesValueIterator = inputAutoritiesValue.iterator();
		while(inputAutoritiesValueIterator.hasNext()) {
			String key = inputAutoritiesValueIterator.next();
			if(authoritiesBooleanMap.get(key)) {
				if(!(authoritiesStringSet.contains(key))) {
					// if input authorities is true but nothing in the database, then the inserting is needed 
					Authorities authority = new Authorities();
					authority.setLoginModel(modifiedLoginModel);
					String authorityName = "ROLE_" + key.toUpperCase();
					authority.setAuthorityName(authorityName);
					boolean flowCheck1 = modifyLoginModelRepository.insertAuthorities(authority);
					if(!flowCheck1) {
						return false;
					}
				}
			}
			else {
				if(authoritiesStringSet.contains(key)) {
					// if input authorities is false but there is that authorities in the set of modifiedModel, then the deleting is needed
					// So using the map created at the beginning when authoritiesStringSet is created
					boolean flowCheck2 = modifyLoginModelRepository.deleteAuthorities(authorityMap.get(key));
					if(!flowCheck2) {
						return false;
					}
				}				
			}
		}
		return true;
	}

	@Override
	public List<String> findNewAuthorities(LoginModel modifiedLoginModel) {
		List<Authorities> list = modifyLoginModelRepository.getAuthoritiesListByPk(modifiedLoginModel.getPk());
		List<String> result = new ArrayList<String>();
		for(int i = 0; i < list.size(); i++) {
			result.add(list.get(i).getAuthorityName().substring(5).toLowerCase());
		}
		return result;
	}
}
