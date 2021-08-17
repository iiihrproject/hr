package com.hr.schedule.repository;

import java.util.List;

import com.hr.schedule.model.EmpBean;
import com.hr.schedule.model.FactSchedule;

public interface ScheduleRepository {

	List<FactSchedule> findAllSchedule();

	List<EmpBean> findAllEmps();

	int saveSchedule(FactSchedule schedule);

	void deleteScheduleByKey(int keySchedule);

	FactSchedule findSchedByPK(int keySchedule);

	void updateSchedule(FactSchedule schedule);

}
