package com.hr.login.repository.impl;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.NonUniqueResultException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.hr.login.model.LoginModel;
import com.hr.login.repository.LoginRepository;

@Repository
public class LoginRepositoryImpl implements LoginRepository {
	
	@Autowired
	EntityManager entityManager;
	
	/**Find by empNo for the specific employee, no or two same account is is not allowed*/ 
	@Override
	public LoginModel getLoginModelByEmpNo(String empNo) {
		try {
			return entityManager.createQuery("from loginModel where empNo = :empNo", LoginModel.class).setParameter("empNo", empNo).getSingleResult();	
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
	public boolean checkLoginInfo(String empNo, String employeePassword, LoginModel loginModel) {
		
		if(loginModel.equals(null)) {
			return false;
		}
		
		if(!employeePassword.equals(loginModel.getEmployeePassword())){
			return false;
		}
		return true;
	}

}
