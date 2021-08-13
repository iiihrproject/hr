package com.hr.bulletin.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.Serializable;
import java.sql.Date;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.List;


import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.sql.rowset.serial.SerialBlob;
import javax.sql.rowset.serial.SerialException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.hr.bulletin.model.Bulletin;
import com.hr.bulletin.service.BulletinService;

@Controller
public class BulletinController implements Serializable {

	private static final long serialVersionUID = 1L;

	private static Logger log = LoggerFactory.getLogger(BulletinController.class);

	@Autowired
	BulletinService bulletinService;

	@Autowired
	ServletContext ctx;

	// 首頁貼文列表
	@GetMapping("/bulletinList")
	public @ResponseBody List<Bulletin> findAllPosting() {
		log.info("findAllPosting方法執行中...");
		return bulletinService.findAllPosting();
	}

	

	// 使用者瀏覽貼文內容
	@GetMapping("/bulletinDetail")
	public String findById(@RequestParam("postno") int postno, Model model) {
		Bulletin bulletin = bulletinService.findById(postno);
		model.addAttribute("bulletin", bulletin);
		return "/bulletin/detail";
	}

	

	
	

}
