package com.hr.overtime.repository.Impl;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.hr.overtime.model.OverTimePending;

public interface OverTimePendingRepository extends JpaRepository<OverTimePending, Integer>{

	@Query(nativeQuery = true,value=  "select a.* from overtimeapplicationpending a \n " + 
			"where (:empNo is null or empNo = :empNo ) \n " + 
			"and ((:date is null or :date = 'null') or CONVERT(char(7), a.dateOfApplication, 120)　= :date) \n " + 
			"and ((:depart is null or :depart = 'null') or department = :depart ) \n " +
			"and (:managerEmpId is null or managerEmpId = :managerEmpId )",
			countQuery = "select count(*) from overtimeapplicationpending a  \n " +
					"where (:empNo is null or empNo = :empNo ) \n " + 
					"and ((:date is null or :date = 'null') or CONVERT(char(7), a.dateOfApplication, 120)　= :date) \n " + 
					"and (:depart is null or :depart = 'null' or department = :depart ) \n " +
					"and (:managerEmpId is null or managerEmpId = :managerEmpId )")
	public Page<OverTimePending> findByEmpNo(Pageable page,@Param("empNo") String empNo ,@Param("date")String date,
											@Param("depart")String depart,@Param("managerEmpId")Integer managerEmpId);
	
	
}
