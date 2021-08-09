package com.hr.login.repository;

import com.hr.login.model.LoginModel;

public interface LoginRepository {

	LoginModel getLoginModelByEmpNo(String empNo);
	
	boolean checkLoginInfo(String empNo, String employeePassword, LoginModel loginModel);

}
