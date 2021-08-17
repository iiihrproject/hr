package com.hr.calendar.repository.impl;

import java.sql.Date;
import java.util.List;

import javax.persistence.EntityManager;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hr.calendar.model.CalendarTask;
import com.hr.calendar.repository.CalendarRepository;


@Repository
public class CalendarRepositoryImpl implements CalendarRepository {

	@Autowired
	EntityManager entityManager;

	@Override
	public void newTask(CalendarTask task) {
		entityManager.persist(task);

	}

	@Override
	public void edit(CalendarTask task) {
		CalendarTask editTask = findTheTask(task.getStartTime(), task.getTaskTitle());
		
		System.out.println("ex-task: " + editTask);
		
		task.setStartTime(editTask.getStartTime());
		task.setEndTime(editTask.getEndTime());
		task.setColorTag(editTask.getColorTag());
		task.setTaskTitle(editTask.getTaskTitle());
		task.setTaskText(editTask.getTaskText());
		task.setTaskStatus(editTask.getTaskStatus());
		task.setEditTime(editTask.getEditTime());
		
		entityManager.detach(editTask);
		entityManager.merge(task);
	}

	@Override
	public void delete(CalendarTask task) {
		entityManager.remove(task);
	}

	@Override
	public List<CalendarTask> showTasksByEmpNo(String empNo) {
		String hql = "FROM calendartask ct WHERE ct.empNo = :empNo";
		return entityManager.createQuery(hql, CalendarTask.class).getResultList();
	}

	@Override
	public CalendarTask findTheTask(Date startTime, String taskTitle) {
		String hql = "FROM calendartask ct WHERE ct.startTime = :startTime AND ct.taskTitle = :taskTitle";
		return entityManager.createQuery(hql, CalendarTask.class).getSingleResult();
	}

}
