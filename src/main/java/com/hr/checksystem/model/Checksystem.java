package com.hr.checksystem.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

import org.springframework.stereotype.Component;

import com.fasterxml.jackson.annotation.JsonFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

@Entity
@Table(name = "checksystem")
@Component("checksystem")
public class Checksystem {
	@Id
	@Column(name = "ID")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;

	@Column(name = "DEPNAME")
	private String depName;

	@Column(name = "EMPNO")
	private String empNo;

	@Column(name = "CHECKINTIME")
	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd HH:mm:ss", timezone = "Asia/Taipei")
	@Temporal(TemporalType.TIMESTAMP)
	private Date checkInTime;

	@Column(name = "CHECKOUTTIME")
	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd HH:mm:ss", timezone = "Asia/Taipei")
	@Temporal(TemporalType.TIMESTAMP)
	private Date checkOutTime;

	@Column(name = "ISLATECHECKIN")
	private String isLateCheckIn;

	@Column(name = "ISONTIMECHECKOUT")
	private String isOnTimeCheckOut;

	@Column(name = "WORKINGHOURS")
	private Double workingHours;

	@Column(name = "UPDATETIME")
	@Temporal(TemporalType.TIMESTAMP)
	private Date updateTime;

	@Column(name = "CREATETIME")
	@Temporal(TemporalType.TIMESTAMP)
	private Date createTime;

	@Transient
	private String isNeedRepair = "N";
	
	@Transient
	private Date showTime = null;
//	private String checkInLate = null;
//	
//	private String checkOutOnTime = null;

	public String getIsNeedRepair() {
		return isNeedRepair;
	}

	public void setIsNeedRepair(String isNeedRepair) {
		this.isNeedRepair = isNeedRepair;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getEmpNo() {
		return empNo;
	}

	public void setEmpNo(String empNo) {
		this.empNo = empNo;
	}

	public String getDepName() {
		return depName;
	}

	public void setDepName(String depName) {
		this.depName = depName;
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

	public String getIsLateCheckIn() {
		return isLateCheckIn;
	}

	public void setIsLateCheckIn(String isLateCheckIn) {
		this.isLateCheckIn = isLateCheckIn;
	}

	public String getIsOnTimeCheckOut() {
		return isOnTimeCheckOut;
	}

	public void setIsOnTimeCheckOut(String isOnTimeCheckOut) {
		this.isOnTimeCheckOut = isOnTimeCheckOut;
	}

	public Double getWorkingHours() {
		return workingHours;
	}

	public void setWorkingHours(Double workingHours) {
		this.workingHours = workingHours;
	}

	public Date getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public void setShowTime() {
		if(checkInTime != null && checkOutTime != null) showTime = checkInTime;
		else if(checkInTime == null) showTime = checkOutTime;
		else showTime = checkInTime;
	}
	
	public Date getShowTime() {
		return showTime;
	}
	
//	public String getCheckInLate() {
//		if("Y".equals(this.isLateCheckIn)) return "是";
//		else return "否";
//	}
//	
//	public String getCheckOutOnTime() {
//		if("Y".equals(this.isOnTimeCheckOut)) return "是";
//		else return "否";
//	}

}
