package com.hr.schedule.repository.impl;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.NonUniqueResultException;

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
		String hql = "FROM FactSchedule ORDER by keySchedule desc";
		return entityManager.createQuery(hql, FactSchedule.class).getResultList();
	}

	@Override
	public List<EmpBean> findAllEmps() {
		String hql = "FROM EmpBean";
		return entityManager.createQuery(hql, EmpBean.class).getResultList();
	}

	@Override
	public int saveSchedule(FactSchedule schedule) {
		int n = 0;
		try {
			entityManager.persist(schedule);
			n = 1;
		} catch (Exception e) {
			n = -2;
			e.printStackTrace();
		}
		return n;
	}

	@Override
	public void deleteScheduleByKey(int keySchedule) {
		FactSchedule model = entityManager.find(FactSchedule.class, keySchedule);
		try {
			entityManager. remove(model);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return;
	}

	@Override
	public FactSchedule findSchedByPK(int keySchedule) {
		String hql = "From FactSchedule s WHERE s.keySchedule = :keySchedule";
		FactSchedule sched = null;
		try {
			sched = entityManager.createQuery(hql, FactSchedule.class).setParameter("keySchedule", keySchedule)
					.getSingleResult();
		} catch (NoResultException e) {
			e.printStackTrace();
		} catch (NonUniqueResultException e) {
			e.printStackTrace();
		}
		return sched;
	}

	@Override
	public void updateSchedule(FactSchedule schedule) {
		FactSchedule sched = findSchedByPK(schedule.getKeySchedule());
		sched.setKeySchedule(schedule.getKeySchedule() );
		sched.setEmps(schedule.getEmps());
		sched.setStart(schedule.getStart());
		sched.setEnd(schedule.getEnd());
		sched.setTitle(schedule.getTitle());
		entityManager.merge(sched);
	}

}
