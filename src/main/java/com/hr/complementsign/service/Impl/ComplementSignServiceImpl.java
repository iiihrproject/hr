package com.hr.complementsign.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hr.complementsign.model.AudittedComplementSign;
import com.hr.complementsign.model.PendingComplementSign;
import com.hr.complementsign.repository.ComplementSignRepository;
import com.hr.complementsign.service.ComplementSignService;

@Service
@Transactional
public class ComplementSignServiceImpl implements ComplementSignService {
	
	@Autowired
	ComplementSignRepository complementSignRepository;
	
	@Override
	public void saveComplementSign (PendingComplementSign pendingComplementSign) {
		
		complementSignRepository.saveComplementSign(pendingComplementSign);
	}
	
	@Override
	public List<PendingComplementSign>findPartComplementSign(String empNo){
		
		return complementSignRepository.findPartComplementSign(empNo);
	}
//----------------------------------------管理員-----------------------------------------------
	@Override
	public List<PendingComplementSign>findAllComplementSign(Integer mangaerNo){
		
		return complementSignRepository.findAllComplementSign(mangaerNo);
	}
	
	@Override
	public PendingComplementSign findById(int id) {
		return complementSignRepository.findById(id);
	}
	
	@Override
	public void saveAudittedComplementSign(PendingComplementSign pendingComplementSign ,String type) {
		AudittedComplementSign audittedComplementSign = new AudittedComplementSign();
		audittedComplementSign.setEmpNo(pendingComplementSign.getEmpNo());
		audittedComplementSign.setDate(pendingComplementSign.getDate());
//		audittedComplementSign.setTime(pendingComplementSign.getTime());
		audittedComplementSign.setType(pendingComplementSign.getType());
		audittedComplementSign.setManagerNo(pendingComplementSign.getManagerNo());
		audittedComplementSign.setAppliedDate(pendingComplementSign.getAppliedDate());
//		audittedComplementSign.setAppliedTime(pendingComplementSign.getAppliedTime());
		audittedComplementSign.setStatus(pendingComplementSign.getStatus());
		complementSignRepository.saveAudittedComplementSign(audittedComplementSign);
	}
	
	@Override
	public void deletePendingComplementSign(PendingComplementSign pendingComplementSign) {
		complementSignRepository.deletePendingComplementSign(pendingComplementSign);
	}
}
