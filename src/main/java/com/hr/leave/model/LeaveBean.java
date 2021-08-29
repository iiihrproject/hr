package com.hr.leave.model;

import java.io.File;
import java.sql.Blob;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import org.springframework.stereotype.Component;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.hr.personnel.model.DepartmentDetail;

@Entity
@Table(name = "LeaveOfAbsense")
@Component("account")
public class LeaveBean {
	@Id
	@Column(name = "APPLICATIONNO")
	private String applicationNo;
	@Column(name = "TYPEOFFORM")
	private String typeOfForm;
//	@OneToOne(targetEntity = EmpBean.class, cascade = CascadeType.DETACH)
//	@JoinColumn(name = "empNo", referencedColumnName = "empNo")
//	private EmpBean emp;
	private String empNo;
	@OneToOne(targetEntity = DepartmentDetail.class, cascade = { CascadeType.DETACH })
	@JoinColumn(name = "deptNo", referencedColumnName = "dept_no")
	private DepartmentDetail dept;
	@Column(name = "REQUESTDATE")
	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd hh:mm:ss", timezone = "Asia/Taipei")
	private String requestDate;

	@OneToOne(targetEntity = ListBean.class, cascade = { CascadeType.DETACH })
	@JoinColumn(name = "reason_id", referencedColumnName = "code")
	private ListBean reasonList;

	@Column(name = "STARTDATE")
	private String startDate;
	@Column(name = "STARTTIME")
	private String startTime;
	@Column(name = "ENDDATE")
	private String endDate;
	@Column(name = "ENDTIME")
	private String endTime;
	@Column(name = "DAYS")
	private Float days;
	@Column(name = "COMMENTS")
	private String comments;
	@Column(name = "HANDOFF")
	private String handOff;
	@Column(name = "HANDOFFEMAIL")
	private String handOffEmail;
	@Column(name = "SUPPORTINGDOC")
	private File supportingDoc;
	
	@OneToOne(targetEntity = ListBean.class, cascade = { CascadeType.DETACH })
	@JoinColumn(name = "STATUS", referencedColumnName = "code")
	private ListBean statusList;
	@Column(name = "Approval01Name")
	private String approval01Name;
	@JsonIgnore
	@Column(name = "Approval01Signature")
	private Blob approval01Signature;
	@Column(name = "Approval01Date")
	private String approval01Date;

	public LeaveBean() {
	}

	public LeaveBean(String applicationNo, String typeOfForm, String empNo, DepartmentDetail dept, String requestDate,
			ListBean reasonList, String startDate, String startTime, String endDate, String endTime, Float days,
			String comments, String handOff, String handOffEmail, File supportingDoc, ListBean statusList,
			String approval01Name, Blob approval01Signature, String approval01Date) {
		super();
		this.applicationNo = applicationNo;
		this.typeOfForm = typeOfForm;
		this.empNo = empNo;
		this.dept = dept;
		this.requestDate = requestDate;
		this.reasonList = reasonList;
		this.startDate = startDate;
		this.startTime = startTime;
		this.endDate = endDate;
		this.endTime = endTime;
		this.days = days;
		this.comments = comments;
		this.handOff = handOff;
		this.handOffEmail = handOffEmail;
		this.supportingDoc = supportingDoc;
		this.statusList = statusList;
		this.approval01Name = approval01Name;
		this.approval01Signature = approval01Signature;
		this.approval01Date = approval01Date;
	}



	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("LeaveBean [applicationNo=");
		builder.append(applicationNo);
		builder.append(", typeOfForm=");
		builder.append(typeOfForm);
		builder.append(", empNo=");
		builder.append(empNo);
		builder.append(", dept=");
		builder.append(dept);
		builder.append(", requestDate=");
		builder.append(requestDate);
		builder.append(", reasonList=");
		builder.append(reasonList);
		builder.append(", startDate=");
		builder.append(startDate);
		builder.append(", startTime=");
		builder.append(startTime);
		builder.append(", endDate=");
		builder.append(endDate);
		builder.append(", endTime=");
		builder.append(endTime);
		builder.append(", days=");
		builder.append(days);
		builder.append(", comments=");
		builder.append(comments);
		builder.append(", handOff=");
		builder.append(handOff);
		builder.append(", handOffEmail=");
		builder.append(handOffEmail);
		builder.append(", supportingDoc=");
		builder.append(supportingDoc);
		builder.append(", status=");
		builder.append(statusList);
		builder.append(", approval01Name=");
		builder.append(approval01Name);
		builder.append(", approval01Signature=");
		builder.append(approval01Signature);
		builder.append(", approval01Date=");
		builder.append(approval01Date);
		builder.append("]");
		return builder.toString();
	}

	public String getApplicationNo() {
		return applicationNo;
	}

	public void setApplicationNo(String applicationNo) {
		this.applicationNo = applicationNo;
	}

	public String getTypeOfForm() {
		return typeOfForm;
	}

	public void setTypeOfForm(String typeOfForm) {
		this.typeOfForm = typeOfForm;
	}

	public String getEmpNo() {
		return empNo;
	}

	public void setEmpNo(String empNo) {
		this.empNo = empNo;
	}

	public String getRequestDate() {
		return requestDate;
	}

	public void setRequestDate(String requestDate) {
		this.requestDate = requestDate;
	}

	public ListBean getReasonList() {
		return reasonList;
	}

	public void setReasonList(ListBean reasonList) {
		this.reasonList = reasonList;
	}

	public String getStartDate() {
		return startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public String getStartTime() {
		return startTime;
	}

	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	public String getEndTime() {
		return endTime;
	}

	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}

	public Float getDays() {
		return days;
	}

	public void setDays(Float days) {
		this.days = days;
	}

	public String getComments() {
		return comments;
	}

	public void setComments(String comments) {
		this.comments = comments;
	}

	public String getHandOff() {
		return handOff;
	}

	public void setHandOff(String handOff) {
		this.handOff = handOff;
	}

	public String getHandOffEmail() {
		return handOffEmail;
	}

	public void setHandOffEmail(String handOffEmail) {
		this.handOffEmail = handOffEmail;
	}

	public File getSupportingDoc() {
		return supportingDoc;
	}

	public void setSupportingDoc(File supportingDoc) {
		this.supportingDoc = supportingDoc;
	}

	public ListBean getStatusList() {
		return statusList;
	}

	public void setStatusList(ListBean statusList) {
		this.statusList = statusList;
	}

	public DepartmentDetail getDept() {
		return dept;
	}

	public void setDept(DepartmentDetail dept) {
		this.dept = dept;
	}

	public String getApproval01Name() {
		return approval01Name;
	}

	public void setApproval01Name(String approval01Name) {
		this.approval01Name = approval01Name;
	}

	public Blob getApproval01Signature() {
		return approval01Signature;
	}

	public void setApproval01Signature(Blob approval01Signature) {
		this.approval01Signature = approval01Signature;
	}

	public String getApproval01Date() {
		return approval01Date;
	}

	public void setApproval01Date(String approval01Date) {
		this.approval01Date = approval01Date;
	}

}
