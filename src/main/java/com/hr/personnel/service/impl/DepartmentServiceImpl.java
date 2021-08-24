package com.hr.personnel.service.impl;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hr.login.model.LoginModel;
import com.hr.personnel.model.DepartmentDetail;
import com.hr.personnel.repository.DepartmentRepository;
import com.hr.personnel.service.DepartmentService;

@Service
@Transactional
public class DepartmentServiceImpl implements DepartmentService {

	@Autowired
	DepartmentRepository departmentRepository;

	@Override
	public Map<Integer, Map<String, String>> findAllDepartmentDetail() {
		Map<Integer, Map<String, String>> result = new HashMap<Integer, Map<String, String>>();
		Map<String, String> map;
		/**
		 * This departmentDetailList are all the departments that currently exist in the database
		 */
		List<DepartmentDetail> departmentDetailList = departmentRepository.findAllDepartments();
		for(DepartmentDetail departmentDetail :departmentDetailList) {
			/**
			 *And each of them should have a manager so a LoginModel could and should be found by ManagerEmpId()
			 */
			LoginModel managerLoginModel = departmentRepository.findLoginModel(departmentDetail.getManagerEmpId());
			 map = new HashMap<String, String>();
			 map.put("departmentNumber", departmentDetail.getDepartmentNumber().toString());
			 map.put("name", departmentDetail.getName());
			 map.put("managerEmpId", managerLoginModel.getPk().toString());
			 map.put("managerName", managerLoginModel.getName());
			 result.put(departmentDetail.getManagerEmpId(), map);
		}
		return result;
	}

	@Override
	public Map<Integer, Map<String, String>> findAllDepartmentDetailWithReplacementOfNewManager(DepartmentDetail departmentDetail) {
		/**
		 * Firstly, merging the DepartmentDetail that given by the front end and check if it succeed
		 */
		DepartmentDetail newDepartmentDetail = departmentRepository.updateDepartmentDetail(departmentDetail);
		if(departmentDetail.equals(newDepartmentDetail)) {
			return findAllDepartmentDetail();
		}
		return null;
	}

	@Override
	public boolean insertNewDepartments(Map<Integer, DepartmentDetail> departments) {
		if(departments.isEmpty()) {
			return false;
		}
		Set<Integer> keySet = departments.keySet();
		@SuppressWarnings("rawtypes")
		Iterator iterator = keySet.iterator();
		try {
			while(iterator.hasNext()) {
				Integer key = (Integer)iterator.next();
				DepartmentDetail departmentDetail = departments.get(key);
				departmentRepository.insertNewDepartments(departmentDetail);
			}
		}
		catch(IllegalArgumentException e) {
			return false;
		}
		catch(Exception e) {
			return false;
		}
		return true;
	}
}
