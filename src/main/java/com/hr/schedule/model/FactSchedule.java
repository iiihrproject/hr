package com.hr.schedule.model;

import java.util.Date;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
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
	@OneToOne(targetEntity=EmpBean.class,cascade=CascadeType.DETACH)
	@JoinColumn(name="empNo", referencedColumnName="empNo")
	private EmpBean emps;
	@OneToOne(targetEntity=DimShift.class,cascade=CascadeType.DETACH)
	@JoinColumn(name="KeyShift", referencedColumnName = "KeyShift")
	private DimShift keyShift;
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

	public EmpBean getEmps() {
		return emps;
	}

	public void setEmps(EmpBean emps) {
		this.emps = emps;
	}
	
	public DimShift getKeyShift() {
		return keyShift;
	}
	
	public void setKeyShift(DimShift keyShift) {
		this.keyShift = keyShift;
	}

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
