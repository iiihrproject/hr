package com.hr.personnel.repository.impl;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.NonUniqueResultException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hr.login.model.LoginModel;
import com.hr.personnel.repository.UpdatePasswordRepository;

@Repository
public class updatePasswordRepositoryImpl implements UpdatePasswordRepository {
	
	@Autowired
	EntityManager entityManager;
	
	@Override
	public LoginModel updatePwd(LoginModel loginModel) {
		try {
			return entityManager.merge(loginModel);
		}
		catch(Exception e) {
			return null;
		}
	}

	@Override
	public LoginModel findNewLoginModel(Integer pk) {
		try {
			return entityManager.find(LoginModel.class, pk);	
		}
		catch(Exception e) {
			return null;
		}
	}
}
