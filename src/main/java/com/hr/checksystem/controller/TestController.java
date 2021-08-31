package com.hr.checksystem.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.hr.checksystem.model.Checksystem;
import com.hr.checksystem.service.CheckService;

@RestController
@RequestMapping("/testInsert")
public class TestController {

	@Autowired
	CheckService checkService;
	
	@GetMapping("/insertCheck")
	public String insertCheckSystemData() throws Exception{
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		
		String checkInString = "2021-07-15 09:00:00";
		String checkOutString = "2021-07-15 18:00:00";
		Date date = new Date();
		Date checkIn = sdf.parse(checkInString);
		Date checkOut = sdf.parse(checkOutString);
		
		for(int i = 0 ; i < 47 ; i++) {
			
			Checksystem checkSystem = new Checksystem();
			
			checkSystem.setEmpNo("hr1");
			checkSystem.setDepName("HR");
			checkSystem.setCheckInTime(checkIn);
			checkSystem.setCheckOutTime(checkOut);
			checkSystem.setIsLateCheckIn("Y");
			checkSystem.setIsOnTimeCheckOut("Y");
			checkSystem.setWorkingHours(checkService.judgmentDate(checkIn, checkOut) / 60);
			checkSystem.setUpdateTime(checkOut);
			checkSystem.setCreateTime(checkIn);
			
			Calendar calendar = Calendar.getInstance();
			calendar.setTime(checkIn);
			int week = calendar.get(Calendar.DAY_OF_WEEK) -1;
			
			//假日不打卡
			if(week != 0 && week != 6)checkService.saveChecksystem(checkSystem);
			
			calendar.add(Calendar.DATE, 1);
			
			checkIn = calendar.getTime();
			
			calendar.setTime(checkOut);
			calendar.add(Calendar.DATE, 1);
			checkOut = calendar.getTime();
			
		}
		
		
		return "success";
		
	}
	
}
