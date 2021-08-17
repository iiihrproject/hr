package com.hr.bulletin.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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
	@Override
	public List<Bulletin> findAll(){
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
	
	
	
	
}
