package com.hr.personnel.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hr.login.model.LoginModel;
import com.hr.personnel.repository.ModifyLoginModelRepository;
import com.hr.personnel.service.ModifyLoginModelService;

@Service
public class ModifyLoginModelServiceImpl implements ModifyLoginModelService {

	@Autowired
	ModifyLoginModelRepository modifyLoginModelRepository;

	@Override
	public LoginModel loadByEmpNo(String inputEmpNo) {
		// TODO Auto-generated method stub
		return null;
	}
}
