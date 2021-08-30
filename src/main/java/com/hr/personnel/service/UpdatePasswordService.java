package com.hr.personnel.service;

import com.hr.login.model.LoginModel;

public interface UpdatePasswordService {

	boolean updateNewPassword(LoginModel loginModel, String newPassword);

	LoginModel findNewLoginModel(LoginModel loginModel);

}
