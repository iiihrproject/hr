package com.hr.schedule.repository;

import java.util.List;

import com.hr.schedule.model.DimShift;

public interface ShiftRepository {

	List<DimShift> findAllShifts();

	int saveShift(DimShift shift);

}
