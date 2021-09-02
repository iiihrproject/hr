package com.hr.bulletin.controller;

import java.sql.Timestamp;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.hr.bulletin.model.BulEnroll;
import com.hr.bulletin.model.BulLike;
import com.hr.bulletin.model.BulMessage;
import com.hr.bulletin.model.BulName;
import com.hr.bulletin.model.Bulletin;
import com.hr.bulletin.service.BulletinService;
import com.hr.login.model.LoginModel;
import com.hr.personnel.model.DepartmentDetail;
import com.hr.personnel.service.DepartmentService;

@Controller
@SessionAttributes("loginModel")
public class BulletinEnrController {
	
	private static Logger log = LoggerFactory.getLogger(BulletinEnrController.class);
	
	@Autowired
	BulletinService bulletinService;
	
	@PostMapping("/bulletinInsertEnroll") //all
	public @ResponseBody void insertEnroll(String empNo, int postno) {
		log.info("insertEnroll方法執行中...");
		BulEnroll bulEN = new BulEnroll();
		Timestamp ts = new Timestamp(System.currentTimeMillis());
		LoginModel loginM = bulletinService.getLoginModelByEmpNo(empNo);
		try {
			BulEnroll bulES = bulletinService.findEnrollByno(empNo, postno);
			bulEN.setEnrollId(bulES.getEnrollId());
			bulEN.setCreateTime(bulES.getCreateTime());
			bulEN.setEmpNo(empNo);
			bulEN.setPostno(postno);
			bulEN.setUpdateTime(ts);
			bulEN.setEmpName(loginM.getName());
			bulEN.setEmpDept(loginM.getDepartmentDetail().getName());
			if(bulES.getEnrollStatus().equals("參加")) {
				bulEN.setEnrollStatus("取消參加");
			}else {
				bulEN.setEnrollStatus("參加");
			}
		}catch(Exception e){
			bulEN.setEmpNo(empNo);
			bulEN.setPostno(postno);
			bulEN.setEnrollStatus("參加");
			bulEN.setCreateTime(ts);
			bulEN.setUpdateTime(ts);
			bulEN.setEmpName(loginM.getName());
			bulEN.setEmpDept(loginM.getDepartmentDetail().getName());
		}
		String result = "";
		try {
			bulletinService.insertEnroll(bulEN);
			result = "報名改變";
		} catch (Exception e) {
			result = "報名未改變";
		}
	}
	
	@PostMapping("/bulletinFindEnroll") //all
	public @ResponseBody BulEnroll findEnrollByno(@RequestParam String empNo, @RequestParam int postno) {
		log.info("FindEnroll方法執行中...");
		try {
		BulEnroll bulEnroll = bulletinService.findEnrollByno(empNo, postno);
		return bulEnroll;
		} catch (Exception e) {
			return null;
		}
		
	}
	
	
	// 活動人員列表
	@GetMapping("/applyList") //h
	public @ResponseBody List<BulEnroll> findEnrollListByNo(@RequestParam("postno") int postno) {
		log.info("findEnrollListByNo方法執行中...");
		List<BulEnroll> bulEnroll = bulletinService.findEnrollListByNo(postno);		
		return bulEnroll;
	}
	
	// 我參加的活動列表
	@GetMapping("/myApplyList")  //all
	public @ResponseBody List<BulName> findMyEnrollByEmpNo(@RequestParam("empNo") String empNo) {
		log.info("findEnrollByNo方法執行中...");
		List<BulName> bulName = bulletinService.findMyEnrollByEmpNo(empNo);
		return bulName;
	}
	
	// 報名人數
	@GetMapping("/findEnrollNumByNo")  //all
	public @ResponseBody int findEnrollNumByNo(@RequestParam("postno") int postno) {
		log.info("findEnrollNumByNo方法執行中...");
		List<BulEnroll> BulEnroll = bulletinService.findEnrollNumByNo(postno);
		return BulEnroll.size();
	}
}
