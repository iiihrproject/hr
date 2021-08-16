package com.hr.checksystem.repository.Impl;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.Query;
import javax.persistence.TypedQuery;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hr.checksystem.model.Checksystem;
import com.hr.checksystem.repository.CheckRepository;
import com.hr.login.model.DepartmentDetail;

@Repository
public class CheckRepositoryImpl implements CheckRepository {

	@Autowired
	EntityManager entityManager;

	@Override
	public void saveChecksystem(Checksystem checksystem) {
		entityManager.persist(checksystem);
	}

	@Override
	public List<Checksystem> findPartCheckSystem(String empNo, int days ) {
		String hql = "From Checksystem where DateDiff(dd,createTime,getdate())<= :days and empNo = :empNo "
				+ "and DateDiff(dd,createTime,getdate())>=0 "
				+ "order by createTime desc";
		TypedQuery<Checksystem> query = entityManager.createQuery(hql, Checksystem.class);
		query.setParameter("days", days);
		query.setParameter("empNo", empNo);
		

		return query.getResultList();
		
	}
	
	@Override //用上班時間查詢
	public Checksystem findTodayCheckSystemByEmpno(String empNo) {
		String hql = "From Checksystem where DateDiff(dd,createTime,getdate())= 0 " + "and empNo = :empNo";
		TypedQuery<Checksystem> query = entityManager.createQuery(hql, Checksystem.class);
		query.setParameter("empNo", empNo);
		
		if(query.getResultList().size()>0) {
			return query.getSingleResult();
		}
		return null;
		
	}
	
	@Override
	public Checksystem findYesterdayCheckSystemByEmpno(String empNo) {
		String hql = "From Checksystem where DateDiff(dd,createTime,getdate())= 1 " + "and empNo = :empNo";
		TypedQuery<Checksystem> query = entityManager.createQuery(hql, Checksystem.class);
		query.setParameter("empNo", empNo);
		
		if(query.getResultList().size()>0) {
			return query.getSingleResult();
		}
		return null;
	}

	@Override
	public List<Checksystem> findCheckSystemByEmp(String empNo) {
		String hql = "from Checksystem where empNo = :empNo order by createTime desc";
		TypedQuery<Checksystem> query = entityManager.createQuery(hql, Checksystem.class);

		query.setParameter("empNo", empNo);

		System.out.println("query.getResultList() = " + query.getResultList().size());
		
		return query.getResultList();
		
	}
	
	
	//<----------------------------------------管理員--------------------------------------------------->
	
	public List<Checksystem> findAllCheckSystem(){
		String hql = "From Checksystem ";
		TypedQuery<Checksystem> query = entityManager.createQuery(hql, Checksystem.class);
		
		return query.getResultList();
		
	}

}
