package com.hr.personnel.repository;

import com.hr.login.model.LoginModel;
import com.hr.personnel.model.DepartmentDetail;

public interface AddNewPersonnelRepository {

	LoginModel getLoginModelByEmpNo(String empNo);

	DepartmentDetail findDepartment(Integer departmentNumber);

	boolean createNewPersonnel(LoginModel loginModel);

}
