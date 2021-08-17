package com.hr.calendar.service.impl;

import java.sql.Date;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hr.calendar.model.CalendarTask;
import com.hr.calendar.repository.CalendarRepository;
import com.hr.calendar.service.CalendarService;

@Service
@Transactional
public class CalendarServiceImpl implements CalendarService {
	
	CalendarRepository calendarRepository;

	@Override
	public void newTask(CalendarTask task) {
		//待修改
		calendarRepository.newTask(task);
		
	}

	@Override
	public void edit(CalendarTask task) {
		calendarRepository.edit(task);

	}

	@Override
	public void delete(CalendarTask task) {
		calendarRepository.delete(task);

	}

	@Override
	public List<CalendarTask> showTasksByEmpNo(String empNo) {
		return calendarRepository.showTasksByEmpNo(empNo);
	}

	@Override
	public CalendarTask findTheTask(Date startTime, String taskTitle) {
		return calendarRepository.findTheTask(startTime, taskTitle);
	}

}
