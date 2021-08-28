package com.hr.personnel.service;

import java.util.Map;

import com.hr.login.model.LoginModel;

public interface AddNewPersonnelService {

	boolean createNewPersonnel(Map<String, String> inputMap);

	LoginModel getLoginModelByEmpNo(String empNo);

}
