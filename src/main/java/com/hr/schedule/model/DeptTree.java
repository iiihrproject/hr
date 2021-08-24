package com.hr.schedule.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="DepartmentsDetail")
public class DeptTree {
	@Id
	@Column(name="DeptNo")
	private Integer deptNo;
	@Column(name="Department")
	private String department;

	public DeptTree() {
	}

	public Integer getDeptNo() {
		return deptNo;
	}

	public void setDeptNo(Integer deptNo) {
		this.deptNo = deptNo;
	}

	public String getDepartment() {
		return department;
	}

	public void setDepartment(String department) {
		this.department = department;
	}

}
