package com.hr.personnel.repository;

import java.util.List;

import com.hr.login.model.Authorities;
import com.hr.login.model.LoginModel;
import com.hr.personnel.model.DepartmentDetail;

public interface ModifyLoginModelRepository {

	LoginModel loadByEmpNo(String inputEmpNo);

	LoginModel loadByPk(Integer pk);

	DepartmentDetail loadByDepartmentNumber(Integer departmentNumber);

	LoginModel updateModifiedLoginModel(LoginModel modifiedLoginModel);

	boolean insertAuthorities(Authorities authority);

	boolean deleteAuthorities(Authorities authorities);

	List<Authorities> getAuthoritiesListByPk(Integer pk);


}
