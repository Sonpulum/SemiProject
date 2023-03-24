package com.kh.semi.controller;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.semi.dao.RecommendDao;
import com.kh.semi.dto.RecommendDto;


@Controller
@RequestMapping("/recommend")
public class RecommendContoller {

	@Autowired
	private RecommendDao recommendDao;
	
//	목록 및 검색
	@GetMapping("/list")
	public String list(Model model, 
			@RequestParam(required = false, defaultValue = "boardTitle") String column, 
			@RequestParam(required = false, defaultValue = "") String keyword) {

		model.addAttribute("list", recommendDao.selectList());
		return "/WEB-INF/views/recommend/list.jsp";
	}
	
	@GetMapping("/write")
	public String write() {
		return "/WEB-INF/views/recommend/write.jsp";
	}
	
	@PostMapping("/write")
	public String write(@ModelAttribute RecommendDto recommendDto,
			HttpSession session, @RequestParam(required=false) List<Integer> attachmentNo,
			RedirectAttributes attr) {
		String memberId = (String)session.getAttribute("memberId");
		int recoNo = recommendDao.sequence();
		recommendDto.setRecoNo(recoNo);
		recommendDto.setRecoWriter(memberId);
		recommendDao.insert(recommendDto);
		
		if (attachmentNo != null) {
			for(int no : attachmentNo) {
				recommendDao.connect(recoNo,no);
			}
		}
		
		attr.addAttribute("recoNo",recoNo);
		return "redirect:detail";
	}
	
	@GetMapping("/detail")
	public String detail(@RequestParam int recoNo, Model model, HttpSession session) {
		String memberId = (String)session.getAttribute("memberId");
		RecommendDto recoDto = recommendDao.selectOne(recoNo);
		
		boolean owner = recoDto.getRecoWriter() != null && recoDto.getRecoWriter().equals(memberId);
		if(!owner) {
			Set<Integer> memory = (Set<Integer>)session.getAttribute("memory");
			if(memory == null) {
				memory = new HashSet<>();
			}
			
			if(!memory.contains(recoNo)) {//읽은 적이 없는가(기억에 없는가)
				recommendDao.updateReadcount(recoNo);
				recoDto.setRecoRead(recoDto.getRecoRead()+1); //DTO 조회수 1증가
				memory.add(recoNo);//저장소에 추가(기억에 추가)
			}
			//System.out.println("memory = " + memory);
			session.setAttribute("memory", memory);//저장소 갱신
		}
		
		model.addAttribute("recoDto",recoDto);
		return "/WEB-INF/views/recommend/detail.jsp";
	}
}
