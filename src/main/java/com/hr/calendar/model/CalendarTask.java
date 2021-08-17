package com.hr.calendar.model;

import java.sql.Date;
import java.sql.Timestamp;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonFormat;

@Entity
@Table(name = "calendartask")
public class CalendarTask {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer no;
	private String empNo;
	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd HH-mm", timezone = "Asia/Taipei")
	private Date startTime;
	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd HH-mm", timezone = "Asia/Taipei")
	private Date endTime;
	private String colorTag;
	private String taskTitle;
	private String taskText;
	private Timestamp createTime;
	private Timestamp editTime;
	private Boolean taskStatus;

	public CalendarTask() {

	}

	public CalendarTask(Date startTime, Date endTime, String colorTag, String taskTitle, String taskText,
			Boolean taskStatus) {
		super();
		this.startTime = startTime;
		this.endTime = endTime;
		this.colorTag = colorTag;
		this.taskTitle = taskTitle;
		this.taskText = taskText;
		this.taskStatus = taskStatus;
	}

	public Integer getNo() {
		return no;
	}

	public void setNo(Integer no) {
		this.no = no;
	}

	public String getEmpNo() {
		return empNo;
	}

	public void setEmpNo(String empNo) {
		this.empNo = empNo;
	}

	public Date getStartTime() {
		return startTime;
	}

	public void setStartTime(Date startTime) {
		this.startTime = startTime;
	}

	public Date getEndTime() {
		return endTime;
	}

	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}

	public String getColorTag() {
		return colorTag;
	}

	public void setColorTag(String colorTag) {
		this.colorTag = colorTag;
	}

	public String getTaskTitle() {
		return taskTitle;
	}

	public void setTaskTitle(String taskTitle) {
		this.taskTitle = taskTitle;
	}

	public String getTaskText() {
		return taskText;
	}

	public void setTaskText(String taskText) {
		this.taskText = taskText;
	}

	public Timestamp getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Timestamp createTime) {
		this.createTime = createTime;
	}

	public Timestamp getEditTime() {
		return editTime;
	}

	public void setEditTime(Timestamp editTime) {
		this.editTime = editTime;
	}

	public Boolean getTaskStatus() {
		return taskStatus;
	}

	public void setTaskStatus(Boolean taskStatus) {
		this.taskStatus = taskStatus;
	}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("CalendarTask [startTime=");
		builder.append(startTime);
		builder.append(", endTime=");
		builder.append(endTime);
		builder.append(", colorTag=");
		builder.append(colorTag);
		builder.append(", taskTitle=");
		builder.append(taskTitle);
		builder.append(", taskText=");
		builder.append(taskText);
		builder.append(", taskStatus=");
		builder.append(taskStatus);
		builder.append("]");
		return builder.toString();
	}	
	

}
