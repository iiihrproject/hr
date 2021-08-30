package com.hr.overtime.repository.Impl;

import java.math.BigDecimal;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.Query;
import javax.persistence.TypedQuery;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hr.overtime.model.OverTimeAuditted;
import com.hr.overtime.model.OverTimePending;
import com.hr.overtime.repository.OverTimeRepository;

@Repository
public class OverTimeRepositoryImpl implements OverTimeRepository {

	@Autowired
	EntityManager entityManager;
	//--------------------------------------員工---------------------------------------------//
	@Override
	public void savePending(OverTimePending overTimePending) {
		entityManager.persist(overTimePending);
	}
	
	@Override
	public List<OverTimePending> findPartByEmpnoPending(String empNo) {
		String hql = " Select Top 3 * From overtimeapplicationpending where empNo = :empNo order by id desc  ";
		Query query = entityManager.createNativeQuery(hql , OverTimePending.class);
		query.setParameter("empNo", empNo);
		List<OverTimePending> overtimePartPending = query.getResultList();
		return overtimePartPending;
	}
	
	@Override
	public List<OverTimeAuditted> findPartByEmpnoAuditted(String empNo) {
		String hql = " Select Top 3 * From overtimeapplicationauditted where empNo = :empNo  order by id desc ";
		Query query = entityManager.createNativeQuery(hql , OverTimeAuditted.class);
		query.setParameter("empNo", empNo);
		List<OverTimeAuditted> overtimePartAuditted = query.getResultList();
		return overtimePartAuditted;
	}

	@Override
	public List<OverTimePending> findByEmpnoPending(String empNo) {
		String hql = "from OverTimePending where empNo = :empNo";
		TypedQuery<OverTimePending> query = entityManager.createQuery(hql, OverTimePending.class);
		query.setParameter("empNo", empNo);

		List<OverTimePending> overtimepending = query.getResultList();

		return overtimepending;
	}

	@Override
	public List<OverTimeAuditted> findByEmpnoAuditted(String empNo) {
		String hql = "from OverTimeAuditted where empNo = :empNo";

		TypedQuery<OverTimeAuditted> query = entityManager.createQuery(hql, OverTimeAuditted.class);

		query.setParameter("empNo", empNo);

		List<OverTimeAuditted> overTimeList = query.getResultList();

		return overTimeList;
	}
	
	@Override
	public Double sumOverTimeHours(String empNo) {
		String hql = "SELECT SUM (convert(decimal,OverTimeHours)) FROM overtimeapplicationauditted where empNo= :empNo";
		
		Query query = entityManager.createNativeQuery(hql);
		query.setParameter("empNo", empNo);
		
		if(query.getResultList().size()>0) {
			
			BigDecimal val = (BigDecimal)query.getSingleResult();
			return val != null ? val.doubleValue() : 0;
		}
		return null;
	}
	//--------------------------------------管理員----------------------------------------------//
	@Override
	public List<OverTimePending> findByResult() {
		String hql = "from OverTimePending where result = 'pending' ";

		TypedQuery<OverTimePending> query = entityManager.createQuery(hql, OverTimePending.class);
		
		List<OverTimePending> overTimeList = query.getResultList();
		return overTimeList;
	}

	@Override
	public OverTimePending findById(Integer id) {
		String hql = "from OverTimePending where id = :id ";
		
		TypedQuery<OverTimePending> query = entityManager.createQuery(hql, OverTimePending.class);
		
		query.setParameter("id", id);
		
		 OverTimePending pendingById = query.getSingleResult();
		return pendingById;
	}

	@Override
	public void deletePending(OverTimePending overTimePending) {
		
		if(overTimePending !=null) {
			entityManager.remove(overTimePending);
		}

	}

	@Override
	public void saveAuditted(OverTimeAuditted overTimeAuditted) {
		
		if(overTimeAuditted != null) {
			entityManager.persist(overTimeAuditted);
		}
	}

	
}
