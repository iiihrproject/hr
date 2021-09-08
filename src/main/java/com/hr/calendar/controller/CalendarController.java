package com.hr.calendar.controller;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.hr.calendar.model.CalendarTask;
import com.hr.calendar.service.CalendarService;
import com.hr.login.model.LoginModel;
import com.hr.schedule.model.FactSchedule;


@Controller
public class CalendarController {
	
	@Autowired
	CalendarService calendarService;
	
	private static Logger calLog = LoggerFactory.getLogger(CalendarController.class);
	
	//載入各人內容
	@GetMapping("/calendartasks")
	public @ResponseBody List<CalendarTask> showTasksByEmpNo(
			@SessionAttribute LoginModel loginModel			
			){
			String userEmpNo = loginModel.getEmpNo();
			calLog.info("載入 " + userEmpNo + " 的項目清單");	
			List<CalendarTask> userTasks = calendarService.showTasksByEmpNo(userEmpNo);
			return userTasks;			
	}
	
	//載入各人班表
	@GetMapping("/shiftsforcalendar")
	public @ResponseBody List<FactSchedule> showShiftByEmpNo(
			@SessionAttribute LoginModel loginModel			
			){
			String userEmpNo = loginModel.getEmpNo();
			calLog.info("載入 " + userEmpNo + " 的班表");	
			List<FactSchedule> userShifts = calendarService.showShiftByEmpNo(userEmpNo);
			return userShifts;			
	}
	

	
	//新增項目&//修改項目
	@PostMapping("/calendarTaskUpdate")
	public @ResponseBody CalendarTask updatCeTask(
			@SessionAttribute LoginModel loginModel,
			@RequestBody CalendarTask theTask
			) {
		String result = "";   //to-do

		if(theTask.getNo() == null) {			
			calLog.info("新增項目");
			CalendarTask newTask = new CalendarTask();
			try {
				newTask.setEmpNo(loginModel.getEmpNo());    //empNo:hidden
				newTask.setStartTime(theTask.getStartTime());
				newTask.setEndTime(theTask.getEndTime());
				newTask.setColorTag(theTask.getColorTag());
				newTask.setTaskTitle(theTask.getTaskTitle());
				newTask.setTaskText(theTask.getTaskText());
				newTask.setTaskStatus(false);    //Status:hidden
				calendarService.newTask(newTask);
				result = "新增成功";
				calLog.info(result);
				return newTask;
			}catch(Exception e) {
				result = "新增失敗";
				calLog.info(result + e.getMessage());
				throw e;
			}
			
		
		}else {
			calLog.info("修改項目");
			CalendarTask exTask = calendarService.findTheTask(theTask.getNo());

			try {
				exTask.setStartTime(theTask.getStartTime());
				exTask.setEndTime(theTask.getEndTime());
				exTask.setColorTag(theTask.getColorTag());
				exTask.setTaskTitle(theTask.getTaskTitle());
				exTask.setTaskText(theTask.getTaskText());
				calendarService.edit(exTask);
				result = "修改成功";
				calLog.info(result);
				return theTask;
			}catch(Exception e) {
				result = "修改失敗";
				calLog.info(result + e.getMessage());
				throw e;
			}		
		}
		
	}
	
	
	
	//刪除項目
	@PostMapping("/calendarTaskDelete")
	public @ResponseBody String delete(@RequestBody CalendarTask taskNo) {
		System.out.println("** " + taskNo.getNo());
		calLog.info("刪除選取項目");
		String result = "";
		try {
			calendarService.delete(taskNo.getNo());
			result = "刪除成功";
			calLog.info(result);
			return result;
		}catch(Exception e) {
			result = "刪除失敗";
			calLog.info(result + e.getMessage());
			throw e;
		}
	}
	
	
	
	

}
