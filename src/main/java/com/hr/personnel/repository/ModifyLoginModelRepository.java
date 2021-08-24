package com.hr.personnel.repository;

import com.hr.login.model.LoginModel;
import com.hr.personnel.model.DepartmentDetail;

public interface ModifyLoginModelRepository {

	LoginModel loadByEmpNo(String inputEmpNo);

	LoginModel loadByPk(Integer pk);

	DepartmentDetail loadByDepartmentNumber(Integer departmentNumber);

	LoginModel updateModifiedLoginModel(LoginModel modifiedLoginModel);

}
