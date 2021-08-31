package com.hr.checksystem.repository.Impl;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.Query;
import javax.persistence.TypedQuery;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hr.checksystem.model.Checksystem;
import com.hr.checksystem.repository.CheckRepository;
import com.hr.complementsign.model.AudittedComplementSign;
import com.hr.schedule.model.FactSchedule;

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
		String hql = "From Checksystem where (DateDiff(dd,checkInTime,getdate()) <= :days or DateDiff(dd,checkOutTime,getdate()) <= :days) and empNo = :empNo "
				+ "order by case when checkInTime is null then checkOutTime else checkInTime end desc";
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
		String hql = "From Checksystem where (DateDiff(dd,checkInTime,getdate())= 1 or DateDiff(dd,checkOutTime,getdate())= 1) " + "and empNo = :empNo";
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
	
	//-----------------------------------------抓排班資料查詢該員工每日上班時間---------------------------------
	
	@Override
	public FactSchedule findWorkTimeByEmpNo(int empID , String date) {
		String hql = "from FactSchedule where empID = :empID and start like :date ";
		TypedQuery<FactSchedule> query = entityManager.createQuery(hql, FactSchedule.class);
		
		query.setParameter("empID", empID);
		query.setParameter("date", date);
		
		if( query.getResultList().size()>0) {
			return query.getSingleResult();
		}
		return null;
	}
	
	
	
	//<----------------------------------------管理員--------------------------------------------------->
	
	public List<Checksystem> findAllCheckSystem(){
		String hql = "From Checksystem ";
		TypedQuery<Checksystem> query = entityManager.createQuery(hql, Checksystem.class);
		
		return query.getResultList();
		
	}

	@Override
	public Checksystem getCheckSystemByTime(String dateString , String empNo) {
		String hql = "select * from checksystem \r\n"
				+ "  where (CONVERT(varchar(100), checkInTime, 23) = :dateString or CONVERT(varchar(100), checkOutTime, 23) = :dateString) and empNo = :empNo ";
		Query query = entityManager.createNativeQuery(hql,Checksystem.class);
		
		query.setParameter("empNo", empNo);
		query.setParameter("dateString", dateString);
		
		if(query.getResultList().size() != 0) {
			return (Checksystem)query.getSingleResult();
		}
		
		return null;
	}
}
