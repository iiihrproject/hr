package com.hr.login.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import org.springframework.transaction.annotation.Transactional;

import com.hr.login.model.LoginModel;
import com.hr.login.repository.LoginRepository;
import com.hr.login.service.LoginService;

@Service
@Transactional
@EnableTransactionManagement
public class LoginServiceImpl implements LoginService {

	@Autowired
	LoginRepository loginRepository;

	@Override
	public LoginModel getLoginModelByEmpNo(String empNo) {
		return loginRepository.getLoginModelByEmpNo(empNo);
	}

	@Override
	public boolean checkLoginInfo(String empNo, String employeePassword, LoginModel loginModel) {
		return loginRepository.checkLoginInfo(empNo, employeePassword, loginModel);
	}
}
