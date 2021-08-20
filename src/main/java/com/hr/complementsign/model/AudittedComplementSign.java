package com.hr.complementsign.model;

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
@Table(name = "complementSignAuditted")
@Component("audittedComplementSignBean")
public class AudittedComplementSign {

	@Column(name = "empNo")
	private String empNo;

	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd HH:mm:ss", timezone = "Asia/Taipei")
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "date")
	private Date date;

//	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd HH:mm:ss", timezone = "Asia/Taipei")
//	@Temporal(TemporalType.TIMESTAMP)
//	@Column(name="time")
//	private Date time;

	@Column(name = "Type")
	private String Type;

	@Column(name = "empName")
	private String empName;

	@Column(name = "managerNo")
	private Integer managerNo;

	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd'T'HH:mm", timezone = "Asia/Taipei")
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "applied_Date")
	private Date appliedDate;

//	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd HH:mm:ss", timezone = "Asia/Taipei")
//	@Temporal(TemporalType.TIMESTAMP)
//	@Column(name = "applied Time")
//	private Date appliedTime;

	@Id
	@Column(name = "Serial_Number")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int serialNumber;

	@Column(name = "status")
	private String status;

	@Column(name = "reason")
	private String reason;

	public String getEmpName() {
		return empName;
	}

	public void setEmpName(String empName) {
		this.empName = empName;
	}

	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}

	public String getEmpNo() {
		return empNo;
	}

	public void setEmpNo(String empNo) {
		this.empNo = empNo;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

//	public Date getTime() {
//		return time;
//	}
//	public void setTime(Date time) {
//		this.time = time;
//	}
	public String getType() {
		return Type;
	}

	public void setType(String type) {
		Type = type;
	}

	public Integer getManagerNo() {
		return managerNo;
	}

	public void setManagerNo(Integer managerNo) {
		this.managerNo = managerNo;
	}

	public Date getAppliedDate() {
		return appliedDate;
	}

	public void setAppliedDate(Date appliedDate) {
		this.appliedDate = appliedDate;
	}

//	public Date getAppliedTime() {
//		return appliedTime;
//	}
//
//	public void setAppliedTime(Date appliedTime) {
//		this.appliedTime = appliedTime;
//	}

	public int getSerialNumber() {
		return serialNumber;
	}

	public void setSerialNumber(int serialNumber) {
		this.serialNumber = serialNumber;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
}
