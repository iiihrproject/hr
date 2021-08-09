package com.hr.schedule.repository.impl;

import java.util.List;

import javax.persistence.EntityManager;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hr.schedule.model.EmpBean;
import com.hr.schedule.model.FactSchedule;
import com.hr.schedule.repository.ScheduleRepository;

@Repository
public class ScheduleRepositoryImpl implements ScheduleRepository {

	@Autowired
	EntityManager entityManager;

	@Override
	public List<FactSchedule> findAllSchedule() {
		String hql = "FROM FactSchedule";
		return entityManager.createQuery(hql,FactSchedule.class).getResultList();
	}

	@Override
	public List<EmpBean> findAllEmps() {
		String hql = "FROM EmpBean";
		return entityManager.createQuery(hql,EmpBean.class).getResultList();
	}

	@Override
	public int saveSchedule(FactSchedule schedule) {
		int n = 0;
		try {
			entityManager.persist(schedule);
			n = 1;
		}catch (Exception e) {
			n= -2;
		}
		return n;
	}

}
