package com.hr.schedule.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hr.schedule.model.EmpBean;
import com.hr.schedule.model.FactSchedule;
import com.hr.schedule.repository.ScheduleRepository;
import com.hr.schedule.service.ScheduleService;
@Service
@Transactional
public class ScheduleServiceImpl implements ScheduleService {
	@Autowired
	ScheduleRepository scheduleRepo;
	
	@Override
	public List<FactSchedule> findAllSchedule() {
		return scheduleRepo.findAllSchedule();
	}

	@Override
	public List<EmpBean> findAllEmps() {
		return scheduleRepo.findAllEmps();
	}

	@Override
	public int saveSchedule(FactSchedule schedule) {
		int n = scheduleRepo.saveSchedule(schedule);
		return n;
	}

	@Override
	public void deleteScheduleByKey(int keySchedule) {
		scheduleRepo.deleteScheduleByKey(keySchedule);
	}

	@Override
	public FactSchedule findSchedByPK(Integer keySchedule) {
		return scheduleRepo.findSchedByPK(keySchedule);
	}

	@Override
	public void updateSchedule(FactSchedule schedule) {
		scheduleRepo.updateSchedule(schedule);
	}

}
