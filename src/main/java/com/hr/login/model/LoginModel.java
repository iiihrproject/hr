package com.hr.login.model;

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

@Entity
@Table(name = "loginModel")
@Component("loginModel")
public class LoginModel {
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name = "emp_id")
	private Integer pk;
	private String role;
	private String empNo;
	
	@JsonIgnore
	@Column(name = "pwd")
	private String employeePassword;
	@Column(name = "dept_No")
	private Integer departmentNumber;
	
	@JsonIgnore
	@OneToMany(mappedBy="loginModel",fetch=FetchType.EAGER)
	private Set<Authorities> authorities;
	
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

	public LoginModel(Integer pk, String role, String empNo, String employeePassword, Integer departmentNumber,
			Set<Authorities> authorities, Boolean isAccountNonExpired, Boolean isAccountNonLocked,
			Boolean isCredentialsNonExpired, String lastChangeCredentialsDate, Boolean isEnable) {
		super();
		this.pk = pk;
		this.role = role;
		this.empNo = empNo;
		this.employeePassword = employeePassword;
		this.departmentNumber = departmentNumber;
		this.authorities = authorities;
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

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
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

	public Integer getDepartmentNumber() {
		return departmentNumber;
	}

	public void setDepartmentNumber(Integer departmentNumber) {
		this.departmentNumber = departmentNumber;
	}

	public Set<Authorities> getAuthorities() {
		return authorities;
	}

	public void setAuthorities(Set<Authorities> authorities) {
		this.authorities = authorities;
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

	public boolean isEmpty() {
		if(
				this.getPk().equals(null)
				) {
			return true;
		}
		else {
			return false;
		}
	}
}