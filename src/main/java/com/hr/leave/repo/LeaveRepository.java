package com.hr.leave.repo;

import java.util.List;

import com.hr.leave.model.LeaveBean;
import com.hr.leave.model.ListBean;
import com.hr.login.model.LoginModel;
import com.hr.personnel.model.Personnel;
import com.hr.schedule.model.ProfilePic;

public interface LeaveRepository {

	List<ListBean> findListByCategory(String category);

	List<LoginModel> findEmpsByDept(Integer departmentNumber);

	Personnel findEmpByPk(Integer empId);

	List<LeaveBean> findAllLeave();

	void save(LeaveBean leave);

	List<LeaveBean> findLeaveByEmpNo(String empNo);

	List<LeaveBean> findLeaveByDeptNo(Integer departmentNumber);

	LeaveBean findLeaveByAppNo(String applicationNo);
	
	public void updateSupervisorComment(String applicationNo, String approval01Sig, String approval01MGR, String status);

	float findAnnualLTook(String empNo, String preAnnivD);

	ProfilePic findEmpPicByPk(Integer empId);
}
