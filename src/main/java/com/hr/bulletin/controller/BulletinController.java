package com.hr.bulletin.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.Serializable;
import java.sql.Date;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.sql.rowset.serial.SerialBlob;
import javax.sql.rowset.serial.SerialException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;

import com.hr.bulletin.model.Bulletin;
import com.hr.bulletin.service.BulletinService;
import com.hr.login.model.Authorities;
import com.hr.login.model.LoginModel;
import com.hr.login.service.LoginService;

@Controller
@SessionAttributes("loginModel")
public class BulletinController implements Serializable {

	private static final long serialVersionUID = 1L;

	private static Logger log = LoggerFactory.getLogger(BulletinController.class);

	@Autowired
	BulletinService bulletinService;

	@Autowired
	ServletContext ctx;
	
	@Autowired
	private LoginService loginService;
	

	// 首頁貼文列表 //all
	@GetMapping("/bulletinList") 
	public @ResponseBody List<Bulletin> findAllPosting() {
		log.info("findAllPosting方法執行中...");
		return bulletinService.findAllPosting();
	}

	// 使用者瀏覽貼文內容 //all
	@GetMapping("/bulletinDetail")
	public String findById(@RequestParam("postno") int postno, Model model) {
		Bulletin bulletin = bulletinService.findById(postno);
		model.addAttribute("bulletin", bulletin);
		return "/bulletin/detail";
	}
	
	// 使用者瀏覽我的公布欄頁 //all
	@GetMapping("/myBulletin")
	public String myBulletin() {
		return "/bulletin/myBulletin";
	}
	
	//判斷權限
	@GetMapping("/bulButton") //all
	public @ResponseBody Boolean bulutton(@RequestParam("empno") String empNo) {
		log.info("bulutton方法執行中...");
		LoginModel loginModel = loginService.getLoginModelByEmpNo(empNo);
		
		Set<Authorities> set = loginModel.getAuthorities();
		Iterator<Authorities> iterator = set.iterator();
		boolean check = false;
		while(iterator.hasNext()){
		    String s = iterator.next().getAuthorityName();
		    if(s.equals("ROLE_HR")) {
		    	check = true;
		    }
		}
		return check;
	}
	

}
