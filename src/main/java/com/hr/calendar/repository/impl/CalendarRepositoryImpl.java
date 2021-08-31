package com.hr.calendar.repository.impl;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;


import javax.persistence.EntityManager;

import org.hibernate.Session;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hr.calendar.model.CalendarTask;
import com.hr.calendar.repository.CalendarRepository;
import com.hr.schedule.model.FactSchedule;




@Repository
public class CalendarRepositoryImpl implements CalendarRepository {

	@Autowired
	EntityManager entityManager;
	
	private Session session;
	public CalendarRepositoryImpl(Session session) {
		this.session = session;
	}
	public Session getSession() {
		return session;
	}

	
	@Override
	public void newTask(CalendarTask task) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date createTime = new Date();
		task.setCreateTime(sdf.format(createTime));
		task.setEditTime(sdf.format(createTime));
		entityManager.persist(task);
		
	}
	

	@Override
	public void edit(CalendarTask task) {	
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date editTime = new Date();
		task.setEditTime(sdf.format(editTime));
		entityManager.merge(task);
		
		}
		
//		CalendarTask editTask = findTheTask(task.getNo());		
//		task.setStartTime(editTask.getStartTime());
//		task.setEndTime(editTask.getEndTime());
//		task.setColorTag(editTask.getColorTag());
//		task.setTaskTitle(editTask.getTaskTitle());
//		task.setTaskText(editTask.getTaskText());
//		task.setTaskStatus(editTask.getTaskStatus());
//		task.setEditTime(task.getEditTime());
		
//		entityManager.detach(editTask);
//		entityManager.merge(task);		
		

	

	@Override
	public void delete(Integer no) {
//		CalendarTask userTask = entityManager.find(CalendarTask.class, no);
		CalendarTask userTask = findTheTask(no);
		entityManager.remove(userTask);
	}

	
	@Override
	public List<CalendarTask> showTasksByEmpNo(String empNo) {
//		empNo="general";
		String hql = "FROM CalendarTask ct WHERE ct.empNo =: empNo";
		return entityManager.createQuery(hql, CalendarTask.class).setParameter("empNo", empNo).getResultList();
	}

	
	@Override
	public CalendarTask findTheTask(Integer no) {
		return entityManager.find(CalendarTask.class, no);
	}
	
	@Override
	public List<FactSchedule> showShiftByEmpNo(String empNo){
		String sql = "SELECT shift.* FROM FactSchedule shift LEFT OUTER JOIN loginModel login ON shift.empID = login.emp_id WHERE login.empNo = :empNo";
		List<FactSchedule> query = session.createSQLQuery(sql).setParameter("empNo", empNo)
				.addEntity("shift", FactSchedule.class)
				.getResultList();
		System.out.println("===== " + query.size());
		System.out.println("===== " + query);
		return query;
	}

}
