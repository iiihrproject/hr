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
			 map.put("managerEmpNo", managerLoginModel.getEmpNo());
			 map.put("managerName", managerLoginModel.getName());
			 result.put(departmentDetail.getDepartmentNumber(), map);
		}
		return result;
	}

	@Override
	public Map<Integer, Map<String, String>> findAllDepartmentDetailWithReplacementOfNewManager(Map<String, String> inputMap) {
		/**
		 * Firstly, merging the DepartmentDetail that given by the front end and check if it succeed
		 */

		DepartmentDetail departmentDetail = departmentRepository.findDepartment(Integer.parseInt(inputMap.get("departmentNumber")));

		if(!(inputMap.get("managerEmpNo")).equals("")) {
			Integer managerId = departmentRepository.findLoginModelByEmpNo(inputMap.get("managerEmpNo")).getPk();
			departmentDetail.setManagerEmpId(managerId);
		}
		
		if(!(inputMap.get("name")).equals("")) {
			departmentDetail.setName(inputMap.get("name"));
		}
		
		DepartmentDetail newDepartmentDetail = departmentRepository.updateDepartmentDetail(departmentDetail);
		if(departmentDetail.equals(newDepartmentDetail)) {
			return findAllDepartmentDetail();
		}
		return null;
	}

	@Override
	public boolean insertNewDepartments(Map<Integer, Map<String, String>> inputMap) {
		if(inputMap.isEmpty()) {
			return false;
		}
		Set<Integer> keySet = inputMap.keySet();
		Iterator<Integer> iterator = keySet.iterator();
		try {
			while(iterator.hasNext()) {
				Integer key = iterator.next();
				Map<String, String> detail = inputMap.get(key);
				Integer managerId = departmentRepository.findLoginModelByEmpNo(detail.get("managerEmpNo")).getPk();
				DepartmentDetail departmentDetail = new DepartmentDetail();
				departmentDetail.setManagerEmpId(managerId);
				departmentDetail.setName(detail.get("name"));
				boolean flowCheck = departmentRepository.insertNewDepartments(departmentDetail);
				if(!flowCheck) {
					throw new Exception();
				}
			}
		}
		catch(IllegalArgumentException e) {
			return false;
		}
		catch(Exception e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}
}
