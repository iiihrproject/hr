package com.hr.schedule.model;

import java.sql.Time;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="dimShift")
public class DimShift {
	@Id
	@Column(name="KeyShift")
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Integer keyShift;
	@Column(name="DimShift")
	private String shift;
	@Column(name="StartTime")
	private Time startTime;
	@Column(name="EndTime")
	private Time endTime;
	@Column(name="Hours")
	private Float hours;
	@Column(name="Position")
	private String position;
	
	public DimShift() {
	}

	public DimShift(Integer keyShift, String shift, Time startTime, Time endTime, Float hours, String position) {
		super();
		this.keyShift = keyShift;
		this.shift = shift;
		this.startTime = startTime;
		this.endTime = endTime;
		this.hours = hours;
		this.position = position;
	}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("dimShift [keyShift=");
		builder.append(keyShift);
		builder.append(", shift=");
		builder.append(shift);
		builder.append(", startTime=");
		builder.append(startTime);
		builder.append(", endTime=");
		builder.append(endTime);
		builder.append(", hours=");
		builder.append(hours);
		builder.append(", position=");
		builder.append(position);
		builder.append("]");
		return builder.toString();
	}

	public Integer getKeyShift() {
		return keyShift;
	}

	public void setKeyShift(Integer keyShift) {
		this.keyShift = keyShift;
	}

	public String getShift() {
		return shift;
	}

	public void setShift(String shift) {
		this.shift = shift;
	}

	public Time getStartTime() {
		return startTime;
	}

	public void setStartTime(Time startTime) {
		this.startTime = startTime;
	}

	public Time getEndTime() {
		return endTime;
	}

	public void setEndTime(Time endTime) {
		this.endTime = endTime;
	}

	public Float getHours() {
		return hours;
	}

	public void setHours(Float hours) {
		this.hours = hours;
	}

	public String getPosition() {
		return position;
	}

	public void setPosition(String position) {
		this.position = position;
	}

	
}
