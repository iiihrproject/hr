package com.hr.calendar.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.hr.calendar.model.CalendarTask;
import com.hr.calendar.service.CalendarService;
import com.hr.login.model.LoginModel;


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
			System.out.println("*** " + userTasks);
			return userTasks;			
	}

	
	//新增項目&//修改項目
	@PostMapping("calendarTaskUpdate")
	public @ResponseBody CalendarTask updateTask(
			@SessionAttribute LoginModel loginModel,
			@RequestParam("task") CalendarTask theTask
			) {
		String result = "";   //to-do
		if(theTask.getNo() == null) {			
			calLog.info("新增項目");
			CalendarTask newTask = new CalendarTask();
			try {
				newTask.setEmpNo(loginModel.getEmpNo());
				newTask.setTaskStatus(false);
				calendarService.newTask(newTask);
				result = "新增成功";
			}catch(Exception e) {
				result = "新增失敗";
				calLog.info(e.getMessage());
			}
			return newTask;
		
		}else {
			calLog.info("修改項目");
			CalendarTask exTask = calendarService.findTheTask(theTask.getNo());
			try {
				exTask.setStartTime(theTask.getStartTime());
				exTask.setEndTime(theTask.getEndTime());
				exTask.setColorTag(theTask.getColorTag());
				exTask.setTaskTitle(theTask.getTaskTitle());
				exTask.setTaskText(theTask.getTaskText());
				calendarService.edit(theTask);
				result = "修改成功";
			}catch(Exception e) {
				result = "修改失敗";
				calLog.info(e.getMessage());
			}		
		}
		return theTask;
	}
	
	
	
	//刪除項目
	@GetMapping("/calendarTaskDelete")
	public @ResponseBody String delete(@RequestParam("taskNo") Integer no) {
		calLog.info("刪除選取項目");
		String result = "";
		try {
			calendarService.delete(no);
			result = "刪除成功";
		}catch(Exception e) {
			result = "刪除失敗";
		}
		return result;
	}
	
	
	
	

}
