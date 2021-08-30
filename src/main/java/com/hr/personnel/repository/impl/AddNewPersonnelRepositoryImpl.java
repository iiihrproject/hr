package com.hr.personnel.repository.impl;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.NonUniqueResultException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hr.login.model.LoginModel;
import com.hr.personnel.model.DepartmentDetail;
import com.hr.personnel.repository.AddNewPersonnelRepository;

@Repository
public class AddNewPersonnelRepositoryImpl implements AddNewPersonnelRepository {

	@Autowired
	EntityManager entityManager;
	
	@Override
	public LoginModel getLoginModelByEmpNo(String empNo) {
		try {
			return (LoginModel)entityManager.createQuery("from loginModel where empNo = :empNo", LoginModel.class).setParameter("empNo", empNo).getSingleResult();	
		}
		catch(NoResultException nre) {
			return null;
		}
		catch(NonUniqueResultException nure) {
			return null;
		}
		catch(Exception e) {
			return null;
		}
	}

	@Override
	public DepartmentDetail findDepartment(Integer departmentNumber) {
		try {	
			return entityManager.find(DepartmentDetail.class, departmentNumber);
		}
		catch(Exception e) {
			return null;
		}
	}

	@Override
	public boolean createNewPersonnel(LoginModel loginModel) {
		try {
			entityManager.persist(loginModel);
			return true;
		}
		catch(Exception e) {
			e.printStackTrace();
			return false;
		}
	}

}
