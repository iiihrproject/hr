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

import com.hr.bulletin.model.Bulletin;
import com.hr.bulletin.service.BulletinService;
import com.hr.login.controller.LoginController;

@Controller
public class BulletinController {

	private static Logger log = LoggerFactory.getLogger(LoginController.class);

	@Autowired
	BulletinService bulletinService;

	// 貼文管理
	@GetMapping("/bulletinManage")
	public String bulletinMag() {
		return "/bulletin/manage";
	}

	// 首頁貼文列表
	// ajax傳回資料庫查詢資料(純JSON資料)
	@GetMapping("/bulletinList")
	public @ResponseBody List<Bulletin> findAllPosting() {
		log.info("findAllPosting方法執行中...");
		return bulletinService.findAllPosting();
	}
	
	// 人資管理貼文列表
	// ajax傳回資料庫查詢資料(純JSON資料)
	@GetMapping("/bulletinListMag")
	public @ResponseBody List<Bulletin> findAll() {
		log.info("findAll方法執行中...");
		return bulletinService.findAll();
	}

	// 使用者瀏覽貼文內容
	@GetMapping("/bulletinDetail")
	public String findById(@RequestParam("postno") int postno, Model model) {
		Bulletin bulletin = bulletinService.findById(postno);
		model.addAttribute("bulletin", bulletin);
		return "/bulletin/detail";
	}

	// 新增活動貼文頁
	@GetMapping("/bulletinEventInsert")
	public String bei() {
		return "/bulletin/eventInsert";
	}

	// 把表單裡的資料送到資料庫新增資料
	@PostMapping("/insertBulletion")
	public @ResponseBody Map<String, String> save(@RequestBody Bulletin bulletin) {
		// 接JSON形式的資料 //表單綁定自動把資料轉成Member物件
		log.info("save方法執行中...");

		// 時間戳記
		Timestamp ts = new Timestamp(System.currentTimeMillis());
		bulletin.setCreateTime(ts);

		Map<String, String> map = new HashMap<>();
		System.out.println("bulletin=" + bulletin);
		String result = "";
		try {
			bulletinService.insert(bulletin);
			result = "新增成功";
			map.put("success", result);
		} catch (Exception e) {
			result = e.getMessage();
			map.put("fail", result);
		}
		return map;
	}

}
