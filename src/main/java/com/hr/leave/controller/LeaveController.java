package com.hr.leave.controller;

import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.sql.Blob;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.CacheControl;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.hr.leave.model.LeaveBean;
import com.hr.leave.service.LeaveService;
import com.hr.login.model.LoginModel;

@Controller
@RequestMapping("/Leave")
@SessionAttributes("loginModel")
public class LeaveController {
	@Autowired
	private LeaveService service;
	
	@Autowired
	ServletContext context;
	
	//	@DeleteMapping("/leave/{applicationNo}")
//	public String deleteOne(@RequestParam("applicationNo") String applicationNo) {
//		service.delete(applicationNo);
//		return "redirect:/LeavaApplication/GetList";
//	}
	
//  頁面到請假申請
	@GetMapping("/")
	public String toLeaveApplication(Model m) {
		m.addAttribute("body", "leave/ApplyList.jsp");
		return "layout/Template";
	}
//	頁面到查詢詳情
	@GetMapping("/LeaveResult")
	public String InsertLeaveResult(Model model) {
		model.addAttribute("body", "leave/LeaveResult.jsp");
		return "layout/Template";
	}
	
//	頁面到個人查詢詳情
	@GetMapping("/MyLeaveApply")
	public String MyLeaveApply(Model model) {
		model.addAttribute("body", "leave/MyLeaveApply.jsp");
		return "layout/Template";
	}
	
//	查詢所有請假紀錄
	@GetMapping("/findAllLeave")
	public @ResponseBody List<LeaveBean> findAllLeave() {
		return service.findAllLeave();
	}
	
//	查詢部門的請假紀錄
	@GetMapping("/findLeaveByDeptNo")
	public @ResponseBody List<LeaveBean> findLeaveByDeptNo(@RequestParam("departmentNumber") Integer departmentNumber) {
		return service.findLeaveByDeptNo(departmentNumber);
	}
	
//	查詢本人的請假紀錄
	@GetMapping("/findLeaveByEmpNo")
	public @ResponseBody List<LeaveBean> findLeaveByEmpNo(@ModelAttribute("loginModel") LoginModel loginModel) {
		return service.findLeaveByEmpNo(loginModel.getEmpNo());
	}

//	查詢今年度用申請的特休數
	@GetMapping("/findAnnualLTook")
	public @ResponseBody float findAnnualLTook(@ModelAttribute("loginModel") LoginModel loginModel,
												@RequestParam("preAnnivD") String preAnnivD) {
		return service.findAnnualLTook(loginModel.getEmpNo(),preAnnivD);
	}
	
//	新增請假
	@PostMapping("/Insert")
	public @ResponseBody Map<String, String> save(@RequestBody LeaveBean leave,LoginModel loginModel) {
		Map<String, String> map = new HashMap<>();
		String result = "";
		try {
			service.save(leave,loginModel);
			result = "新增成功";
			map.put("success", result);
		} catch (Exception e) {
			e.printStackTrace();
			result = e.getMessage();
			map.put("fail", result);
		}
		return map;
	}

//	調出該申請單號資料
	@GetMapping("/findLeaveByAppNo")
	public @ResponseBody LeaveBean findLeaveByAppNo(@RequestParam("applicationNo") String applicationNo) {
		return service.findLeaveByAppNo(applicationNo);
	}
	
//	更新主管簽呈資訊
	@PutMapping("/updateSupervisorComment/{applicationNo}")
	public @ResponseBody Map<String, String> updateSupervisorComment(@RequestBody LeaveBean leaveBean,
			@PathVariable("applicationNo") String applicationNo) {
		Map<String, String> map = new HashMap<>();
		String result = "";
		try {
			service.updateSupervisorComment(applicationNo, leaveBean.getApproval01Sig(), leaveBean.getApproval01MGR(),
					leaveBean.getStatusList().getCode());
			result = "簽核完成";
			map.put("success", result);
		} catch (Exception e) {
			e.printStackTrace();
			result = e.getMessage();
			map.put("fail", result);
		}
		return map;
	}

	
	
	@GetMapping("/crm/picture/{appNo}")
	public ResponseEntity<byte[]> getPicture(@PathVariable("appNo") String appNo) {
		byte[] body = null;
		ResponseEntity<byte[]> re = null;
		MediaType mediaType = null;
		HttpHeaders headers = new HttpHeaders();
		headers.setCacheControl(CacheControl.noCache().getHeaderValue());

		LeaveBean leave = service.findLeaveByAppNo(appNo);
		if (leave == null) {
			return new ResponseEntity<byte[]>(HttpStatus.NOT_FOUND);
		}
		String filename = leave.getFileName();
		if (filename != null) {
			if (filename.toLowerCase().endsWith("jfif")) {
				mediaType = MediaType.valueOf(context.getMimeType("dummy.jpeg"));
			} else {
				mediaType = MediaType.valueOf(context.getMimeType(filename));
				headers.setContentType(mediaType);
			}
		}
		Blob blob = leave.getSupportingDoc();
		if (blob != null) {
			body = blobToByteArray(blob);
		} else {
			String path = "img/noFile.jpg";
			
			body = fileToByteArray(path);
		}
		re = new ResponseEntity<byte[]>(body, headers, HttpStatus.OK);

		return re;
	}
	
//	憲春老師的範例
	private byte[] fileToByteArray(String path) {
		byte[] result = null;
		try (InputStream is = context.getResourceAsStream(path);
				ByteArrayOutputStream baos = new ByteArrayOutputStream();) {
			byte[] b = new byte[819200];
			int len = 0;
			while ((len = is.read(b)) != -1) {
				baos.write(b, 0, len);
			}
			result = baos.toByteArray();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
//	憲春老師的範例
	public byte[] blobToByteArray(Blob blob) {
		byte[] result = null;
		try (InputStream is = blob.getBinaryStream(); ByteArrayOutputStream baos = new ByteArrayOutputStream();) {
			byte[] b = new byte[819200];
			int len = 0;
			while ((len = is.read(b)) != -1) {
				baos.write(b, 0, len);
			}
			result = baos.toByteArray();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;

	}
}
