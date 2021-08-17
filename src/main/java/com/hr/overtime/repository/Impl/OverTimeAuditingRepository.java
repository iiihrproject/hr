package com.hr.overtime.repository.Impl;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.hr.overtime.model.OverTimeAuditted;

public interface OverTimeAuditingRepository extends JpaRepository<OverTimeAuditted, Integer>{

	@Query(nativeQuery = true,value=  "select a.* from overtimeapplicationauditted a where empNo = :empNo \n " + 
			"and ((:date is null or :date = 'null') or CONVERT(char(7), a.dateOfApplication, 120)　= :date) \n " + 
			"and ((:depart is null or :depart = 'null') or department = :depart )  ",
			countQuery = "select count(*) from overtimeapplicationauditted a where empNo = :empNo \n "
					+ "and ((:date is null or :date = 'null') or CONVERT(char(7), a.dateOfApplication, 120)　= :date) \n " + 
					"and ((:depart is null or :depart = 'null') or department = :depart ) \n ")
	public Page<OverTimeAuditted> findByEmpNo(Pageable page,@Param("empNo") String empNo ,@Param("date")String date,
											@Param("depart")String depart);
	
}
