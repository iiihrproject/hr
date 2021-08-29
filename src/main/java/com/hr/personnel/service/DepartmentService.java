package com.hr.personnel.service;

import java.util.Map;

import com.hr.login.model.LoginModel;
import com.hr.personnel.model.DepartmentDetail;

public interface DepartmentService {

	Map<Integer, Map<String, String>> findAllDepartmentDetail();

	Map<Integer, Map<String, String>> findAllDepartmentDetailWithReplacementOfNewManager(
			Map<String, String> inputMap);

	boolean insertNewDepartments(Map<Integer, Map<String, String>> inputMap);



}
