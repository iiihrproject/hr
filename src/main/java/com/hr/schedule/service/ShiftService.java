package com.hr.schedule.service;

import java.util.List;

import com.hr.schedule.model.DimShift;

public interface ShiftService {

	List<DimShift> findAllShifts();

	int saveShift(DimShift shift);

}
