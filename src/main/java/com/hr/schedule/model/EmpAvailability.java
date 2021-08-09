package com.hr.schedule.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonFormat;

@Entity
@Table(name="dimEmpAvailability")
public class EmpAvailability {
	@Id
	@Column(name="AvailabilityId")
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Integer availabilityId;
	@Column(name="empno")
	private Integer empNo;
	@Column(name="DateAvailability")
	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd", timezone= "Asia/Taipei")
	private Date dateAvailability;
	@Column(name="StatusAvailability")
	private String statusAvailability;
	@Column(name="Notes")
	private String notes;
	@Column(name="CreatedTime")
	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd hh:mm", timezone= "Asia/Taipei")
	private Date createdTime;
	
	public EmpAvailability() {
	}

	public EmpAvailability(Integer empNo, Date dateAvailability, String statusAvailability) {
		super();
		this.empNo = empNo;
		this.dateAvailability = dateAvailability;
		this.statusAvailability = statusAvailability;
	}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("dimEmployeeAvailability [empNo=");
		builder.append(empNo);
		builder.append(", dateAvailability=");
		builder.append(dateAvailability);
		builder.append(", statusAvailability=");
		builder.append(statusAvailability);
		builder.append("]");
		return builder.toString();
	}

	public Integer getEmpNo() {
		return empNo;
	}

	public void setEmpNo(Integer empNo) {
		this.empNo = empNo;
	}

	public Date getDateAvailability() {
		return dateAvailability;
	}

	public void setDateAvailability(Date dateAvailability) {
		this.dateAvailability = dateAvailability;
	}

	public String getStatusAvailability() {
		return statusAvailability;
	}

	public void setStatusAvailability(String statusAvailability) {
		this.statusAvailability = statusAvailability;
	}

}
