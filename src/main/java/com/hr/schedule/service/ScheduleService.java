package com.hr.schedule.service;

import java.util.List;
import com.hr.schedule.model.EmpBean;
import com.hr.schedule.model.FactSchedule;

public interface ScheduleService {

	List<FactSchedule> findAllSchedule();

	List<EmpBean> findAllEmps();

	int saveSchedule(FactSchedule schedule);

	void deleteScheduleByKey(int keySchedule);

	FactSchedule findSchedByPK(Integer keySchedule);

	void updateSchedule(FactSchedule schedule);

}
