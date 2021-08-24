package com.hr.complementsign.repository.Impl;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import com.hr.complementsign.model.PendingComplementSign;

public interface PendingSignRepository extends JpaRepository<PendingComplementSign, Integer> {
	@Query(nativeQuery = true,value=  "select a.* from complementSignPendingApproval a \n " + 
			"where (:empNo is null or empNo = :empNo ) \n " + 
			"and ((:date is null or :date = 'null') or CONVERT(char(7), a.date, 120)　= :date) \n " + 
			"and (:managerEmpId is null or managerNo = :managerEmpId )",
			countQuery = "select count(*) from complementSignPendingApproval a  \n " +
					"where (:empNo is null or empNo = :empNo ) \n " + 
					"and ((:date is null or :date = 'null') or CONVERT(char(7), a.date, 120)　= :date) \n " + 
					"and (:managerEmpId is null or managerNo = :managerEmpId )")
	public Page<PendingComplementSign> findPendingSignByEmpNo(Pageable page,@Param("empNo") String empNo ,@Param("date")String date,
			@Param("managerEmpId")Integer managerEmpId);
}
