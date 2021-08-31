package com.hr.calendar.repository;

import java.util.List;
import java.util.Map;

import com.hr.calendar.model.CalendarTask;
import com.hr.schedule.model.FactSchedule;

public interface CalendarRepository {
	
	void newTask(CalendarTask task);
	
	void edit(CalendarTask task);

	void delete(Integer no);

	List<CalendarTask> showTasksByEmpNo(String empNo);
	
	CalendarTask findTheTask(Integer no);

	List<FactSchedule> showShiftByEmpNo(String empNo);
	
}
