package com.hr.schedule.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.OneToOne;
import javax.persistence.Table;

@Entity
@Table(name="DepartmentsDetail")
public class DeptTree {
	@Id
	@Column(name="DeptNo")
	private Integer deptNo;
	@Column(name="Department")
	private String department;
	
//	@OneToOne(mappedBy ="DeptTree")
//	private EmpBean empBean;
	
	public DeptTree() {
	}

}
