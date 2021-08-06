package com.hr;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class BaseController {
	
	@GetMapping({"/index","/"})
	public String index() {
		return "index";
	}
	
	@GetMapping("/pages")
	public String pages() {
		return "pages";
	}
	
	
	
}
