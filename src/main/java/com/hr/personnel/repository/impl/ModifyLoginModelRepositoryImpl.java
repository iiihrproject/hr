package com.hr.personnel.repository.impl;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.NonUniqueResultException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hr.login.model.Authorities;
import com.hr.login.model.LoginModel;
import com.hr.personnel.model.DepartmentDetail;
import com.hr.personnel.repository.ModifyLoginModelRepository;

@Repository
public class ModifyLoginModelRepositoryImpl implements ModifyLoginModelRepository {
	
	@Autowired
	EntityManager entityManager;
	
	@Override
	public LoginModel loadByEmpNo(String inputEmpNo) {
		try {
			return (LoginModel)entityManager.createQuery("from loginModel where empNo = :empNo", LoginModel.class).setParameter("empNo", inputEmpNo).getSingleResult();	
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
	public LoginModel loadByPk(Integer pk) {
		try {
			return entityManager.find(LoginModel.class, pk);	
		}
		catch(Exception e) {
			return null;
		}
	}

	@Override
	public DepartmentDetail loadByDepartmentNumber(Integer departmentNumber) {
		try {	
			return entityManager.find(DepartmentDetail.class, departmentNumber);
		}
		catch(Exception e) {
			return null;
		}
	}

	@Override
	public LoginModel updateModifiedLoginModel(LoginModel modifiedLoginModel) {
		try {
			return entityManager.merge(modifiedLoginModel);
		}
		catch(Exception e) {
			return null;
		}
	}

	@Override
	public boolean insertAuthorities(Authorities authority) {
		try {
			entityManager.persist(authority);
		}
		catch(Exception e) {
			return false;
		}
		return true;
	}


	@Override
	public boolean deleteAuthorities(Authorities authorities) {
		Integer id = authorities.getId();
		try {
			entityManager.createQuery("delete from authorities where id = :id").setParameter("id", id).executeUpdate();
			return true;
		}
		catch(Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	@Override
	public List<Authorities> getAuthoritiesListByPk(Integer pk) {
		try {
			return entityManager.createQuery("from authorities where emp_id = :pk", Authorities.class).setParameter("pk", pk).getResultList();
		}
		catch(Exception e) {
			return null;
		}
	}
}
