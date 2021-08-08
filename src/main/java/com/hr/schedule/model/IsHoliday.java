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
@Table(name="IsHoliday")
public class IsHoliday {
	@Id
	@Column(name="KeyDate")
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Integer keyDate;
	@Column(name="FullDate")
	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd", timezone= "Asia/Taipei")
	private Date fullDate;
	@Column(name="IsHoliday")
	private Boolean isHoliday;
	
	public IsHoliday() {
	}

	public IsHoliday(Integer keyDate, Date fullDate, Boolean isHoliday) {
		super();
		this.keyDate = keyDate;
		this.fullDate = fullDate;
		this.isHoliday = isHoliday;
	}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("dimDate [keyDate=");
		builder.append(keyDate);
		builder.append(", fullDate=");
		builder.append(fullDate);
		builder.append(", isHoliday=");
		builder.append(isHoliday);
		builder.append("]");
		return builder.toString();
	}

	public Integer getKeyDate() {
		return keyDate;
	}

	public void setKeyDate(Integer keyDate) {
		this.keyDate = keyDate;
	}

	public Date getFullDate() {
		return fullDate;
	}

	public void setFullDate(Date fullDate) {
		this.fullDate = fullDate;
	}

	public Boolean getIsHoliday() {
		return isHoliday;
	}

	public void setIsHoliday(Boolean isHoliday) {
		this.isHoliday = isHoliday;
	}

	
}//end of class
