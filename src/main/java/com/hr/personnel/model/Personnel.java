package com.hr.personnel.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
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
	private int empId;
	
	@OneToOne(fetch = FetchType.LAZY)
	@JoinColumn(name="emp_id")
	private LoginModel loginModelInfo;
	
	private String name;	
	private String phoneNumber;
	private String address;
	private String email;

}
