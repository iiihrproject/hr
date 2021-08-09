package com.hr.schedule.repository.impl;

import java.util.List;

import javax.persistence.EntityManager;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hr.schedule.model.DimShift;
import com.hr.schedule.repository.ShiftRepository;

@Repository
public class ShiftRepositoryImpl implements ShiftRepository {
	@Autowired
	EntityManager entityManager;

	@Override
	public List<DimShift> findAllShifts() {
		String hql= "FROM DimShift"; //this shift is class name
		List<DimShift> list = entityManager.createQuery(hql,DimShift.class).getResultList();
		return list;
	}

	@Override
	public int saveShift(DimShift shift) {
		int n = 0;
		try {
			entityManager.persist(shift);
			n = 1;
		}catch (Exception e) {
			n= -2;
		}
		return n;
	}

}
