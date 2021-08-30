package com.hr.bulletin.model;

import java.sql.Blob;
import java.sql.Date;
import java.sql.Timestamp;

import com.fasterxml.jackson.annotation.JsonFormat;


public class BulName {
	
	private String type;

	private String title;

	private Date postDate;

	private String description;
	
	private String desText;
	
	private Date exp;

	private int postno;

	private String postStatus;
	
	private Timestamp createTime;
	
	private String file1;
	
	private String quotatype;
	
	private Integer quota;

	private Blob picture;

	private Date endDate;
	
	private int enrollId;
	
	private String enrollStatus;
	
	private Date enrollDate;
	
	private Timestamp updateTime;
	
	private long enCount;
	
	private String likeStatus;
	
	private String empName;
	
	private String depName;
	

	public String getLikeStatus() {
		return likeStatus;
	}

	public void setLikeStatus(String likeStatus) {
		this.likeStatus = likeStatus;
	}

	public long getLikeCount() {
		return likeCount;
	}

	public void setLikeCount(long likeCount) {
		this.likeCount = likeCount;
	}

	private long likeCount;
	
	
	public long getEnCount() {
		return enCount;
	}

	public void setEnCount(long enCount) {
		this.enCount = enCount;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public Date getPostDate() {
		return postDate;
	}

	public void setPostDate(java.util.Date object) {
		this.postDate = (Date) object;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getDesText() {
		return desText;
	}

	public void setDesText(String desText) {
		this.desText = desText;
	}

	public Date getExp() {
		return exp;
	}

	public void setExp(java.util.Date object) {
		this.exp = (Date) object;
	}

	public int getPostno() {
		return postno;
	}

	public void setPostno(int postno) {
		this.postno = postno;
	}

	public String getPostStatus() {
		return postStatus;
	}

	public void setPostStatus(String postStatus) {
		this.postStatus = postStatus;
	}

	public Timestamp getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Timestamp createTime) {
		this.createTime = createTime;
	}

	public String getFile1() {
		return file1;
	}

	public void setFile1(String file1) {
		this.file1 = file1;
	}

	public String getQuotatype() {
		return quotatype;
	}

	public void setQuotatype(String quotatype) {
		this.quotatype = quotatype;
	}

	public Integer getQuota() {
		return quota;
	}

	public void setQuota(Integer quota) {
		this.quota = quota;
	}

	public Blob getPicture() {
		return picture;
	}

	public void setPicture(Blob picture) {
		this.picture = picture;
	}

	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(java.util.Date object) {
		this.endDate = (Date) object;
	}

	public int getEnrollId() {
		return enrollId;
	}

	public void setEnrollId(int enrollId) {
		this.enrollId = enrollId;
	}

	public String getEnrollStatus() {
		return enrollStatus;
	}

	public void setEnrollStatus(String enrollStatus) {
		this.enrollStatus = enrollStatus;
	}

	public Date getEnrollDate() {
		return enrollDate;
	}

	public void setEnrollDate(Date enrollDate) {
		this.enrollDate = enrollDate;
	}

	public Timestamp getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(Timestamp updateTime) {
		this.updateTime = updateTime;
	}

	public String getEmpName() {
		return empName;
	}

	public void setEmpName(String empName) {
		this.empName = empName;
	}

	public String getDepName() {
		return depName;
	}

	public void setDepName(String depName) {
		this.depName = depName;
	}



	
}
