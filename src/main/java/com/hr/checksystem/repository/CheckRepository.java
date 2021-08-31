package com.hr.checksystem.repository;

import java.util.List;

import com.hr.checksystem.model.Checksystem;
import com.hr.schedule.model.FactSchedule;

public interface CheckRepository {

	void saveChecksystem(Checksystem checksystem);

	List<Checksystem> findPartCheckSystem(String empNo,int days);

	List<Checksystem> findCheckSystemByEmp(String empNo);
	
	List<Checksystem> findAllCheckSystem();

	Checksystem findTodayCheckSystemByEmpno(String empNo);

	Checksystem findYesterdayCheckSystemByEmpno(String empNo);

	Checksystem getCheckSystemByTime(String dateString ,String empNo);

	public FactSchedule findWorkTimeByEmpNo(int empID , String date);
	
}