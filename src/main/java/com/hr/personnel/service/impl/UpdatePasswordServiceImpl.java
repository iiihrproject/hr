package com.hr.personnel.service.impl;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.hr.login.model.LoginModel;
import com.hr.personnel.repository.UpdatePasswordRepository;
import com.hr.personnel.service.UpdatePasswordService;

@Service
@Transactional
public class UpdatePasswordServiceImpl implements UpdatePasswordService {

	@Autowired
	UpdatePasswordRepository updatePasswordRepository;
	
	@Autowired
	PasswordEncoder passwordEncoder;
	
	@Override
	public boolean updateNewPassword(LoginModel loginModel, String newPassword) {
		  CharSequence cs = newPassword.subSequence(0, newPassword.length());
		  String encryptedPwd = passwordEncoder.encode(cs);
		  loginModel.setEmployeePassword(encryptedPwd);
	      LoginModel updatedLoginModel = updatePasswordRepository.updatePwd(loginModel);
	      if(updatedLoginModel == null) {
	    	  return false;
	      }
	      return true;
	}

	@Override
	public LoginModel findNewLoginModel(LoginModel loginModel) {
		Integer pk = loginModel.getPk();
		return updatePasswordRepository.findNewLoginModel(pk);
	}

}
