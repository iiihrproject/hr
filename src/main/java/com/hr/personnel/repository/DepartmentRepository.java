package com.hr.personnel.repository;

import java.util.List;

import com.hr.login.model.LoginModel;
import com.hr.personnel.model.DepartmentDetail;

public interface DepartmentRepository {

	List<DepartmentDetail> findAllDepartments();

	LoginModel findLoginModelByEmpNo(String managerEmpNo);

	DepartmentDetail updateDepartmentDetail(DepartmentDetail departmentDetail);

	DepartmentDetail findDepartment(Integer departmentNumber);

	boolean insertNewDepartments(DepartmentDetail departmentDetail) throws IllegalArgumentException;

	LoginModel findLoginModel(Integer managerEmpId);


}
