package com.hr.schedule.repository;

import java.util.List;

import com.hr.schedule.model.EmpBean;
import com.hr.schedule.model.FactSchedule;

public interface ScheduleRepository {

	List<FactSchedule> findAllSchedule();
	
	List<FactSchedule> findScheduleByDeptNo(Integer deptNo);

	List<EmpBean> findAllEmps();
	
	int addScheduleMonthly(FactSchedule schedule);

	int saveSchedule(FactSchedule schedule);

	void deleteScheduleByKey(int keySchedule);

	FactSchedule findSchedByPK(int keySchedule);

	void updateSchedule(FactSchedule schedule);

}
