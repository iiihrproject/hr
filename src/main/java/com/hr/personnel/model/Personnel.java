package com.hr.personnel.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.MapsId;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;
import org.springframework.stereotype.Component;

import com.hr.login.model.LoginModel;

@Entity(name = "personnel")
@Table(name = "personnel")
@Component("personnel")
public class Personnel {
	
	@GenericGenerator(name = "autoGenerator", strategy = "generator")
	@Id@Column(name = "emp_id")
	@GeneratedValue(generator = "generator")
	private Integer empId;
	
	@OneToOne
	@JoinColumn(name="emp_id")
	@MapsId
	private LoginModel loginModelInfo;

	private String phoneNumber;
	private String address;
	private String email;
	
	public Personnel() {
		super();
	}

	public Personnel(Integer empId, LoginModel loginModelInfo, String phoneNumber, String address, String email) {
		super();
		this.empId = empId;
		this.loginModelInfo = loginModelInfo;
		this.phoneNumber = phoneNumber;
		this.address = address;
		this.email = email;
	}

	public Integer getEmpId() {
		return empId;
	}

	public void setEmpId(Integer empId) {
		this.empId = empId;
	}

	public LoginModel getLoginModelInfo() {
		return loginModelInfo;
	}

	public void setLoginModelInfo(LoginModel loginModelInfo) {
		this.loginModelInfo = loginModelInfo;
	}

	public String getPhoneNumber() {
		return phoneNumber;
	}

	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

}
