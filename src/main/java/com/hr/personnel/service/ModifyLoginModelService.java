package com.hr.personnel.service;

import java.util.List;
import java.util.Map;

import com.hr.login.model.LoginModel;

public interface ModifyLoginModelService {

	LoginModel loadByEmpNo(String inputEmpNo);

	LoginModel loadByPk(Integer pk);

	boolean updateLoginModel(Map<String, String> inputMap, LoginModel modifiedLoginModel);

	Map<String, String> getReturnMap(LoginModel loginModel);

	boolean updateAuthorities(Map<String, String> inputMap, LoginModel modifiedLoginModel);

	List<String> findAuthorities(LoginModel modifiedLoginModel);

	List<String> findNewAuthorities(LoginModel modifiedLoginModel);

}
