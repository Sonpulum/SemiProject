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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.semi.dao.RecommendDao;
import com.kh.semi.dto.RecommendDto;
import com.kh.semi.vo.RecommendPaginationVO;
import com.kh.semi.vo.RecommendPaginationVO2;


@Controller
@RequestMapping("/recommend")
public class RecommendContoller {

	@Autowired
	private RecommendDao recommendDao;
	
	@GetMapping("/list")
	public String list(@ModelAttribute("vo") RecommendPaginationVO vo,
			Model model) {
		int totalCount = recommendDao.selectCount(vo);
		vo.setCount(totalCount);
		if (vo.isSearch()) {
			model.addAttribute("column",vo.getColumn());
			model.addAttribute("keyword",vo.getKeyword());
		}
		model.addAttribute("list",recommendDao.selectList(vo));
		return "/WEB-INF/views/recommend/list.jsp";
	}
	
	@GetMapping("/listTotal")
	public String listTotal(@ModelAttribute("vo") RecommendPaginationVO2 vo,
			Model model) {
		int totalCount = recommendDao.selectCount2(vo);
		vo.setCount(totalCount);
		model.addAttribute("keyword",vo.getKeyword());
		model.addAttribute("list",recommendDao.searchList(vo));
		return "/WEB-INF/views/recommend/listTotal.jsp";
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
	@GetMapping("/delete")
	public String delete(@RequestParam int recoNo) {
		recommendDao.delete(recoNo);
//		return "redirect:list";//상대경로
		return "redirect:/recommend/list";//절대경로
	}
	
	@GetMapping("/delete/{recoNo}")
	public String delete2(@PathVariable int recoNo) {
		recommendDao.delete(recoNo);
//		return "redirect:../list";//상대경로
		return "redirect:/recommend/list";//절대경로
	}
	
	@GetMapping("/detail")
	public String detail(@RequestParam int recoNo, Model model, HttpSession session) {
		String memberId = (String)session.getAttribute("memberId");
		RecommendDto recoDto = recommendDao.selectOne(recoNo);
		
		boolean owner = recoDto.getRecoWriter() != null && recoDto.getRecoWriter().equals(memberId);
		if(!owner) {
			Set<Integer> memory = (Set<Integer>)session.getAttribute("recommendMemory");
			if(memory == null) {
				memory = new HashSet<>();
			}
			
			if(!memory.contains(recoNo)) {
				recommendDao.updateReadcount(recoNo);
				recoDto.setRecoRead(recoDto.getRecoRead()+1);
				memory.add(recoNo);
			}
			session.setAttribute("recommendMemory", memory);//저장소 갱신
		}
		
		model.addAttribute("recoDto",recoDto);
		return "/WEB-INF/views/recommend/detail.jsp";
	}
	
	@GetMapping("/edit")
	public String edit(@RequestParam int recoNo, Model model) {
		RecommendDto recoDto = recommendDao.selectOne(recoNo);
		model.addAttribute("recoDto",recoDto);
		return "/WEB-INF/views/recommend/edit.jsp";
	}
	
	@PostMapping("/edit")
	public String edit(@ModelAttribute RecommendDto recommendDto,
			@RequestParam(required=false) List<Integer> attachmentNo, RedirectAttributes attr) {
		recommendDao.edit(recommendDto);
		
		
		if (attachmentNo != null) {
			for(int no : attachmentNo) {
				recommendDao.connect(recommendDto.getRecoNo(),no);
			}
		}
		attr.addAttribute("recoNo",recommendDto.getRecoNo());
		return "redirect:detail";
	}
}
