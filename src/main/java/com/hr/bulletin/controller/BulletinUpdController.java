package com.hr.bulletin.controller;

import org.springframework.stereotype.Controller;
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
public class BulletinUpdController implements Serializable {

	private static final long serialVersionUID = 1L;

	private static Logger log = LoggerFactory.getLogger(BulletinUpdController.class);

	@Autowired
	BulletinService bulletinService;

	@Autowired
	ServletContext ctx;

	// 修改活動貼文頁 //h
	@GetMapping("/bulletinEditEventPage")  //h
	public String findByIdEvent(@RequestParam("postno") int postno, Model model) {
		Bulletin bulletin = bulletinService.findById(postno);
		model.addAttribute("bulletin", bulletin);
		return "/bulletin/eventEdit";
	}

	// 修改公告貼文頁 //h
	@GetMapping("/bulletinEdiAnnoPage")
	public String findByIdAnno(@RequestParam("postno") int postno, Model model) {
		Bulletin bulletin = bulletinService.findById(postno);
		model.addAttribute("bulletin", bulletin);
		return "/bulletin/editAnno";
	}

	// 修改活動貼文(原圖) //h
	@PostMapping("/bulletin/EditEventop")
	public @ResponseBody String updateEventOp(Bulletin bulletin) {
		log.info("updateop方法執行中...");
		String result = "";
		try {
			bulletinService.updateop(bulletin);
			result = "修改成功";
		} catch (Exception e) {
			result = "修改失敗";
		}
		return result;
	}

	// 修改活動貼文(改圖) //h
	@PostMapping("/bulletin/EditEvent")
	public @ResponseBody String save(
			@RequestParam("postno") int postno,
			@RequestParam("title") String title,
			@RequestParam("description") String description, 
			@RequestParam("desText") String desText,
			@RequestParam(value = "file1", required = false) MultipartFile multipartFile,
			@RequestParam("quotatype") String quotatype,
			@RequestParam(value = "quota", defaultValue = "0") Integer quota, 
			@RequestParam("endDate") Date endDate,
			@RequestParam("postDate") Date postdate,
			@RequestParam("exp") Date exp, 
			HttpServletRequest request)
			throws IllegalStateException, IOException, SerialException, SQLException {

		Bulletin bulletin = new Bulletin();
		log.info("update方法執行中...");


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
		log.info("update方法執行2...");

		bulletin.setPostno(postno);
		bulletin.setTitle(title);
		bulletin.setEndDate(endDate);
		bulletin.setPostDate(postdate);
		bulletin.setDescription(description);
		bulletin.setDesText(desText);
		bulletin.setExp(exp);
		bulletin.setQuotatype(quotatype);
		bulletin.setQuota(quota);

		String result = "";
		try {
			bulletinService.update(bulletin);
			result = "修改成功";
			System.out.println("result1:"+result);

		} catch (Exception e) {
			result = e.getMessage();
			System.out.println("result2:"+result);

		}
		return result;

	}
	
	//刪除活動貼文頁 //h
	@GetMapping("/bulletin/DelEventPage")
	public @ResponseBody String delEvent(@RequestParam("postno") int postno) {
		log.info("delEvent方法執行中...");
		String result = "";
		try {
			bulletinService.delete(postno);
			result = "刪除成功";
		} catch (Exception e) {
			result = "刪除失敗";
		}
		return result;
	}

	// 刪除公告貼文頁 //h
	@GetMapping("/bulletin/DelAnnoPage")
	public @ResponseBody String delAnno(Bulletin bulletin) {
		log.info("updateop方法執行中...");
		System.out.println("bulletin=" + bulletin);
		String result = "";
		try {
			bulletinService.updateop(bulletin);
			result = "刪除成功";
		} catch (Exception e) {
			result = "刪除失敗";
		}
		return result;
	}



}
