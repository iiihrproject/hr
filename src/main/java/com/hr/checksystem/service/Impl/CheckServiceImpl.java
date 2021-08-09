package com.hr.checksystem.service.Impl;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hr.checksystem.model.Checksystem;
import com.hr.checksystem.repository.CheckRepository;
import com.hr.checksystem.service.CheckService;

@Service
@Transactional
public class CheckServiceImpl implements CheckService {

	@Autowired
	CheckRepository checkRepository;

	@Override
	public void saveChecksystem(Checksystem checksystem) {
		if(checksystem.getCheckInTime() != null && checksystem.getCheckOutTime() != null) {
			try {
				double workingMin = judgmentDate(checksystem.getCheckInTime(), checksystem.getCheckOutTime());
				double workinghours = workingMin / 60 ;
				checksystem.setWorkingHours(workinghours);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		if(checksystem.getId() == null) {
			checksystem.setCreateTime(new Date());
		}
		checksystem.setUpdateTime(new Date());
		
		checkRepository.saveChecksystem(checksystem);
	}
	
	@Override //查詢某員工當日上班資料
	public Checksystem findTodayCheckSystemByEmpno(String empNo) {
		 Checksystem checksystem = checkRepository.findTodayCheckSystemByEmpno(empNo);
		 
		return checksystem;
	}
	
	
	@Override // 查詢某員工昨日資料
	public Checksystem findYesterdayCheckSystemByEmpno(String empNo) {
		Checksystem checksystem = checkRepository.findYesterdayCheckSystemByEmpno(empNo);
		
		return checksystem;
	}

	@Override //查詢部分資料
	public List<Checksystem> findPartCheckSystem(String empNo, int days) {

		List<Checksystem> checksystem = checkRepository.findPartCheckSystem(empNo, days);

		return checksystem;
	}
	
	@Override //查詢某個員工全部資料
	public List<Checksystem> findCheckSystemByEmp(String empNo) {
		
		List<Checksystem> checksystem = checkRepository.findCheckSystemByEmp(empNo);
		
		return checksystem;
	}
	
	
	
	//計算上下班是否準時
	@Override
	public double judgmentDate(Date workTime,  Date currentTime) throws Exception {
		// String currentTime = DateUtil.getCurrentTime("yyyy-MM-dd HH:mm:ss");//當前時間

		long cha = currentTime.getTime() - workTime.getTime();

		double result = Math.floor(cha * 1.0 / (1000 * 60));
		return result;

	}

	public Date getTimeByType(String type) {
		
		String timeString = null;
		
		if("checkIn".equalsIgnoreCase(type)) {
			
			//撈上班時間
			timeString = "2021-08-06 09:00:00";
		}else {
			//撈下班時間
			timeString = "2021-08-06 17:00:00";
		}
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		try{
			return sdf.parse(timeString);
		}catch(Exception e) {
			
		}
		return null;
		
	}
	//測試打卡計算分鐘
	public static void main(String[] args) throws Exception {

		String workTime = "09:00:00";
		String hour = "09:00:02";

		SimpleDateFormat sdf = new SimpleDateFormat("HH:mm:ss");

		Date start = sdf.parse(workTime);// 業務時間

		Date end = sdf.parse(hour);// 當前時間

		long cha = end.getTime() - start.getTime();
		double result = Math.floor(cha * 1.0 / (1000 * 60));
		System.out.println(result);
	}
//<------------------------------------------------管理員------------------------------------------------------------>
	@Override
	public List<Checksystem> findAllCheckSystem() {
		
		List<Checksystem> checksystem = checkRepository.findAllCheckSystem();
		
		return checksystem;
	}

	

}
