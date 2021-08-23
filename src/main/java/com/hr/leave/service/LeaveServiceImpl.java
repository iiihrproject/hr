package com.hr.leave.service;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

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
	public List<Personnel> findEmpByPk(Integer empId) {
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
	public void save(LeaveBean leave, LoginModel loginModel) {
		System.out.println(leave);
		leave.setTypeOfForm("Leave");
		leave.setApplicationNo("L"+LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyMMHHmmss")));
		leave.setEmpNo(loginModel.getEmpNo());
		leave.getDept().setDepartmentNumber(loginModel.getDepartmentDetail().getDepartmentNumber());
		leave.setStatus("pending");
		leaveRepo.save(leave);
		
	}

}
