package com.kh.semi.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.stereotype.Controller;

@Controller
public class HomeController {
	@GetMapping("/")
	public String home() {
		return "/WEB-INF/views/home.jsp";
	}
}
