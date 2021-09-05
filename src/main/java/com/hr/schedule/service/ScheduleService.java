package com.hr.schedule.service;

import java.util.List;
import com.hr.schedule.model.EmpBean;
import com.hr.schedule.model.FactSchedule;

public interface ScheduleService {

	List<FactSchedule> findAllSchedule();
	
	List<FactSchedule> findScheduleByDeptNo(Integer deptNo);

	List<EmpBean> findAllEmps();
	
	int addScheduleMonthly(FactSchedule schedule);

	int saveSchedule(FactSchedule schedule);

	void deleteScheduleByKey(int keySchedule);

	FactSchedule findSchedByPK(Integer keySchedule);

	void updateSchedule(FactSchedule schedule);

}
