package com.hr.complementsign.repository.Impl;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.Query;
import javax.persistence.TypedQuery;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hr.complementsign.model.AudittedComplementSign;
import com.hr.complementsign.model.PendingComplementSign;
import com.hr.complementsign.repository.ComplementSignRepository;

@Repository
public class ComplementSignRepositoryImpl implements ComplementSignRepository {

	@Autowired
	EntityManager entityManager;
	
	@Override
	public void saveComplementSign( PendingComplementSign pendingComplementSign) {
		entityManager.persist(pendingComplementSign);
	}
	
	@Override
	public List<PendingComplementSign>findPendingComplementSign(String empNo){
		String hql = "From PendingComplementSign where empNo = :empNo order by Serial_Number desc";
		TypedQuery<PendingComplementSign> query = entityManager.createQuery(hql,PendingComplementSign.class);
		 query.setParameter("empNo", empNo);
		 return query.getResultList();
	}
	
	@Override
	public List<AudittedComplementSign>findAudittedComplementSign(String empNo){
		String hql = "From AudittedComplementSign where empNo = :empNo order by Serial_Number desc";
		TypedQuery<AudittedComplementSign> query = entityManager.createQuery(hql,AudittedComplementSign.class);
		query.setParameter("empNo", empNo);
		 return query.getResultList();
	}
	
	@Override
	public List<PendingComplementSign>findPartPendingComplementSign(String empNo){
		String hql = " Select Top 3 * From ComplementSignPendingApproval where empNo = :empNo order by Serial_Number desc";
		Query query = entityManager.createNativeQuery(hql , PendingComplementSign.class);
		query.setParameter("empNo", empNo);
		List<PendingComplementSign> pendingComplementSign = query.getResultList();
		return pendingComplementSign;
		
	}
	
	@Override
	public List<AudittedComplementSign>findPartAudittedComplementSign(String empNo){
		String hql = " Select Top 3 * From ComplementSignAuditted where empNo = :empNo order by Serial_Number desc";
		Query query = entityManager.createNativeQuery(hql , AudittedComplementSign.class);
		query.setParameter("empNo", empNo);
		List<AudittedComplementSign> audittedComplementSign = query.getResultList();
		return audittedComplementSign;
		
	}
	
	//------------------------------------------管理員------------------------------------------------//
	@Override //查屬於自己部門的所有資料
	public List<PendingComplementSign>findAllComplementSign(Integer managerNo){
		String hql = "from PendingComplementSign where managerNo =: managerNo";
		TypedQuery<PendingComplementSign> query = entityManager.createQuery(hql , PendingComplementSign.class);
		query.setParameter("managerNo", managerNo);
		return query.getResultList();
	}
	
	@Override
	public PendingComplementSign findById(int id) {
		String hql = "from PendingComplementSign where serialNumber =: serialNumber";
		TypedQuery<PendingComplementSign> query = entityManager.createQuery(hql, PendingComplementSign.class);
		query.setParameter("serialNumber", id);
		return query.getSingleResult();
	}
	
	
	@Override
	public void saveAudittedComplementSign(AudittedComplementSign audittedComplementSign) {
		
		if(audittedComplementSign != null) {
			entityManager.persist(audittedComplementSign);
		}
	}
	
	
	@Override
	public void deletePendingComplementSign(PendingComplementSign pendingComplementSign) {
		if(pendingComplementSign !=null) {
			entityManager.remove(pendingComplementSign);
		}
	}

	
	
}
