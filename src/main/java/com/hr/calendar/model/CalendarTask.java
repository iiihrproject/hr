package com.hr.calendar.model;

import java.sql.Timestamp;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import org.springframework.stereotype.Component;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonProperty;

@Entity
@Table(name = "calendartask")
//@Component
public class CalendarTask {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer no;
	private String empNo;
//	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd HH:mm:ss", timezone = "Asia/Taipei")
	@JsonFormat(timezone = "Asia/Taipei")
	@JsonProperty("start")
	private Timestamp startTime;
//	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd HH:mm:ss", timezone = "Asia/Taipei")
	@JsonFormat(timezone = "Asia/Taipei")
	@JsonProperty("end")
	private Timestamp endTime;
	@JsonProperty("color")
	private String colorTag;
	@JsonProperty("title")
	private String taskTitle;
	@JsonProperty("description")
	private String taskText;
	private String createTime;
	private String editTime;
	private Boolean taskStatus;

	public CalendarTask() {

	}
	

	public CalendarTask(Integer no, String empNo, Timestamp startTime, Timestamp endTime, String colorTag,
			String taskTitle, String taskText, String createTime, String editTime, Boolean taskStatus) {
		super();
		this.no = no;
		this.empNo = empNo;
		this.startTime = startTime;
		this.endTime = endTime;
		this.colorTag = colorTag;
		this.taskTitle = taskTitle;
		this.taskText = taskText;
		this.createTime = createTime;
		this.editTime = editTime;
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

	public Timestamp getStartTime() {
		return startTime;
	}

	public void setStartTime(Timestamp startTime) {
		this.startTime = startTime;
	}

	public Timestamp getEndTime() {
		return endTime;
	}

	public void setEndTime(Timestamp endTime) {
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

	public String getCreateTime() {
		return createTime;
	}

	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

	public String getEditTime() {
		return editTime;
	}

	public void setEditTime(String editTime) {
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
		builder.append("CalendarTask [no=");
		builder.append(no);
		builder.append(", empNo=");
		builder.append(empNo);
		builder.append(", startTime=");
		builder.append(startTime);
		builder.append(", endTime=");
		builder.append(endTime);
		builder.append(", colorTag=");
		builder.append(colorTag);
		builder.append(", taskTitle=");
		builder.append(taskTitle);
		builder.append(", taskText=");
		builder.append(taskText);
		builder.append(", createTime=");
		builder.append(createTime);
		builder.append(", editTime=");
		builder.append(editTime);
		builder.append(", taskStatus=");
		builder.append(taskStatus);
		builder.append("]");
		return builder.toString();
	}	
	
	

}
