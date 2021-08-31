package com.hr.overtime.service.Impl;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hr.overtime.model.OverTimeAuditted;
import com.hr.overtime.model.OverTimePending;
import com.hr.overtime.repository.OverTimeRepository;
import com.hr.overtime.service.OverTimeService;

@Service
@Transactional
public class OverTimeServiceImpl implements OverTimeService {
	
	@Autowired
	OverTimeRepository overTimeRepository;
	
	@Override
	public void savePending(OverTimePending overTimePending) {
		
		double hours = getOverTimeHours(overTimePending.getStartingTime(), overTimePending.getEndingTime());
		
		overTimePending.setOverTimeHours(Double.toString(hours));
		overTimePending.setType("submit");
		overTimePending.setResult("pending");
		
		overTimeRepository.savePending(overTimePending);

		
	}
	
	@Override
	public List<OverTimePending> findPartByEmpnoPending(String empNo) {
	List<OverTimePending>overtimepending = overTimeRepository.findPartByEmpnoPending(empNo);
		return overtimepending;
	}
	
	@Override
	public List<OverTimeAuditted> findPartByEmpnoAuditted(String empNo) {
	List<OverTimeAuditted>overtimeauditted = overTimeRepository.findByEmpnoAuditted(empNo);
		return overtimeauditted;
	}
	

	@Override
	public List<OverTimePending> findByEmpnoPending(String empNo) {
		List<OverTimePending> overtimepending = overTimeRepository.findByEmpnoPending(empNo);
		return overtimepending;
	}

	@Override
	public List<OverTimeAuditted> findByEmpnoAuditted(String empNo) {
		List<OverTimeAuditted> overtimeauditted = overTimeRepository.findByEmpnoAuditted(empNo);
		return overtimeauditted;
	}
	
	@Override
	public Double sumOverTimeHours(String empNo) {
		Double overtimeauditted = overTimeRepository.sumOverTimeHours(empNo);
		return overtimeauditted;
	}
	
//--------------------------------------------管理員--------------------------------------------------------
	@Override
	public List<OverTimePending> findByResult() {
		List<OverTimePending> overtimepending = overTimeRepository.findByResult();
		return overtimepending;
	}

	@Override
	public OverTimePending findById(Integer id) {
		OverTimePending overtimepending = overTimeRepository.findById(id);
		return overtimepending;
	}

	@Override
	public void deletePending(OverTimePending overTimePending) {
		overTimeRepository.deletePending(overTimePending);
		
	}
	
//	@Override
//	public DepartmentDetail queryManagerId(int dept_no) {
//		return overTimeRepository.queryManagerId(dept_no);
//	}

	@Override
	public void saveAuditted(OverTimePending overTimePending ,String type) {
		
		OverTimeAuditted overTimeAuditted = new OverTimeAuditted();
		overTimeAuditted.setType(overTimePending.getType());
		overTimeAuditted.setDateOfApplication(overTimePending.getDateOfApplication());
		overTimeAuditted.setEmpNo(overTimePending.getEmpNo());
		overTimeAuditted.setEmpName(overTimePending.getEmpName());
		overTimeAuditted.setDepartment(overTimePending.getDepartment());
		overTimeAuditted.setPosition(overTimePending.getPosition());
		overTimeAuditted.setOvertimeCategory(overTimePending.getOvertimeCategory());
		overTimeAuditted.setOverTimeDate(overTimePending.getOverTimeDate());
		overTimeAuditted.setStartingTime(overTimePending.getStartingTime());
		overTimeAuditted.setEndingTime(overTimePending.getEndingTime());
		overTimeAuditted.setOverTimeHours(overTimePending.getOverTimeHours());
		overTimeAuditted.setReason(overTimePending.getReason());
		overTimeAuditted.setRemarks(overTimePending.getRemarks());
		overTimeAuditted.setResult(type);
		overTimeRepository.saveAuditted(overTimeAuditted);
		
	}
	
	private double getOverTimeHours(String startTime, String endTime) {

		double diffHours = 0;
		double diffHours1 = 0;

		try {
			SimpleDateFormat sdf = new SimpleDateFormat("HH:mm");

			Date startDate = sdf.parse(startTime);
			Date endDate = sdf.parse(endTime);

			long diff = endDate.getTime() - startDate.getTime();
			diffHours = diff / (60 * 60.0 * 1000) % 24;
			BigDecimal b = new BigDecimal(diffHours);
			diffHours1 = b.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return diffHours1;

	}

	
	
}
