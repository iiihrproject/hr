package com.hr.checksystem.service;

import java.util.Date;
import java.util.List;

import com.hr.checksystem.model.Checksystem;

public interface CheckService {

	void saveChecksystem(Checksystem checksystem);

	List<Checksystem> findPartCheckSystem(String empNo, int days);

	double judgmentDate(Date workTime, Date currentTime) throws Exception;

	Date getTimeByType(String type);

	List<Checksystem> findCheckSystemByEmp(String empNo);

	List<Checksystem> findAllCheckSystem();

	Checksystem findTodayCheckSystemByEmpno(String empNo);

	Checksystem findYesterdayCheckSystemByEmpno(String empNo);

	Checksystem getCheckSystemByTime(String dateString);
}
