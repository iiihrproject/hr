package com.hr.bulletin.model;

import java.sql.Blob;
import java.sql.Date;
import java.sql.Timestamp;
import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name = "bulletin")
public class Bulletin implements Serializable {
	
	private static final long serialVersionUID = 1L;

	private String type;

	private String title;

	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd", timezone="Asia/Taipei")
	private Date postDate;

	private String description;
	
	private String desText;
	
	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd", timezone="Asia/Taipei")
	private Date exp;
	
	@Id 
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int postno;

	private String postStatus;
	
	private Timestamp createTime;		// 建檔時間(紀錄寫入表格的時間)
	
	private String file1;
	
	private String quotatype;
	
	private Integer quota;
	
	// 加入修飾字防止Gson轉換此欄位
	@JsonIgnore
	private Blob picture;
	
	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd", timezone="Asia/Taipei")
	private Date endDate;
	

	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

	public void setQuota(Integer quota) {
		this.quota = quota;
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



	public Date getExp() {
		return exp;
	}

	public void setExp(Date exp) {
		this.exp = exp;
	}

	public int getPostno() {
		return postno;
	}

	public void setPostno(int postno) {
		this.postno = postno;
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

	public void setPostDate(Date postDate) {
		this.postDate = postDate;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
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

	public Integer getQuota() {
		return quota;
	}

	public void setQuota(int quota) {
		this.quota = quota;
	}

	public String getDesText() {
		return desText;
	}

	public void setDesText(String desText) {
		this.desText = desText;
	}
	
	public Blob getPicture() {
		return picture;
	}

	public void setPicture(Blob picture) {
		this.picture = picture;
	}

}
