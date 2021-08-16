package com.hr.checksystem.repository;

import java.util.List;

import com.hr.checksystem.model.Checksystem;
import com.hr.login.model.DepartmentDetail;

public interface CheckRepository {

	void saveChecksystem(Checksystem checksystem);

	List<Checksystem> findPartCheckSystem(String empNo,int days);

	List<Checksystem> findCheckSystemByEmp(String empNo);
	
	List<Checksystem> findAllCheckSystem();

	Checksystem findTodayCheckSystemByEmpno(String empNo);

	Checksystem findYesterdayCheckSystemByEmpno(String empNo);



}