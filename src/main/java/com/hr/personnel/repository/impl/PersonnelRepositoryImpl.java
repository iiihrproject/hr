package com.hr.personnel.repository.impl;

import javax.persistence.EntityManager;
import javax.persistence.TransactionRequiredException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hr.personnel.model.Personnel;
import com.hr.personnel.repository.PersonnelRepository;

@Repository
public class PersonnelRepositoryImpl implements PersonnelRepository {
	
	@Autowired
	EntityManager entityManager;
	
	@Override
	public Personnel loadPersonalInfoByPk(Integer pk) {
		Personnel personnel = entityManager.find(Personnel.class, pk);
		return personnel;
	}

	@Override
	public Personnel personalInformationUpdate(Personnel personnel) throws TransactionRequiredException{
		try {
			return entityManager.merge(personnel);		
		}
		catch(Exception e) {
			return null;
		}
	}

}
