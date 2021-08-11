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
public class BulletinMagController implements Serializable {

	private static final long serialVersionUID = 1L;

	private static Logger log = LoggerFactory.getLogger(BulletinMagController.class);

	@Autowired
	BulletinService bulletinService;

	@Autowired
	ServletContext ctx;

	// 貼文管理頁
	@GetMapping("/bulletinManage")
	public String bulletinMag() {
		return "/bulletin/manage";
	}

	// 人資管理貼文列表
	// ajax傳回資料庫查詢資料(純JSON資料)
	@GetMapping("/bulletinListMag")
	public @ResponseBody List<Bulletin> findAll() {
		log.info("findAll方法執行中...");
		return bulletinService.findAll();
	}

	// 新增活動貼文頁
	@GetMapping("/bulletinEventInsert")
	public String bei() {
		return "/bulletin/eventInsert";
	}

	// 把表單裡Json資料送到資料庫新增資料(未處理檔案
//		@PostMapping("/insertEventBulletion2")
//		public @ResponseBody Map<String, String> save2(@RequestBody Bulletin bulletin) {
//			// 接JSON形式的資料 //表單綁定自動把資料轉成Member物件
//			log.info("save2方法執行中...");
	//
//			// 時間戳記
//			Timestamp ts = new Timestamp(System.currentTimeMillis());
//			bulletin.setCreateTime(ts);
	//
//			Map<String, String> map = new HashMap<>();
//			System.out.println("bulletin=" + bulletin);
//			String result = "";
//			try {
//				bulletinService.insert(bulletin);
//				result = "新增成功";
//				map.put("success", result);
//			} catch (Exception e) {
//				result = e.getMessage();
//				map.put("fail", result);
//			}
//			return map;
//		}

	// 把表單資料送到資料庫新增資料
	@PostMapping("/insertEventBulletion")
	public @ResponseBody String save(@RequestParam("title") String title,
			@RequestParam("description") String description, @RequestParam("desText") String desText,
			@RequestParam("file1") MultipartFile multipartFile, @RequestParam("quotatype") String quotatype,
			@RequestParam(value = "quota", defaultValue = "0") Integer quota, @RequestParam("postdate") Date postdate,
			@RequestParam("exp") Date exp, HttpServletRequest request)
			throws IllegalStateException, IOException, SerialException, SQLException {

		Bulletin bulletin = new Bulletin();
		log.info("save方法執行中...");

		System.out.println("file1:" + multipartFile);

		if (multipartFile == null
//				|| multipartFile.equals(
//				"org.springframework.web.multipart.support.StandardMultipartHttpServletRequest$StandardMultipartFile@df40651a")
		) {
		} else {
			// 取得原始檔名
			String fileName = multipartFile.getOriginalFilename();
			System.out.println("fileName:" + fileName);

			// 檔案上傳的路徑(io)
			String saveDirPath = request.getSession().getServletContext().getRealPath("/") + "uploadTempDir//"; // 取得??路徑＋資料夾
			File savefileDir = new File(saveDirPath);
			savefileDir.mkdirs(); // mkdirs就算路徑不存在也會建立

			// 儲存檔案至臨時資料夾
			File saveFilePath = new File(savefileDir, fileName); // 指定儲存的位置(檔案路徑, 檔案名稱)
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

				bulletin.setPicture(new SerialBlob(b)); // bulletin.setPicture(b);
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

	@PostMapping("/insertEventBulletion2")
	public @ResponseBody String save2(@RequestParam("title") String title,
			@RequestParam("description") String description, @RequestParam("desText") String desText,
			@RequestParam("quotatype") String quotatype,
			@RequestParam(value = "quota", defaultValue = "0") Integer quota, @RequestParam("postdate") Date postdate,
			@RequestParam("exp") Date exp, HttpServletRequest request)
			throws IllegalStateException, IOException, SerialException, SQLException {

		Bulletin bulletin = new Bulletin();
		log.info("save2方法執行中...");

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
			result = "新增失敗";

		}

		return result;

	}

	// 編輯貼文
	@GetMapping("/bulletinDetailMsg")
	public String findById(@RequestParam("postno") int postno, Model model) {
		Bulletin bulletin = bulletinService.findById(postno);
		model.addAttribute("bulletin", bulletin);
		return "/bulletin/detailMsg";
	}

	@GetMapping("/bulletinEditEvent")
	public String findByIdEvent(@RequestParam("postno") int postno, Model model) {
		Bulletin bulletin = bulletinService.findById(postno);
		model.addAttribute("bulletin", bulletin);
		return "/bulletin/eventEdit";
	}

	@GetMapping("/bulletinEdiAnno")
	public String findByIdAnno(@RequestParam("postno") int postno, Model model) {
		Bulletin bulletin = bulletinService.findById(postno);
		model.addAttribute("bulletin", bulletin);
		return "/bulletin/editAnno";
	}

}
