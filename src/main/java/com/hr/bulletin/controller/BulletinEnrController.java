package com.hr.bulletin.controller;

import java.sql.Timestamp;
import java.util.HashMap;
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
import com.hr.bulletin.model.Bulletin;
import com.hr.bulletin.service.BulletinService;

@Controller
@SessionAttributes("loginModel")
public class BulletinEnrController {
	
	private static Logger log = LoggerFactory.getLogger(BulletinEnrController.class);
	
	@Autowired
	BulletinService bulletinService;
	
	@PostMapping("/bulletinInsertEnroll")
	public @ResponseBody void insertEnroll(String empNo, int postno) {
		log.info("insertEnroll方法執行中...");
		BulEnroll bulEN = new BulEnroll();
		Timestamp ts = new Timestamp(System.currentTimeMillis());
		try {
			BulEnroll bulES = bulletinService.findEnrollByno(empNo, postno);
			bulEN.setEnrollId(bulES.getEnrollId());
			bulEN.setEmpNo(empNo);
			bulEN.setPostno(postno);
			bulEN.setUpdateTime(ts);
			if(bulES.getEnrollStatus().equals("參加")) {
				bulEN.setEnrollStatus("取消參加");
			}else {
				bulEN.setEnrollStatus("參加");
			}
		}catch(Exception e){
			bulEN.setEmpNo(empNo);
			bulEN.setPostno(postno);
			bulEN.setEnrollStatus("參加");
			bulEN.setUpdateTime(ts);
		}
		String result = "";
		try {
			System.out.println("co_id:"+bulEN.getEnrollId());
			System.out.println("co_no:"+bulEN.getEmpNo());
			System.out.println("co_status:"+bulEN.getEnrollStatus());
			System.out.println("co_postno:"+bulEN.getPostno());
			bulletinService.insertEnroll(bulEN);
			result = "報名改變";
		} catch (Exception e) {
			result = "報名未改變";
		}
		System.out.println(result);
	}
	
	@PostMapping("/bulletinFindEnroll")
	public @ResponseBody BulEnroll findEnrollByno(@RequestParam String empNo, @RequestParam int postno) {
		log.info("FindEnroll方法執行中...");
		try {
		BulEnroll bulEnroll = bulletinService.findEnrollByno(empNo, postno);
		return bulEnroll;
		} catch (Exception e) {
			return null;
		}
		
	}
	
	

}
