package com.hr.bulletin.service;

import java.util.List;

import javax.print.attribute.standard.Media;

import com.hr.bulletin.model.BulEnroll;
import com.hr.bulletin.model.BulLike;
import com.hr.bulletin.model.BulMessage;
import com.hr.bulletin.model.Bulletin;

public interface BulletinService {

	// 執行新增
	void insert(Bulletin bulletin);

	// 執行查詢單筆
	Bulletin findById(int postno);

	// 執行查詢多筆
	List<List> findAll();
	
	// 執行查詢多筆
//	List<Media> findAll();

	// 執行修改
	void update(Bulletin bulletin);

	
	//查詢未過期多筆
	List<Bulletin> findAllPosting();
	

	void updateop(Bulletin bulletin);

//	void delete(Bulletin bulletin);

	void delete(int postno);

	void insertMsg(BulMessage bulMassage);

	List<BulMessage> findAllMsg(int postno);

	void delMsg(int id);

	BulLike findLikeByno(String empNo, int postno);

	void changeLike(BulLike bulLike);

	BulEnroll findEnrollByno(String empNo, int postno);

	void insertEnroll(BulEnroll bulEnroll);

}