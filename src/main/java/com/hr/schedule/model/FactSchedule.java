package com.hr.schedule.model;

import java.util.Date;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonFormat;

@Entity
@Table(name="factSchedule")
public class FactSchedule {
	@Id
	@Column(name="KeySchedule")
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Integer keySchedule;
	@Column(name="Date")
	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd", timezone= "Asia/Taipei")
	private Date workDate;
	@Column(name="empno")
	private String empNo;
//	@OneToMany(targetEntity=DimShift.class,cascade=CascadeType.ALL)
//	private Integer keyShift;
	@Column(name="KeyAvailability")
	private Integer keyAvailability;
	@Column(name="HoursOfWork")
	private Double hoursOfWork;
	@Column(name="Start")
	private String start;
	@Column(name="EndOfShift")
	private String end;
	@Column(name="Title")
	private String title;
	
	public FactSchedule() {
	}

	



	public Integer getKeySchedule() {
		return keySchedule;
	}

	public void setKeySchedule(Integer keySchedule) {
		this.keySchedule = keySchedule;
	}

	public Date getWorkDate() {
		return workDate;
	}

	public void setWorkDate(Date workDate) {
		this.workDate = workDate;
	}

	public String getEmpNo() {
		return empNo;
	}

	public void setEmpNo(String empNo) {
		this.empNo = empNo;
	}

//	public Integer getKeyShift() {
//		return keyShift;
//	}
//
//	public void setKeyShift(Integer keyShift) {
//		this.keyShift = keyShift;
//	}

	public Integer getKeyAvailability() {
		return keyAvailability;
	}

	public void setKeyAvailability(Integer keyAvailability) {
		this.keyAvailability = keyAvailability;
	}

	public Double getHoursOfWork() {
		return hoursOfWork;
	}

	public void setHoursOfWork(Double hoursOfWork) {
		this.hoursOfWork = hoursOfWork;
	}



	public String getStart() {
		return start;
	}

	public void setStart(String start) {
		this.start = start;
	}

	public String getEnd() {
		return end;
	}

	public void setEnd(String end) {
		this.end = end;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}
	
}
