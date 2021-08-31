package com.hr.checksystem.repository.Impl;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.hr.checksystem.model.Checksystem;

public interface CheckSystemRepository extends JpaRepository<Checksystem, Integer>{

	@Query(nativeQuery = true,value=  "select a.* from Checksystem a where empNo = :empNo \n " + 
			"and (:date is null or CONVERT(char(6), a.createTime, 112)　= :date)",
			countQuery = "select a.* from Checksystem a where empNo = :empNo \n "
					+ "and (:date is null or CONVERT(char(6), a.createTime, 112)　= :date)")
	public Page<Checksystem> findByEmpNo(Pageable page,@Param("empNo") String empNo ,@Param("date")String date);
	
	@Query(nativeQuery = true,value=  "select a.* from Checksystem a  " + 
			"where ((:date is null or :date = 'null') or (CONVERT(char(7), a.checkInTime, 120)　= :date or CONVERT(char(7), a.checkOutTime, 120)　= :date )) "
			+ "and ((:depName is null or :depName = 'null') or depName =:depName )",
			countQuery = "select a.* from Checksystem a  " + 
					"where ((:date is null or :date = 'null') or (CONVERT(char(7), a.checkInTime, 120)　= :date or CONVERT(char(7), a.checkOutTime, 120)　= :date )) "
					+ "and ((:depName is null or :depName = 'null') or depName =:depName )")
	public Page<Checksystem> findAllCheck(Pageable page,@Param("date")String date,@Param("depName")String depName);
	
}
