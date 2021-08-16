package com.hr.overtime.repository.Impl;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.Query;
import javax.persistence.TypedQuery;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hr.login.model.DepartmentDetail;
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
	
//	@Override
//	public DepartmentDetail queryManagerId(int dept_no) {
//		String hql = "select managerEmpId  from DepartmentDetail where dept_no = :dept_no ";
//		TypedQuery<DepartmentDetail> query = entityManager.createQuery(hql, DepartmentDetail.class);
//		
//		query.setParameter("dept_no", dept_no);
//		
//		return query.getSingleResult();
//	}
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

	@Override
	public List<OverTimePending> findPartByEmpnoPending(String empNo) {
		String hql = " Select Top 3 * From overtimeapplicationpending where empNo = :empNo   ";
		Query query = entityManager.createNativeQuery(hql , OverTimePending.class);
		query.setParameter("empNo", empNo);
		List<OverTimePending> overtimePart = query.getResultList();
		return overtimePart;
	}
}
