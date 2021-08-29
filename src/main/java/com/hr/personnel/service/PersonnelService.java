package com.hr.personnel.service;

import com.hr.login.model.LoginModel;
import com.hr.personnel.model.Personnel;

public interface PersonnelService {

	Personnel loadPersonalInfoByPk(Integer pk);

	boolean personalInformationUpdate(Personnel personnel);

	Boolean personnelAuthorization(LoginModel loginModel);

	
	
}
