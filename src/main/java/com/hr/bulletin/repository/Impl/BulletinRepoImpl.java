package com.hr.bulletin.repository.Impl;

import java.sql.Timestamp;
import java.util.List;

import javax.persistence.EntityManager;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hr.bulletin.model.BulMessage;
import com.hr.bulletin.model.Bulletin;
import com.hr.bulletin.repository.BulletinRepo;

@Repository
public class BulletinRepoImpl implements BulletinRepo {

	@Autowired
	EntityManager entityManager;

	// 執行新增
	@Override
	public void insert(Bulletin bulletin) {
		if (bulletin != null)
			entityManager.persist(bulletin);
	}
	
	// 執行新增
	@Override
	public void insertMsg(BulMessage bulMassage) {
		if (bulMassage != null)
			entityManager.persist(bulMassage);
	}

//	執行查詢單筆
	@Override
	public Bulletin findById(int postno) {
		return entityManager.find(Bulletin.class, postno);
	}

//	查詢未刪除多筆(管理)
	@Override
	public List<Bulletin> findAll() {
		String hql = "FROM Bulletin b WHERE b.postStatus>=:del order by postno desc";
		return entityManager.createQuery(hql, Bulletin.class).setParameter("del", "deleted").getResultList();
	}

	// 查詢未過期多筆
	@Override
	public List<Bulletin> findAllPosting() {
		Timestamp ts = new Timestamp(System.currentTimeMillis());

		String hql = "FROM Bulletin b WHERE b.exp>=:ts AND b.postDate<=:ts order by postDate desc ";
		return entityManager.createQuery(hql, Bulletin.class).setParameter("ts", ts).getResultList();
	}
	
//	查詢多筆留言
	@Override
	public List<BulMessage> findAllMsg(int postno) {
		String hql = "FROM BulMessage m WHERE m.postno=:no order by createTime";
		return entityManager.createQuery(hql, BulMessage.class).setParameter("no", postno).getResultList();
	}

	// 執行修改(原圖)
	@Override
	public void updateop(Bulletin bulletin) {
		Bulletin bul = findById(bulletin.getPostno());
		

		System.out.println("1updateFile1:" + bulletin.getFile1());
		System.out.println("2updateFile1:" + bul);

		bulletin.setType(bul.getType());
		bulletin.setPostStatus(bul.getPostStatus());
		bulletin.setFile1(bul.getFile1());
		bulletin.setPicture(bul.getPicture());
		bulletin.setCreateTime(bul.getCreateTime());

		entityManager.detach(bul);
		entityManager.merge(bulletin);
	}

//執行修改(改圖)
	@Override
	public void update(Bulletin bulletin) {
		Bulletin bul = findById(bulletin.getPostno());

		System.out.println("1updateFile1:" + bulletin.getFile1());
		System.out.println("2updateFile1:" + bul);

		bulletin.setType(bul.getType());
		bulletin.setPostStatus(bul.getPostStatus());
		bulletin.setCreateTime(bul.getCreateTime());

		System.out.println("----:"+bulletin.getFile1().equals("undefined"));
		if (bulletin.getFile1().equals("undefined")){
			System.out.println("----filename:"+bulletin.getFile1());
			bul.setFile1(null);
		}

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
