package com.hr.bulletin.controller;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Blob;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Base64;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletContext;
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
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hr.bulletin.model.Bulletin;
import com.hr.bulletin.service.BulletinService;

@Controller
public class BulletinfileController {

	private static Logger log = LoggerFactory.getLogger(BulletinController.class);

	@Autowired
	BulletinService bulletinService;

	@Autowired
	ServletContext ctx;

	// 把表單資料送到資料庫新增資料
	// @PostMapping("/insertEventBulletion")
	public @ResponseBody Map<String, String> save(@RequestBody Bulletin bulletin)
			throws IllegalStateException, IOException, SerialException, SQLException {
		log.info("save方法執行中...");

		int startIndex = "data:".length();
		int endIndex = bulletin.getFile1().indexOf(";");
		String mimeType = bulletin.getFile1().substring(startIndex, endIndex);
		String base64 = bulletin.getFile1().substring(bulletin.getFile1().indexOf(",") + 1);

		byte[] a = Base64.getDecoder().decode(base64);

		bulletin.setPicture(new SerialBlob(a));
//		bulletin.setPicture(a);

		log.info("save方法執行2...");
		// 時間戳記
		Timestamp ts = new Timestamp(System.currentTimeMillis());
		bulletin.setCreateTime(ts);

//				bulletin.setType("活動");
//				bulletin.setTitle(title);
//				bulletin.setPostDate(postdate);
//				bulletin.setDescription(description);
//				bulletin.setExp(exp);
//				bulletin.setCreateTime(ts);
//				bulletin.setPostStatus("normal");
//				bulletin.setQuotatype(quotatype);
//				bulletin.setQuota(quota);

		bulletinService.insert(bulletin);

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

	// 讀圖byte
//	@GetMapping("/bulletin/getImage")
//	public ResponseEntity<byte[]> getImage(@RequestParam("postno") Integer no) {
//		log.info("getImage方法執行中...");
//
//		ResponseEntity<byte[]> re = null;
//		Bulletin bulletin = bulletinService.findById(no); // 跟service要bean
//		String filename = bulletin.getFile1();
//		byte[] blob = bulletin.getPicture();
//		String mimeType = ctx.getMimeType(filename); // Spring框架有準備ServletContext物件可以使用
//		MediaType mediaType = MediaType.valueOf(mimeType);
//		HttpHeaders headers = new HttpHeaders();
//		try {
//			ByteArrayOutputStream baos = new ByteArrayOutputStream();
//			InputStream is = blob.getBinaryStream();
//			byte[] b = new byte[81920];
//			int len = 0;
//			while ((len = is.read(b)) != -1) {
//				baos.write(b, 0, len);
////			}
//			headers.setContentType(mediaType);
//			headers.setCacheControl(CacheControl.noCache().getHeaderValue()); // 叫瀏覽器不要cache這張圖片
//			re = new ResponseEntity<byte[]>(baos.toByteArray(), headers, HttpStatus.OK);
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		System.out.println(re);
//		return re;
//	}

	// 讀圖
	@GetMapping("/bulletin/getImage")
	public ResponseEntity<byte[]> getImage(@RequestParam("postno") Integer no) {
		log.info("getImage方法執行中...");

		ResponseEntity<byte[]> re = null;
		Bulletin bulletin = bulletinService.findById(no); // 跟service要bean
		String filename = bulletin.getFile1();
		Blob blob = bulletin.getPicture();
		String mimeType = ctx.getMimeType(filename); // Spring框架有準備ServletContext物件可以使用
		MediaType mediaType = MediaType.valueOf(mimeType);
		HttpHeaders headers = new HttpHeaders();
		try {
			ByteArrayOutputStream baos = new ByteArrayOutputStream();
			InputStream is = blob.getBinaryStream();
			byte[] b = new byte[81920];
			int len = 0;
			while ((len = is.read(b)) != -1) {
				baos.write(b, 0, len);
			}
			headers.setContentType(mediaType);
			headers.setCacheControl(CacheControl.noCache().getHeaderValue()); // 叫瀏覽器不要cache這張圖片
			re = new ResponseEntity<byte[]>(baos.toByteArray(), headers, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return re;
	}

}