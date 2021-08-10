package com.hr.bulletin.repository.Impl;


import java.sql.Timestamp;
import java.util.List;

import javax.persistence.EntityManager;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hr.bulletin.model.Bulletin;
import com.hr.bulletin.repository.BulletinRepo;

@Repository
public class BulletinRepoImpl implements BulletinRepo {

	@Autowired
	EntityManager entityManager;

	//執行新增
	@Override
	public void insert(Bulletin bulletin) {
		if(bulletin!=null)
		entityManager.persist(bulletin);

	}

//	執行查詢單筆
	@Override
	public Bulletin findById(int postno) {
		return entityManager.find(Bulletin.class, postno);
	}

//	查詢未刪除多筆
	@Override
	public List<Bulletin> findAll() {
		String hql = "FROM Bulletin b WHERE b.postStatus>=:del order by postno desc";
		return entityManager.createQuery(hql,Bulletin.class).setParameter("del","deleted").getResultList();
	}
	
	//查詢未過期多筆
	@Override
	public List<Bulletin> findAllPosting() {
		Timestamp ts = new Timestamp(System.currentTimeMillis());

		String hql = "FROM Bulletin b WHERE b.exp>=:ts AND b.postDate<=:ts order by postno desc ";
		return entityManager.createQuery(hql,Bulletin.class).setParameter("ts",ts).getResultList();
	}



//	執行修改
	@Override
	public void update(Bulletin bulletin) {
		Bulletin bul = findById(bulletin.getPostno()); 
		bulletin.setPostDate(bul.getPostDate());
		bulletin.setPostStatus(bul.getPostStatus());
		entityManager.detach(bul);
		entityManager.merge(bulletin);
	}
	

//	執行刪除
	@Override
	public void delete(int postno) {
		Bulletin bul = entityManager.find(Bulletin.class, postno);
		entityManager.remove(bul);
	}
	

}
