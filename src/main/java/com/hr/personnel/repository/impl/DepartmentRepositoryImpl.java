package com.hr.personnel.repository.impl;

import java.util.List;


import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.NonUniqueResultException;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hr.login.model.LoginModel;
import com.hr.personnel.model.DepartmentDetail;
import com.hr.personnel.repository.DepartmentRepository;

@Repository
public class DepartmentRepositoryImpl implements DepartmentRepository {

	@Autowired
	EntityManager entityManager;

	@Override
	public List<DepartmentDetail> findAllDepartments() {
		
		CriteriaBuilder criteriaBuilder = entityManager.getCriteriaBuilder();
		CriteriaQuery<DepartmentDetail> criteriaQuery = criteriaBuilder.createQuery(DepartmentDetail.class);
		Root<DepartmentDetail> root = criteriaQuery.from(DepartmentDetail.class);
		CriteriaQuery<DepartmentDetail> allDepartmentDetail = criteriaQuery.select(root);
		
		List<DepartmentDetail> departmentDetailList = entityManager.createQuery(allDepartmentDetail).getResultList();
		
		return departmentDetailList;
	}

	@Override
	public LoginModel findLoginModel(Integer managerEmpId) {
		try {
			return entityManager.find(LoginModel.class, managerEmpId);	
		}
		catch(Exception e) {
			return null;
		}
	}

	@Override
	public DepartmentDetail updateDepartmentDetail(DepartmentDetail departmentDetail) {
		try {	
			return entityManager.merge(departmentDetail);		
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
	public void insertNewDepartments(DepartmentDetail departmentDetail) throws IllegalArgumentException {
		entityManager.persist(departmentDetail);			
	}
	
}
