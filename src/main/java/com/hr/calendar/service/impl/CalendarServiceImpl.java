package com.hr.calendar.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hr.calendar.model.CalendarTask;
import com.hr.calendar.repository.CalendarRepository;
import com.hr.calendar.service.CalendarService;
import com.hr.schedule.model.FactSchedule;

@Service
@Transactional
public class CalendarServiceImpl implements CalendarService {
	
	@Autowired
	CalendarRepository calendarRepository;

	@Override
	public void newTask(CalendarTask task) {
		if(task != null) {
			calendarRepository.newTask(task);
		}			
	}

	@Override
	public void edit(CalendarTask task) {
		calendarRepository.edit(task);

	}

	@Override
	public void delete(Integer no) {
		calendarRepository.delete(no);

	}

	@Override
	public List<CalendarTask> showTasksByEmpNo(String empNo) {
		return calendarRepository.showTasksByEmpNo(empNo);
	}

	@Override
	public CalendarTask findTheTask(Integer no) {
		return calendarRepository.findTheTask(no);
	}

	@Override
	public List<FactSchedule> showShiftByEmpNo(String empNo) {
		return calendarRepository.showShiftByEmpNo(empNo);
	}

}
