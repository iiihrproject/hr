package com.hr.checksystem.service.Impl;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hr.checksystem.model.Checksystem;
import com.hr.checksystem.repository.CheckRepository;
import com.hr.checksystem.service.CheckService;
import com.hr.schedule.model.FactSchedule;

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

		filterIsNeedRepair(checksystem);
		
		return checksystem;
	}
	
	@Override //查詢某個員工全部資料
	public List<Checksystem> findCheckSystemByEmp(String empNo) {
		
		List<Checksystem> checksystem = checkRepository.findCheckSystemByEmp(empNo);
		
		filterIsNeedRepair(checksystem);
		
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
	
	//判斷是否補簽到
	public void filterIsNeedRepair(List<Checksystem> checkSystemList) {
		
		Date today = transferDate(new Date());
		
		for(Checksystem checksystem : checkSystemList) {
			
			checksystem.setShowTime();
			
			Date checkTime = transferDate(checksystem.getCreateTime());
			
			//判斷小於今天的資料作處理
			if(today.compareTo(checkTime) == 1) {
				
				if(checksystem.getCheckInTime() == null || checksystem.getCheckOutTime() == null || checksystem.getWorkingHours() < 9) {
					checksystem.setIsNeedRepair("Y");
				}
				
			}
			
		}
		
	}
	
	public Date transferDate(Date date) {
		
		//yyyy mm dd HH mm ss
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		try {
			//yyyy-MM-dd
			String dateString = sdf.format(date);
			//yyyy mm dd 00 00 00
			date = sdf.parse(dateString);
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return date;
		
	}
	
	public Date getTimeByType(String type,String date,int empID) {
		
		//用日期取得 排班資料
		FactSchedule factSchedule = getFactSchedule(date, empID);
		if(factSchedule != null) {
			
			String timeString = null;
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss");
			
			if("checkIn".equalsIgnoreCase(type)) {
				//撈上班時間
				timeString = factSchedule.getStart();
			}else {
				//撈下班時間
				timeString = factSchedule.getEnd();
			}
			
			try {
				return sdf.parse(timeString);
			} catch (ParseException e) {
				e.printStackTrace();
			}
			
		}
		
		return null;
		
	}
	//測試打卡計算分鐘
	public static void main(String[] args) throws Exception {

//		String workTime = "09:00:00";
//		String hour = "09:00:02";
//
//		SimpleDateFormat sdf = new SimpleDateFormat("HH:mm:ss");
//
//		Date start = sdf.parse(workTime);// 業務時間
//
//		Date end = sdf.parse(hour);// 當前時間
//
//		long cha = end.getTime() - start.getTime();
//		double result = Math.floor(cha * 1.0 / (1000 * 60));
//		System.out.println(result);
		
//		Date date = new Date();
//		
//		System.out.println("date = " + date);
//		
//		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
//		try {
//			String dateString = sdf.format(date);
//			date = sdf.parse(dateString);
//		}catch(Exception e) {
//			e.printStackTrace();
//		}
//		
//		System.out.println("after = " + date);
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss");
		
		String dateString = "2021-08-21T09:00:00";
		
		System.out.println(sdf.parse(dateString));
		
	}
//<------------------------------------------------管理員------------------------------------------------------------>
	@Override
	public List<Checksystem> findAllCheckSystem() {
		
		List<Checksystem> checksystem = checkRepository.findAllCheckSystem();
		
		return checksystem;
	}

	@Override
	public Checksystem getCheckSystemByTime(String dateString,String empNo) {
		return checkRepository.getCheckSystemByTime(dateString, empNo);
	}

	@Override //用日期取得 排班資料
	public FactSchedule getFactSchedule(String date, int empID) {
		return checkRepository.findWorkTimeByEmpNo(empID, date + "%");
	}

	

}
