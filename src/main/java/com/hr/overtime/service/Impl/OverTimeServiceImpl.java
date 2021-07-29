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
//		String Type = "submit";
//		String EmpNo = "123";
//		// String EmpNo = (String) parasession.getAttribute("empno");
//		String DateOfApplication = request.getParameter("Date of Application");
//		String EmpName = request.getParameter("EmpName");
//		String Department = request.getParameter("department");
//		String Position = request.getParameter("position");
//		String OvertimeCategory = request.getParameter("Overtime category");
//		String OvertimeDate = request.getParameter("OvertimeDate");
//		String StartingTime = request.getParameter("Starting time");
//		String EndingTime = request.getParameter("Ending time");
//		double hours = getOverTimeHours(StartingTime, EndingTime);
//		String Reason = request.getParameter("reason");
//		String Remarks = request.getParameter("Remarks");
//
//		//convert to bean
//		OverTimePending overtime = new OverTimePending();
//		overtime.setType(Type);
//		overtime.setEmpNo(EmpNo);
//		overtime.setDateOfApplication(getDate(DateOfApplication));
//		overtime.setEmpName(EmpName);
//		overtime.setDepartment(Department);
//		overtime.setPosition(Position);
//		overtime.setOvertimeCategory(OvertimeCategory);
//		overtime.setOverTimeDate(getDate(OvertimeDate));
//		overtime.setStartingTime(StartingTime);
//		overtime.setEndingTime(EndingTime);
//		overtime.setOverTimeHours(Double.toString(hours));
//		overtime.setReason(Reason);
//		overtime.setRemarks(Remarks);
//		overtime.setResult("pending");
		
		//用start & end 算出 加班時數
		double hours = getOverTimeHours(overTimePending.getStartingTime(), overTimePending.getEndingTime());
		
		overTimePending.setOverTimeHours(Double.toString(hours));
		overTimePending.setType("submit");
		overTimePending.setResult("pending");
		
		overTimeRepository.savePending(overTimePending);

		
	}

	@Override
	public List<OverTimePending> findByEmpnoPending(String empNo) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<OverTimeAuditted> findByEmpnoAuditted(String empNo) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<OverTimePending> findByResult() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public OverTimePending findById(int id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void deletePending(OverTimePending overTimePending) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void saveAuditted(OverTimeAuditted overTimeAuditted) {
		// TODO Auto-generated method stub
		
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
