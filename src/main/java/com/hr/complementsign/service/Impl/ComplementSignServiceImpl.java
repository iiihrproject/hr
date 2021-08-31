package com.hr.complementsign.service.Impl;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hr.checksystem.model.Checksystem;
import com.hr.checksystem.repository.CheckRepository;
import com.hr.checksystem.service.CheckService;
import com.hr.complementsign.model.AudittedComplementSign;
import com.hr.complementsign.model.PendingComplementSign;
import com.hr.complementsign.repository.ComplementSignRepository;
import com.hr.complementsign.service.ComplementSignService;
import com.hr.login.model.LoginModel;
import com.hr.login.repository.LoginRepository;

@Service
@Transactional
public class ComplementSignServiceImpl implements ComplementSignService {
	
	@Autowired
	LoginRepository loginRepository;
	
	@Autowired
	ComplementSignRepository complementSignRepository;
	
	@Autowired
	CheckService checkService;
	
	@Override
	public void saveComplementSign (PendingComplementSign pendingComplementSign) {
		
		complementSignRepository.saveComplementSign(pendingComplementSign);
	}
	
	@Override
	public List<PendingComplementSign>findPartPendingComplementSign(String empNo){
		
		return complementSignRepository.findPartPendingComplementSign(empNo);
	}
	
	@Override
	public List<AudittedComplementSign>findPartAudittedComplementSign(String empNo){
		
		return complementSignRepository.findPartAudittedComplementSign(empNo);
	}
	
	@Override
	public List<PendingComplementSign>findPendingComplementSign(String empNo){
		return complementSignRepository.findPendingComplementSign(empNo);
	}
	
	@Override
	public List<AudittedComplementSign>findAudittedComplementSign(String empNo){
		return complementSignRepository.findAudittedComplementSign(empNo);
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
		audittedComplementSign.setEmpName(pendingComplementSign.getEmpName());
		audittedComplementSign.setEmpNo(pendingComplementSign.getEmpNo());
		audittedComplementSign.setDate(pendingComplementSign.getDate());
//		audittedComplementSign.setTime(pendingComplementSign.getTime());
		audittedComplementSign.setType(pendingComplementSign.getType());
		audittedComplementSign.setManagerNo(pendingComplementSign.getManagerNo());
		audittedComplementSign.setAppliedDate(pendingComplementSign.getAppliedDate());
//		audittedComplementSign.setAppliedTime(pendingComplementSign.getAppliedTime());
		audittedComplementSign.setReason(pendingComplementSign.getReason());
		audittedComplementSign.setStatus(type);
		complementSignRepository.saveAudittedComplementSign(audittedComplementSign);
	}
	
	@Override
	public void deletePendingComplementSign(PendingComplementSign pendingComplementSign) {
		complementSignRepository.deletePendingComplementSign(pendingComplementSign);
	}
	
	@Override
	public void updateCheckSystemTime(PendingComplementSign pendingComplementSign,String isApprove) throws Exception{
		
		
		//審核通過 才往下做
		if("Pass".equals(isApprove)) {
			
			String type = pendingComplementSign.getType();
			Date appliedDate = pendingComplementSign.getAppliedDate();
			String empNo = pendingComplementSign.getEmpNo();
			
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			String dateString = sdf.format(appliedDate);
			
			//新增方法
			Checksystem checksystem = checkService.getCheckSystemByTime(dateString,empNo);
			LoginModel loginModel = loginRepository.getLoginModelByEmpNo(empNo);
			
			int empID = loginModel.getPk();
			String depName = loginModel.getDepartmentDetail().getName();
			Date checkTime = checkService.getTimeByType(type,dateString,empID);
			
			double times = checkService.judgmentDate(checkTime, appliedDate);
			
			if(checksystem == null) {
				checksystem = new Checksystem();
				checksystem.setEmpNo(empNo);
				checksystem.setDepName(depName);
				System.out.println(" checkSystem == null");
				//判斷是否上班或下班遲到 早退
				boolean isNotOnTime = false;
				if("CheckIn".equals(type)) {
					isNotOnTime = times > 0;
				}else {
					isNotOnTime = times > 0;
				}
				String isLate = isNotOnTime ? "Y" : "N";
				
				if("CheckIn".equals(type)) {
					checksystem.setCheckInTime(appliedDate);
					checksystem.setIsLateCheckIn(isLate);
				}else if("CheckOut".equals(type)) {
					checksystem.setCheckOutTime(appliedDate);
					checksystem.setIsOnTimeCheckOut(isLate);
				}
				
			}else {
				System.out.println(" checkSystem != null");
				//判斷是否上班或下班遲到 早退
				boolean isNotOnTime = false;
				if("CheckIn".equals(type)) {
					isNotOnTime = times > 0;
				}else {
					isNotOnTime = times > 0;
				}
				String isLate = isNotOnTime ? "Y" : "N";
				
				if("CheckIn".equals(type)) {
					checksystem.setCheckInTime(appliedDate);
					checksystem.setIsLateCheckIn(isLate);
				}else if("CheckOut".equals(type)) {
					checksystem.setCheckOutTime(appliedDate);
					checksystem.setIsOnTimeCheckOut(isLate);
				}
			}
			
			checkService.saveChecksystem(checksystem);
			
		}
		
	}
}
