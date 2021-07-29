package com.hr.overtime.service;

import java.util.List;

import com.hr.overtime.model.OverTimeAuditted;
import com.hr.overtime.model.OverTimePending;

public interface OverTimeService {
	//--------------------------------------員工---------------------------------------------//
		void savePending(OverTimePending overTimePending);// 存資料

		List<OverTimePending> findByEmpnoPending(String empNo);// 取得某個員工查詢自己

		List<OverTimeAuditted> findByEmpnoAuditted(String empNo);// 取得某個員工查詢自己
		
		//--------------------------------------管理員----------------------------------------------//

		List<OverTimePending> findByResult();// 管理員查詢待審核

		OverTimePending findById(int id);// 管理員審核 抓當下那筆

		void deletePending(OverTimePending overTimePending);// 管理員批准刪除

		void saveAuditted(OverTimeAuditted overTimeAuditted);// 將刪除資料新增進auditted資料表

}