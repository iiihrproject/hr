package com.hr.leave.service;

import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.List;
import java.util.concurrent.TimeUnit;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hr.leave.model.LeaveBean;
import com.hr.leave.model.ListBean;
import com.hr.leave.repo.LeaveRepository;
import com.hr.login.model.LoginModel;
import com.hr.personnel.model.Personnel;
@Service
@Transactional
public class LeaveServiceImpl implements LeaveService {
	@Autowired
	LeaveRepository leaveRepo;
	
	@Override
	public List<ListBean> findListByCategory(String category) {
		return leaveRepo.findListByCategory(category);
	}

	@Override
	public List<LoginModel> findEmpsByDept(Integer departmentNumber) {
		return leaveRepo.findEmpsByDept(departmentNumber);
	}

	@Override
	public Personnel findEmpByPk(Integer empId) {
		return leaveRepo.findEmpByPk(empId);
	}
	
	@Override
	public List<LeaveBean> findAllLeave() {
		return leaveRepo.findAllLeave();
	}

	@Override
	public List<LeaveBean> findLeaveByEmpNo(String empNo) {
		return leaveRepo.findLeaveByEmpNo(empNo);
	}
	
	@Override
	public List<LeaveBean> findLeaveByDeptNo(Integer departmentNumber) {
		return leaveRepo.findLeaveByDeptNo(departmentNumber);
	}
	
	@Override
	public void updateSupervisorComment(String applicationNo, String approval01Sig, String approval01MGR, String status) {
		leaveRepo.updateSupervisorComment(applicationNo, approval01Sig, approval01MGR, status);
//		LeaveBean leaveBean = leaveRepo.findLeaveByAppNo(applicationNo).get(0);
//		leaveBean.setApproval01Date(new Date());
//		leaveBean.setApproval01Sig(approval01Signature);
//		leaveRepo.save(leaveBean);
	}
	
	@Override
	public void save(LeaveBean leave, LoginModel loginModel) {
		long hoursDiff = calTimeDifference(leave.getStartTime(),leave.getEndTime());
		leave.setTypeOfForm("Leave");
		leave.setApplicationNo("L"+LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyMMddHHmmss")));
		leave.setDept(loginModel.getDepartmentDetail());
		leave.setApproval01MGR("待處理...");
		leave.setDays(hoursDiff);
		leaveRepo.save(leave);
		
	}

	@Override
	public LeaveBean findLeaveByAppNo(String applicationNo) {
		return leaveRepo.findLeaveByAppNo(applicationNo);
	}
	
	public long calTimeDifference(String start, String end) {
		long diff = 0;
		try {
			SimpleDateFormat sdf = new SimpleDateFormat("HH:mm");
			Date startTime = sdf.parse(start);
			Date endTime = sdf.parse(end);
			long diffInMillies = Math.round(endTime.getTime() - startTime.getTime());
			diff = TimeUnit.DAYS.convert(diffInMillies, TimeUnit.MILLISECONDS)+1;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return diff;
	}
}
