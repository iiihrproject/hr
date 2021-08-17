package com.hr.bulletin.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.Serializable;
import java.sql.Date;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

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
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.hr.bulletin.model.Bulletin;
import com.hr.bulletin.service.BulletinService;

@Controller
public class BulletinMagController implements Serializable {

	private static final long serialVersionUID = 1L;

	private static Logger log = LoggerFactory.getLogger(BulletinMagController.class);

	@Autowired
	BulletinService bulletinService;

	@Autowired
	ServletContext ctx;

	// 貼文管理頁 //h
	@GetMapping("/bulletinManage")
	public String bulletinMag() {
		return "/bulletin/manage";
	}

	// 人資管理貼文列表 //h
	@GetMapping("/bulletinListMag")
	public @ResponseBody List<Bulletin> findAll() {
		log.info("findAll方法執行中...");
		return bulletinService.findAll();
	}

	// 新增活動貼文頁 //h
	@GetMapping("/bulletinEventInsert")
	public String bei() {
		return "/bulletin/eventInsert";
	}

	// 把表單資料送到資料庫新增資料 //h
	@PostMapping("/insertEventBulletion")
	public @ResponseBody String save(@RequestParam("title") String title,
			@RequestParam("description") String description, @RequestParam("desText") String desText,
			@RequestParam(value ="file1", required=false) MultipartFile multipartFile, 
			@RequestParam("quotatype") String quotatype,
			@RequestParam(value = "quota", defaultValue = "0") Integer quota, 
			@RequestParam("postdate") Date postdate,
			@RequestParam("exp") Date exp, HttpServletRequest request)
			throws IllegalStateException, IOException, SerialException, SQLException {

		Bulletin bulletin = new Bulletin();
		log.info("save方法執行中...");

		System.out.println("file1:" + multipartFile);

		if (multipartFile == null) {
		} else {
			String fileName = multipartFile.getOriginalFilename();
			System.out.println("fileName:" + fileName);

			String saveDirPath = request.getSession().getServletContext().getRealPath("/") + "uploadTempDir//"; // 取得??路徑＋資料夾
			File savefileDir = new File(saveDirPath);
			savefileDir.mkdirs(); 

			File saveFilePath = new File(savefileDir, fileName); 
			multipartFile.transferTo(saveFilePath);
			System.out.println("saveFilePath:" + saveFilePath);

			// 存到資料庫
			if (fileName != null && fileName.length() != 0) {
				String saveFilePathStr = saveDirPath + fileName;
				bulletin.setFile1(fileName);

				FileInputStream fis1 = new FileInputStream(saveFilePathStr);
				byte[] b = new byte[fis1.available()];
				fis1.read(b);
				fis1.close();

				bulletin.setPicture(new SerialBlob(b)); 
			}
		}
		log.info("save方法執行2...");
		// 時間戳記
		Timestamp ts = new Timestamp(System.currentTimeMillis());

		bulletin.setType("活動");
		bulletin.setTitle(title);
		bulletin.setPostDate(postdate);
		bulletin.setDescription(description);
		bulletin.setDesText(desText);
		bulletin.setExp(exp);
		bulletin.setCreateTime(ts);
		bulletin.setPostStatus("normal");
		bulletin.setQuotatype(quotatype);
		bulletin.setQuota(quota);

		System.out.println("bulletin=" + bulletin);
		String result = "";
		try {
			bulletinService.insert(bulletin);
			result = "新增成功";

		} catch (Exception e) {
			result = e.getMessage();

		}
		return result;

	}


	// 編輯貼文頁 //h
	@GetMapping("/bulletinDetailMsg")
	public String findById(@RequestParam("postno") int postno, Model model) {
		Bulletin bulletin = bulletinService.findById(postno);
		model.addAttribute("bulletin", bulletin);
		return "/bulletin/detailMsg";
	}



}