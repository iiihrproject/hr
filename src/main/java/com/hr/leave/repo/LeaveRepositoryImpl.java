package com.hr.leave.repo;

import java.util.List;

import javax.persistence.EntityManager;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hr.leave.model.LeaveBean;
import com.hr.leave.model.ListBean;
import com.hr.login.model.LoginModel;
import com.hr.personnel.model.Personnel;
@Repository
public class LeaveRepositoryImpl implements LeaveRepository {

	@Autowired
	EntityManager entityManager;
	
	@Override
	public void updateSupervisorComment(String applicationNo, String approval01Signature) {
		entityManager.createNativeQuery("update LeaveOfAbsense set Approval01Signature = ?1 "
				+ ", set Approval01Date = getDate() "
				+ " where applicationNo = ?2")
			.setParameter(1, approval01Signature)
			.setParameter(2, applicationNo)
			.executeUpdate();
	}
	
	@Override
	public List<ListBean> findListByCategory(String category) {
		List<ListBean> listB = null;
		String hql = "FROM ListBean lb WHERE lb.category = :category";
		listB = entityManager.createQuery(hql, ListBean.class).setParameter("category", category).getResultList();
		return listB;
	}

	@Override
	public List<LoginModel> findEmpsByDept(Integer departmentNumber) {
		List<LoginModel> loginM = null;
		String hql = "FROM loginModel WHERE departmentDetail.departmentNumber = :departmentNumber";
		loginM = entityManager.createQuery(hql, LoginModel.class).setParameter("departmentNumber", departmentNumber).getResultList();
		return loginM;
	}

	@Override
	public List<Personnel> findEmpByPk(Integer empId) {
		List<Personnel> p = null;
		String hql = "FROM personnel WHERE empId = :empId";
		p = entityManager.createQuery(hql, Personnel.class).setParameter("empId", empId).getResultList();
		return p;
	}

	@Override
	public List<LeaveBean> findAllLeave() {
		List<LeaveBean> leaveB = null;
		String hql = "FROM LeaveBean order by APPLICATIONNO desc";
		leaveB = entityManager.createQuery(hql, LeaveBean.class).getResultList();
		return leaveB;
	}

	@Override
	public void save(LeaveBean leave) {
		entityManager.persist(leave);
	}

	@Override
	public List<LeaveBean> findLeaveByEmpNo(String empNo) {
		List<LeaveBean> leaveB = null;
		String hql = "FROM LeaveBean l WHERE l.empNo =:empNo order by APPLICATIONNO desc";
		leaveB = entityManager.createQuery(hql, LeaveBean.class).setParameter("empNo", empNo).getResultList();
		return leaveB;
	}

	@Override
	public List<LeaveBean> findLeaveByDeptNo(Integer departmentNumber) {
		List<LeaveBean> leaveB = null;
		String hql = "FROM LeaveBean l WHERE l.dept.departmentNumber = :departmentNumber order by APPLICATIONNO desc";
		leaveB = entityManager.createQuery(hql, LeaveBean.class).setParameter("departmentNumber", departmentNumber).getResultList();
		return leaveB;
	}

	@Override
	public List<LeaveBean> findLeaveByAppNo(String applicationNo) {
		List<LeaveBean> leaveB = null;
		String hql = "FROM LeaveBean l WHERE l.applicationNo =:applicationNo";
		leaveB = entityManager.createQuery(hql, LeaveBean.class)
				.setParameter("applicationNo", applicationNo)
				.getResultList();
		return leaveB;
	}
	
}
