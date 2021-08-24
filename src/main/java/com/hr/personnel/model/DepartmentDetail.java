package com.hr.personnel.model;

import java.util.Set;


import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.springframework.stereotype.Component;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.hr.login.model.LoginModel;

@Entity(name = "departmentDetail")
@Table(name = "departmentDetail")
@Component("departmentDetail")
public class DepartmentDetail {
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="dept_no")
	private Integer  departmentNumber;
	
	private String name;
	
	private Integer managerEmpId;
	
	@JsonIgnore
	@OneToMany(mappedBy="departmentDetail",fetch=FetchType.LAZY)
	private Set<LoginModel> loginModels;

	public Integer getDepartmentNumber() {
		return departmentNumber;
	}

	public void setDepartmentNumber(Integer departmentNumber) {
		this.departmentNumber = departmentNumber;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Integer getManagerEmpId() {
		return managerEmpId;
	}

	public void setManagerEmpId(Integer managerEmpId) {
		this.managerEmpId = managerEmpId;
	}

	public Set<LoginModel> getLoginModels() {
		return loginModels;
	}

	public void setLoginModels(Set<LoginModel> loginModels) {
		this.loginModels = loginModels;
	}

	public DepartmentDetail(Integer departmentNumber, String name, Integer managerEmpId, Set<LoginModel> loginModels) {
		super();
		this.departmentNumber = departmentNumber;
		this.name = name;
		this.managerEmpId = managerEmpId;
		this.loginModels = loginModels;
	}

	public DepartmentDetail() {
		super();
	}
	
	public boolean equals(DepartmentDetail departmentDetail) {
		if(
				this.getName().equals(departmentDetail.getName()) &&
				this.getManagerEmpId().equals(departmentDetail.getManagerEmpId())
				) {
			return true;
		}
		return false;
	}
}
