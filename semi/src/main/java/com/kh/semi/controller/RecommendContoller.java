package com.kh.semi.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.semi.dao.RecommendDao;
import com.kh.semi.dto.RecommendDto;

@Controller
@RequestMapping("/recommend")
public class RecommendContoller {

	@Autowired
	private RecommendDao recommendDao;
	
	@GetMapping("/write")
	public String write() {
		return "/WEB-INF/views/recommend/write.jsp";
	}
	
	@PostMapping("/write")
	public String write(@ModelAttribute RecommendDto recommendDto,
			HttpSession session) {
		String memberId = (String)session.getAttribute("memberId");
		int recoNo = recommendDao.sequence();
		recommendDto.setRecoNo(recoNo);
		recommendDto.setRecoWriter(memberId);
		recommendDao.insert(recommendDto);
		return "redirect:writeFinish";
	}
	
	@GetMapping("/writeFinish")
	public String wirteFinish() {
		return "/WEB-INF/views/recommend/writeFinish.jsp";
	}
	
	@GetMapping("detail")
	public String detail(@RequestParam int recoNo, Model model) {
		RecommendDto recommendDto = recommendDao.selectOne(recoNo);
		return "/WEB-INF/views/recommend/detail.jsp";
	}
}
