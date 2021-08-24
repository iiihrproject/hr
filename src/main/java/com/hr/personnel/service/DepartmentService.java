package com.hr.personnel.service;

import java.util.Map;

import com.hr.login.model.LoginModel;
import com.hr.personnel.model.DepartmentDetail;

public interface DepartmentService {

	Map<Integer, Map<String, String>> findAllDepartmentDetail();

	Map<Integer, Map<String, String>> findAllDepartmentDetailWithReplacementOfNewManager(
			DepartmentDetail departmentDetail);

	boolean insertNewDepartments(Map<Integer, DepartmentDetail> departments);



}
