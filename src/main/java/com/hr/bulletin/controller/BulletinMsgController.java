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

import com.hr.bulletin.model.BulLike;
import com.hr.bulletin.model.BulMessage;
import com.hr.bulletin.model.Bulletin;
import com.hr.bulletin.service.BulletinService;

@Controller
@SessionAttributes("loginModel")
public class BulletinMsgController {
	
	private static Logger log = LoggerFactory.getLogger(BulletinMagController.class);
	
	@Autowired
	BulletinService bulletinService;
	
	@PostMapping("/insertMessage") //all
	public @ResponseBody Map<String, String> saveMsg(@RequestBody BulMessage bulMessage) {
		log.info("新增留言方法執行中...");

		// 時間戳記
		Timestamp ts = new Timestamp(System.currentTimeMillis());
		bulMessage.setCreateTime(ts);
		bulMessage.setMsgStatus("顯示");
		
		Map<String, String> map = new HashMap<>();
		String result = "";

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
	
	@GetMapping("/bulletinGetMsg") //all
	public @ResponseBody List<BulMessage> findMsgByNo(@RequestParam("postno") int postno) {
		log.info("留言載入方法執行中...");
		List<BulMessage> bulList = bulletinService.findAllMsg(postno);
		return bulList;
	}
	
	@GetMapping("/bulletinDelMsg") //all
	public @ResponseBody String delMsg(int id) {
		log.info("刪除留言方法執行中...");
		String result = "";
		try {
			bulletinService.delMsg(id);
			result = "刪除成功";
		} catch (Exception e) {
			result = "刪除失敗";
		}
		return result;
	}
	
	@PostMapping("/bulletinChangeLike")  //all
	public @ResponseBody void changeLike(String empNo, int postno) {
		log.info("Like方法執行中...");
		BulLike bulLN = new BulLike();
		try {
			BulLike bulLS = bulletinService.findLikeByno(empNo, postno);
			bulLN.setId(bulLS.getId());
			bulLN.setEmpNo(empNo);
			bulLN.setPostno(postno);
			if(bulLS.getLikeStatus().equals("喜歡")) {
				bulLN.setLikeStatus("null");
			}else {
				bulLN.setLikeStatus("喜歡");
			}
		}catch(Exception e){
			bulLN.setEmpNo(empNo);
			bulLN.setPostno(postno);
			bulLN.setLikeStatus("喜歡");
		}
		String result = "";
		try {
			bulletinService.changeLike(bulLN);
			result = "喜歡改變";
		} catch (Exception e) {
			result = "喜歡未改變";
		}
		System.out.println(result);
	}
	
	@PostMapping("/bulletinFindLike") //all
	public @ResponseBody BulLike findLikeByno(@RequestParam String empNo, @RequestParam int postno) {
		log.info("FindLike方法執行中...");
		try {
		BulLike bulLike = bulletinService.findLikeByno(empNo, postno);
		return bulLike;
		} catch (Exception e) {
			return null;
		}
		
	}
	
	

}
