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

import com.hr.bulletin.model.BulMessage;
import com.hr.bulletin.model.Bulletin;
import com.hr.bulletin.service.BulletinService;

@Controller
public class BulletinMsgController {
	
	private static Logger log = LoggerFactory.getLogger(BulletinMagController.class);
	
	@Autowired
	BulletinService bulletinService;
	
	@PostMapping("/insertMessage")
	public @ResponseBody Map<String, String> saveMsg(@RequestBody BulMessage bulMessage) {
		log.info("saveMsg方法執行中...");

		// 時間戳記
		Timestamp ts = new Timestamp(System.currentTimeMillis());
		bulMessage.setCreateTime(ts);
		
		Map<String, String> map = new HashMap<>();
		String result = "";
		System.out.println("messgae:"+bulMessage.getMessage());
		System.out.println(bulMessage.getMessage()!=null);
		System.out.println(bulMessage.getMessage()!="");
		try {
			if(bulMessage.getMessage()!=null && bulMessage.getMessage()!="") {
			bulletinService.insertMsg(bulMessage);
			result = "新增成功";
			map.put("success", result);
			}
			else {
			result = "請輸入留言";
			map.put("failnull", result);
			}
		} catch (Exception e) {
			result = e.getMessage();
			map.put("fail", result);
		}
		return map;
	}
	
	@GetMapping("/bulletinGetMsg")
	public @ResponseBody List<BulMessage> findMsgByNo(@RequestParam("postno") int postno) {
		log.info("findMsgByNo方法執行中...");
		List<BulMessage> bulList = bulletinService.findAllMsg(postno);
		return bulList;
	}
	
	

}
