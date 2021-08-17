package com.hr.checksystem.bean;

import java.util.Date;

public class CheckSystemUnify {

	private String empNo;//員工編號
	
	private String empName; // 員工姓名
	
	private Date checkInTime; //上班時間
	
	private Date checkOutTime; //下班時間
	
	//是否遲到 需要嗎?
//	private Boolean isLate; 
	
	private double workingHours; // 上班時數

	public String getEmpNo() {
		return empNo;
	}

	public void setEmpNo(String empNo) {
		this.empNo = empNo;
	}

	public String getEmpName() {
		return empName;
	}

	public void setEmpName(String empName) {
		this.empName = empName;
	}

	public Date getCheckInTime() {
		return checkInTime;
	}

	public void setCheckInTime(Date checkInTime) {
		this.checkInTime = checkInTime;
	}

	public Date getCheckOutTime() {
		return checkOutTime;
	}

	public void setCheckOutTime(Date checkOutTime) {
		this.checkOutTime = checkOutTime;
	}

	public double getWorkingHours() {
		return workingHours;
	}

	public void setWorkingHours(double workingHours) {
		this.workingHours = workingHours;
	}
	
}
