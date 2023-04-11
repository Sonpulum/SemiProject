package com.kh.semi.controller;

import java.text.SimpleDateFormat;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.semi.dao.RecommendDao;
import com.kh.semi.dao.ReviewDao;

@Controller
public class HomeController {
	
	@Autowired
	private RecommendDao recommendDao;
	
	@Autowired
	private ReviewDao reviewDao;	
	
	@GetMapping("/")
	public String home(Model model) {
		java.util.Date now = new java.util.Date();
		SimpleDateFormat f = new SimpleDateFormat("M월");
		String nowStr = f.format(now);
		model.addAttribute("now",nowStr);
		//인기 게시글 조회
		model.addAttribute("reviewTop",reviewDao.selectTopList(6));
		model.addAttribute("recoTop", recommendDao.selectTopList(6));
		
		return "/WEB-INF/views/home.jsp";
	}
	
	@PostMapping("/search")
	public String search(@RequestParam String keyword, Model model) {
		model.addAttribute("keyword",keyword);
		model.addAttribute("recoList",recommendDao.searchList(keyword));
		model.addAttribute("reviewList",reviewDao.searchList(keyword));
		return "/WEB-INF/views/search.jsp";
	}
}
