package com.hr.overtime.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.springframework.stereotype.Component;

import com.fasterxml.jackson.annotation.JsonFormat;

@Entity
@Table(name = "overtimeapplicationpending")
@Component("overtimeapplicationpending")
public class OverTimePending {

	@Id
	@Column(name = "ID")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;

	@Column(name = "TYPE")
	private String type;

	@Column(name = "DATEOFAPPLICATION")
	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd", timezone = "Asia/Taipei")
	@Temporal(TemporalType.TIMESTAMP)
	private Date dateOfApplication;

	@Column(name = "MANAGEREMPID")
	private Integer managerEmpId;

	@Column(name = "EMPNO")
	private String empNo;

	@Column(name = "EMPNAME")
	private String empName;

	@Column(name = "DEPARTMENT")
	private String department;

	@Column(name = "POSITION")
	private String position;

	@Column(name = "OVERTIMECATEGORY")
	private String overtimeCategory;

	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd", timezone = "Asia/Taipei")
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "OVERTIMEDATE")
	private Date overTimeDate;

	@Column(name = "STARTINGTIME")
	private String startingTime;

	@Column(name = "ENDINGTIME")
	private String endingTime;

	@Column(name = "OVERTIMEHOURS")
	private String overTimeHours;

	@Column(name = "REASON")
	private String reason;

	@Column(name = "REMARKS")
	private String remarks;

	@Column(name = "RESULT")
	private String result;

	public OverTimePending() {
		super();
	}

	public OverTimePending(Integer id, String type, Date dateOfApplication, String empNo, String empName,
			String department, String position, String overtimeCategory, Date overTimeDate, String startingTime,
			String endingTime, String overTimeHours, String reason, String remarks, String result) {
		super();
		this.id = id;
		this.type = type;
		this.dateOfApplication = dateOfApplication;
		this.empNo = empNo;
		this.empName = empName;
		this.department = department;
		this.position = position;
		this.overtimeCategory = overtimeCategory;
		this.overTimeDate = overTimeDate;
		this.startingTime = startingTime;
		this.endingTime = endingTime;
		this.overTimeHours = overTimeHours;
		this.reason = reason;
		this.remarks = remarks;
		this.result = result;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public Date getDateOfApplication() {
		return dateOfApplication;
	}

	public void setDateOfApplication(Date dateOfApplication) {
		this.dateOfApplication = dateOfApplication;
	}

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

	public String getDepartment() {
		return department;
	}

	public void setDepartment(String department) {
		this.department = department;
	}

	public String getPosition() {
		return position;
	}

	public void setPosition(String position) {
		this.position = position;
	}

	public String getOvertimeCategory() {
		return overtimeCategory;
	}

	public void setOvertimeCategory(String overtimeCategory) {
		this.overtimeCategory = overtimeCategory;
	}

	public Date getOverTimeDate() {
		return overTimeDate;
	}

	public void setOverTimeDate(Date overTimeDate) {
		this.overTimeDate = overTimeDate;
	}

	public String getStartingTime() {
		return startingTime;
	}

	public void setStartingTime(String startingTime) {
		this.startingTime = startingTime;
	}

	public String getEndingTime() {
		return endingTime;
	}

	public void setEndingTime(String endingTime) {
		this.endingTime = endingTime;
	}

	public String getOverTimeHours() {
		return overTimeHours;
	}

	public void setOverTimeHours(String overTimeHours) {
		this.overTimeHours = overTimeHours;
	}

	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public String getResult() {
		return result;
	}

	public void setResult(String result) {
		this.result = result;
	}

	public Integer getManagerEmpId() {
		return managerEmpId;
	}

	public void setManagerEmpId(Integer managerEmpId) {
		this.managerEmpId = managerEmpId;
	}

}
