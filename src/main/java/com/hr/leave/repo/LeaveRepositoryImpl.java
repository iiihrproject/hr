package com.hr.leave.repo;

import java.math.BigDecimal;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.Query;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hr.leave.model.LeaveBean;
import com.hr.leave.model.ListBean;
import com.hr.login.model.LoginModel;
import com.hr.personnel.model.Personnel;
import com.hr.schedule.model.ProfilePic;
@Repository
public class LeaveRepositoryImpl implements LeaveRepository {

	@Autowired
	EntityManager entityManager;
	
	@Override
	public void updateSupervisorComment(String applicationNo, String approval01Sig, String approval01MGR, String status) {
		entityManager.createNativeQuery("update LeaveOfAbsense set Approval01Sig = ?1 "
				+ ", Approval01Date = getDate() "
				+ ", Approval01MGR =?2 "
				+ ", status =?3 "
				+ " where applicationNo =?4")
			.setParameter(1, approval01Sig)
			.setParameter(2, approval01MGR)
			.setParameter(3, status)
			.setParameter(4, applicationNo)
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
	public Personnel findEmpByPk(Integer empId) {
		Personnel p = null;
		String hql = "FROM personnel WHERE empId = :empId";
		p = entityManager.createQuery(hql, Personnel.class).setParameter("empId", empId).getSingleResult();
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
	public LeaveBean findLeaveByAppNo(String applicationNo) {
		LeaveBean leaveB = null;
		String hql = "FROM LeaveBean l WHERE l.applicationNo =:applicationNo";
		leaveB = entityManager.createQuery(hql, LeaveBean.class)
				.setParameter("applicationNo", applicationNo)
				.getSingleResult();
		return leaveB;
	}

	@Override
	public float findAnnualLTook(String empNo, String preAnnivD) {
		Query query = entityManager.createNativeQuery("select SUM (convert(decimal,days)) as total_annualLTook "
				+ "from LeaveofAbsense "
				+ "where empNo=? and status = 'S03' and "
				+ "reason_id= 'R03' and STARTDATE > ? "
				+ "group by empno")
			.setParameter(1, empNo)
			.setParameter(2, preAnnivD)
			;
		if(query.getResultList().size()>0) {
		BigDecimal r = (BigDecimal) query.getSingleResult();
		return r != null ? r.floatValue() : 0;
		}
		return 0;
	}

	@Override
	public ProfilePic findEmpPicByPk(Integer empId) {
		ProfilePic p = null;
		String hql = "FROM ProfilePic WHERE empId = :empId";
		p = entityManager.createQuery(hql, ProfilePic.class).setParameter("empId", empId).getSingleResult();
		return p;
	}

}
