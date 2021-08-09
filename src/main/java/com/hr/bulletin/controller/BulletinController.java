package com.hr.bulletin.controller;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Blob;
import java.sql.Date;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Base64;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.sql.rowset.serial.SerialBlob;
import javax.sql.rowset.serial.SerialException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.CacheControl;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
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
import com.hr.login.controller.LoginController;

@Controller
public class BulletinController {

	private static Logger log = LoggerFactory.getLogger(LoginController.class);

	@Autowired
	BulletinService bulletinService;
	
	@Autowired
	ServletContext ctx;
	

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

	// 把表單裡Json資料送到資料庫新增資料
//	@PostMapping("/insertBulletion")
//	public @ResponseBody Map<String, String> save(@RequestBody Bulletin bulletin) {
//		// 接JSON形式的資料 //表單綁定自動把資料轉成Member物件
//		log.info("save方法執行中...");
//
//		// 時間戳記
//		Timestamp ts = new Timestamp(System.currentTimeMillis());
//		bulletin.setCreateTime(ts);
//
//		Map<String, String> map = new HashMap<>();
//		System.out.println("bulletin=" + bulletin);
//		String result = "";
//		try {
//			bulletinService.insert(bulletin);
//			result = "新增成功";
//			map.put("success", result);
//		} catch (Exception e) {
//			result = e.getMessage();
//			map.put("fail", result);
//		}
//		return map;
//	}
	
	// 把表單資料送到資料庫新增資料
		@PostMapping("/insertEventBulletion")
		public  @ResponseBody Map<String, String> save(
				@RequestParam("title")String title, 
				@RequestParam("description")String description, 
				@RequestParam("file1") MultipartFile multipartFile, 
				@RequestParam("quotatype")String quotatype, 
				@RequestParam(value="quota",defaultValue="0")Integer quota, 
				@RequestParam("postdate")Date postdate, 
				@RequestParam("exp")Date exp, 
				HttpServletRequest request) 
				throws IllegalStateException, IOException, SerialException, SQLException {
				Bulletin bulletin = new Bulletin();
				log.info("save方法執行中...");
				
				System.out.println("file1:"+multipartFile);

				if(multipartFile.equals("org.springframework.web.multipart.support.StandardMultipartHttpServletRequest$StandardMultipartFile@df40651a")) {
				}else {
				String fileName = multipartFile.getOriginalFilename();
				System.out.println("fileName:" + fileName);
				
				//檔案路徑(io) 
				String saveDirPath = request.getSession().getServletContext().getRealPath("/") + "uploadTempDir//";  //取得??路徑＋資料夾
				File savefileDir = new File(saveDirPath);
				savefileDir.mkdirs();
				
				File saveFilePath = new File(savefileDir, fileName); //(檔案路徑, 檔案名稱)
				multipartFile.transferTo(saveFilePath);
				System.out.println("saveFilePath:" + saveFilePath);
				
				if(fileName!=null && fileName.length()!=0) {
					String saveFilePathStr = saveDirPath + fileName;
					bulletin.setFile1(fileName);
					
					FileInputStream fis1 = new FileInputStream(saveFilePathStr);
					byte[] b = new byte[fis1.available()];
					fis1.read(b);
					fis1.close();
					
					bulletin.setPicture(b);
					//bulletin.setPicture(new SerialBlob(b));
				}
				}
				log.info("save方法執行2...");
				//時間戳記
				Timestamp ts = new Timestamp(System.currentTimeMillis());
				
				//Bulletin resultIns = new Bulletin();
				bulletin.setType("活動");
				bulletin.setTitle(title);
				bulletin.setPostDate(postdate);
				bulletin.setDescription(description);
				bulletin.setExp(exp);
				bulletin.setCreateTime(ts);
				bulletin.setPostStatus("normal");
				bulletin.setQuotatype(quotatype);
				bulletin.setQuota(quota);
				
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
	
	//讀圖
//	@GetMapping("/bulletin/getImage")
//	public ResponseEntity<byte[]> getImage(@RequestParam("postno") Integer no) {
//		log.info("getImage方法執行中...");
//		ResponseEntity<byte[]> re = null;
//		Bulletin bulletin = bulletinService.findById(no);  //跟service要bean
//		String filename = bulletin.getFile1();
//		Blob blob = bulletin.getPicture();
//		String mimeType = ctx.getMimeType(filename);  //Spring框架有準備ServletContext物件可以使用
//		MediaType mediaType = MediaType.valueOf(mimeType);
//		HttpHeaders headers = new HttpHeaders();
//		try {
//			ByteArrayOutputStream baos = new ByteArrayOutputStream();
//			InputStream is = blob.getBinaryStream();
//			byte[] b = new byte[81920];
//			int len = 0;
//			while ((len = is.read(b)) != -1) {
//				baos.write(b, 0, len);
//			}
//			headers.setContentType(mediaType);
//			headers.setCacheControl(CacheControl.noCache().getHeaderValue()); //叫瀏覽器不要cache這張圖片
//			re = new ResponseEntity<byte[]>(baos.toByteArray(), headers, HttpStatus.OK);
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		return re;
//	}
	

}
