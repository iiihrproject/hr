package com.hr.leave.repo;

import java.util.List;

import com.hr.leave.model.LeaveBean;
import com.hr.leave.model.ListBean;
import com.hr.login.model.LoginModel;
import com.hr.personnel.model.Personnel;

public interface LeaveRepository {

	List<ListBean> findListByCategory(String category);

	List<LoginModel> findEmpsByDept(Integer departmentNumber);

	List<Personnel> findEmpByPk(Integer empId);

	List<LeaveBean> findAllLeave();

	void save(LeaveBean leave);

	List<LeaveBean> findLeaveByEmpNo(String empNo);

	List<LeaveBean> findLeaveByDeptNo(Integer departmentNumber);

	List<LeaveBean> findLeaveByAppNo(String applicationNo);

}
