package com.hr.bulletin.repository;

import java.util.List;

import com.hr.bulletin.model.BulMessage;
import com.hr.bulletin.model.Bulletin;

public interface BulletinRepo {

	//執行新增
	void insert(Bulletin bulletin);

	//	執行查詢單筆
	Bulletin findById(int postno);

	//	執行查詢多筆
	List<Bulletin> findAll();

	//	執行修改
	void update(Bulletin bulletin);

	
	//	查詢未過期多筆
	List<Bulletin> findAllPosting();
	

	void updateop(Bulletin bulletin);

	void delete(int postno);

	void insertMsg(BulMessage bulMassage);

	List<BulMessage> findAllMsg(int postno);

}