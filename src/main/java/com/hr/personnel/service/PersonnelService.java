package com.hr.personnel.service;

import com.hr.personnel.model.Personnel;

public interface PersonnelService {

	Personnel loadPersonalInfoByPk(Integer pk);

	boolean personalInformationUpdate(Personnel personnel);

	
	
}
