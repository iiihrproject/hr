package com.hr.personnel.repository;

import com.hr.personnel.model.Personnel;

public interface PersonnelRepository {

	Personnel loadPersonalInfoByPk(Integer pk);

	void personalInformationUpdate(Personnel personnel);

}
