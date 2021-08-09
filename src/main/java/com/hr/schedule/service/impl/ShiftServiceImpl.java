package com.hr.schedule.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import org.springframework.transaction.annotation.Transactional;

import com.hr.schedule.model.DimShift;
import com.hr.schedule.repository.ShiftRepository;
import com.hr.schedule.service.ShiftService;
@Service
@Transactional
@EnableTransactionManagement
public class ShiftServiceImpl implements ShiftService {

	@Autowired
	ShiftRepository shiftRepo;
	
	@Override
	public List<DimShift> findAllShifts() {
		return shiftRepo.findAllShifts();
	}

	@Override
	public int saveShift(DimShift shift) {
		int n = shiftRepo.saveShift(shift);
		return n;
	}

}
