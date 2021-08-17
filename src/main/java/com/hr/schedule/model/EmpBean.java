package com.hr.schedule.model;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;

@Entity
@Table(name="Personnel_Info")
public class EmpBean {
	@Id
	@Column(name="empNo")
	private String empNo;
	
	@Column(name="Name")
	private String name;
	
	@OneToOne(cascade={CascadeType.DETACH})
	@JoinColumn(name="deptNo", referencedColumnName = "deptNo")
	private DeptTree department;
	
	public EmpBean() {
	}

	public EmpBean(String empNo, String name, DeptTree department) {
		super();
		this.empNo = empNo;
		this.name = name;
		this.department = department;
	}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("EmpBean [empNo=");
		builder.append(empNo);
		builder.append(", name=");
		builder.append(name);
		builder.append(", department=");
		builder.append(department);
		builder.append("]");
		return builder.toString();
	}

	public String getEmpNo() {
		return empNo;
	}

	public void setEmpNo(String empNo) {
		this.empNo = empNo;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public DeptTree getDepartment() {
		return department;
	}

	public void setDepartment(DeptTree department) {
		this.department = department;
	}

	
}
