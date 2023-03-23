package com.kh.semi.controller;

import java.util.List;

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

import com.kh.semi.dao.ReviewDao;
import com.kh.semi.dto.ReviewDto;
import com.kh.semi.vo.ReviewPaginationVO;

@Controller
@RequestMapping("/review")
public class ReviewController {
	
	@Autowired ReviewDao reviewDao;
	
	//후기 게시판 목록
	@GetMapping("/list")
	public String list(@ModelAttribute("vo") ReviewPaginationVO vo,
			Model model) {
		//게시글 개수(목록/검색이 다름)
		int totalCount = reviewDao.selectCount(vo);
		vo.setCount(totalCount);
		
		
		//게시글
		List<ReviewDto> list = reviewDao.selectList(vo);
		model.addAttribute("list", list);
		
		return "/WEB-INF/views/review/list.jsp";
	}

	//후기 게시판 등록
	@GetMapping("/write")
	public String write() {
		return "/WEB-INF/views/review/write.jsp";
	}
	
	@PostMapping("/write")
	public String write(
			@ModelAttribute ReviewDto reviewDto,
			HttpSession session, RedirectAttributes attr
			) {
		
		String memberId = (String)session.getAttribute("memberId");
		int reviewNo = reviewDao.sequence();
		
		reviewDto.setReviewNo(reviewNo);
		reviewDto.setReviewWriter(memberId);
		
		reviewDao.insert(reviewDto);
		
		//attr.addAttribute("reviewNo", reviewNo);
		return "redirect:list";
	}
	
	//후기 게시판 수정
	@GetMapping("/edit")
	public String edit(
			@RequestParam int reviewNo,
			Model model) {
		model.addAttribute("reviewDto", reviewDao.selectOne(reviewNo));
		return "/WEB-INF/views/review/edit.jsp";
	}
	
	@PostMapping("/edit")
	public String edit(
			@ModelAttribute ReviewDto reviewDto,
			RedirectAttributes attr) {
		reviewDao.update(reviewDto);
		attr.addAttribute("reviewNo", reviewDto.getReviewNo());
		return "redirect:detail";
	}
	
	//후기 게시판 삭제
	@GetMapping("/delete")
	public String delete(@RequestParam int reviewNo) {
		reviewDao.delete(reviewNo);
		return "redirect:datail";
	}
	
	//후기 게시판 삭제 - 경로 변수 방식
	@GetMapping("/delete/{reviewNo}")
	public String delete2(@PathVariable int reviewNo) {
		reviewDao.delete(reviewNo);
		return "redirect:../list"; //상대경로
	}
	
}