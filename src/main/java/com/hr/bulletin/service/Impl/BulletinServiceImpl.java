package com.hr.bulletin.service.Impl;

import java.util.List;

import javax.print.attribute.standard.Media;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hr.bulletin.model.BulEnroll;
import com.hr.bulletin.model.BulLike;
import com.hr.bulletin.model.BulMessage;
import com.hr.bulletin.model.Bulletin;
import com.hr.bulletin.repository.BulletinRepo;
import com.hr.bulletin.service.BulletinService;

@Service
@Transactional
public class BulletinServiceImpl implements BulletinService {

	@Autowired
	BulletinRepo bulletinRepo;

	// 執行新增
	@Override
	public void insert(Bulletin bulletin) {
		bulletinRepo.insert(bulletin);
	}
	
	// 執行新增
	@Override
	public void insertMsg(BulMessage bulMassage) {
		bulletinRepo.insertMsg(bulMassage);
	}

	// 執行查詢單筆
	@Override
	public Bulletin findById(int postno) {
		return bulletinRepo.findById(postno);
	}

	// 執行查詢多筆
//	@Override
//	public List<Bulletin> findAll(){
//		return bulletinRepo.findAll();
//	}
	
	// 執行查詢多筆
	@Override
	public List<List> findAll(){
		return bulletinRepo.findAll();
	}

	// 執行修改
	@Override
	public void update(Bulletin bulletin) {
		bulletinRepo.update(bulletin);
	}
	
	@Override
	public void delete(int postno) {
		bulletinRepo.delete(postno);
	}
	
	//查詢未過期多筆
	@Override
	public List<Bulletin> findAllPosting() {
		return bulletinRepo.findAllPosting();
	}
	
	
	// 執行修改
	@Override
	public void updateop(Bulletin bulletin) {
		bulletinRepo.updateop(bulletin);
	}
	
	@Override
	public List<BulMessage> findAllMsg(int postno){
		return bulletinRepo.findAllMsg(postno);
	}
	
	@Override
	public void delMsg(int id) {
		bulletinRepo.delMsg(id);
	}
	
	@Override
	public BulLike findLikeByno(String empNo, int postno) {
		return bulletinRepo.findLikeByno(empNo, postno);
	}
	
	@Override
	public void changeLike(BulLike bulLike) {
		bulletinRepo.changeLike(bulLike);
	}

	@Override
	public BulEnroll findEnrollByno(String empNo, int postno) {
		return bulletinRepo.findEnrollByno(empNo, postno);
	}

	@Override
	public void insertEnroll(BulEnroll bulEnroll) {
		bulletinRepo.insertEnroll(bulEnroll);
		
	};
	
	
	
}
