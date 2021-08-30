package com.hr.login.model;

import java.io.Serializable;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import org.springframework.stereotype.Component;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.hr.personnel.model.DepartmentDetail;
import com.hr.personnel.model.Personnel;

@Entity(name = "loginModel")
@Table(name = "loginModel")
@Component("loginModel")
public class LoginModel implements Serializable{
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name = "emp_id")
	private Integer pk;
	
	@JsonIgnore
	@OneToOne(mappedBy="loginModelInfo",fetch=FetchType.LAZY, cascade=CascadeType.ALL)
	private Personnel personnel;
	
	private String role;
	
	private String personalIdNumber;
	
	private String name;
	
	private String gender;
	
	private String empNo;
	
	@JsonIgnore
	@Column(name = "pwd")
	private String employeePassword;
	
	@ManyToOne
	@JoinColumn(name = "dept_No")
	private DepartmentDetail departmentDetail;
	
	@JsonIgnore
	@OneToMany(mappedBy="loginModel",fetch=FetchType.EAGER, cascade=CascadeType.ALL)
	private Set<Authorities> authorities;
	
	private String employedDate;
	
	@Column(name = "non_Expired")
	private Boolean isAccountNonExpired;
	@Column(name = "non_Locked")
	private Boolean isAccountNonLocked;
	@Column(name = "credentials_Non_Expired")
	private Boolean isCredentialsNonExpired;
	@Column(name = "last_Change")
	private String lastChangeCredentialsDate;
	@Column(name = "is_Enable")
	private Boolean isEnable;
	
	public LoginModel() {
		
	}
	
	public LoginModel(Integer pk, Personnel personnel, String role, String personalIdNumber, String name, String gender,
			String empNo, String employeePassword, DepartmentDetail departmentDetail, Set<Authorities> authorities,
			String employedDate, Boolean isAccountNonExpired, Boolean isAccountNonLocked,
			Boolean isCredentialsNonExpired, String lastChangeCredentialsDate, Boolean isEnable) {
		super();
		this.pk = pk;
		this.personnel = personnel;
		this.role = role;
		this.personalIdNumber = personalIdNumber;
		this.name = name;
		this.gender = gender;
		this.empNo = empNo;
		this.employeePassword = employeePassword;
		this.departmentDetail = departmentDetail;
		this.authorities = authorities;
		this.employedDate = employedDate;
		this.isAccountNonExpired = isAccountNonExpired;
		this.isAccountNonLocked = isAccountNonLocked;
		this.isCredentialsNonExpired = isCredentialsNonExpired;
		this.lastChangeCredentialsDate = lastChangeCredentialsDate;
		this.isEnable = isEnable;
	}



	public Integer getPk() {
		return pk;
	}


	public void setPk(Integer pk) {
		this.pk = pk;
	}


	public Personnel getPersonnel() {
		return personnel;
	}


	public void setPersonnel(Personnel personnel) {
		this.personnel = personnel;
	}


	public String getRole() {
		return role;
	}


	public void setRole(String role) {
		this.role = role;
	}


	public String getPersonalIdNumber() {
		return personalIdNumber;
	}


	public void setPersonalIdNumber(String personalIdNumber) {
		this.personalIdNumber = personalIdNumber;
	}


	public String getName() {
		return name;
	}


	public void setName(String name) {
		this.name = name;
	}


	public String getGender() {
		return gender;
	}


	public void setGender(String gender) {
		this.gender = gender;
	}


	public String getEmpNo() {
		return empNo;
	}


	public void setEmpNo(String empNo) {
		this.empNo = empNo;
	}


	public String getEmployeePassword() {
		return employeePassword;
	}


	public void setEmployeePassword(String employeePassword) {
		this.employeePassword = employeePassword;
	}


	public DepartmentDetail getDepartmentDetail() {
		return departmentDetail;
	}


	public void setDepartmentDetail(DepartmentDetail departmentDetail) {
		this.departmentDetail = departmentDetail;
	}


	public Set<Authorities> getAuthorities() {
		return authorities;
	}


	public void setAuthorities(Set<Authorities> authorities) {
		this.authorities = authorities;
	}


	public String getEmployedDate() {
		return employedDate;
	}


	public void setEmployedDate(String employedDate) {
		this.employedDate = employedDate;
	}


	public Boolean getIsAccountNonExpired() {
		return isAccountNonExpired;
	}


	public void setIsAccountNonExpired(Boolean isAccountNonExpired) {
		this.isAccountNonExpired = isAccountNonExpired;
	}


	public Boolean getIsAccountNonLocked() {
		return isAccountNonLocked;
	}


	public void setIsAccountNonLocked(Boolean isAccountNonLocked) {
		this.isAccountNonLocked = isAccountNonLocked;
	}


	public Boolean getIsCredentialsNonExpired() {
		return isCredentialsNonExpired;
	}


	public void setIsCredentialsNonExpired(Boolean isCredentialsNonExpired) {
		this.isCredentialsNonExpired = isCredentialsNonExpired;
	}


	public String getLastChangeCredentialsDate() {
		return lastChangeCredentialsDate;
	}


	public void setLastChangeCredentialsDate(String lastChangeCredentialsDate) {
		this.lastChangeCredentialsDate = lastChangeCredentialsDate;
	}


	public Boolean getIsEnable() {
		return isEnable;
	}


	public void setIsEnable(Boolean isEnable) {
		this.isEnable = isEnable;
	}


	public boolean equals(LoginModel loginModel) {
		if(
				this.getPk().equals(loginModel.getPk()) &&
				this.getPersonalIdNumber().equals(loginModel.getPersonalIdNumber()) &&
				this.getEmpNo().equals(loginModel.getEmpNo())
				) {
			return true;
		}
		return false;
	}
}