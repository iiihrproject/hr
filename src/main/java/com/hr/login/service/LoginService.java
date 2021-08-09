package com.hr.login.service;

import com.hr.login.model.LoginModel;

public interface LoginService {

	LoginModel getLoginModelByEmpNo(String empNo);

	boolean checkLoginInfo(String empNo, String employeePassword, LoginModel loginModel);

}
