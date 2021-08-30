package com.hr.personnel.repository;

import com.hr.login.model.LoginModel;

public interface UpdatePasswordRepository {

	LoginModel updatePwd(LoginModel loginModel);

	LoginModel findNewLoginModel(Integer pk);
}
