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

import com.kh.semi.dao.ReviewDao;
import com.kh.semi.dto.ReviewDto;
import com.kh.semi.service.ReviewService;
import com.kh.semi.vo.ReviewPaginationVO;

@Controller
@RequestMapping("/review")
public class ReviewController {
	
	@Autowired ReviewDao reviewDao;
	
	@Autowired ReviewService reviewService;
	
	//게시글 목록
	@GetMapping("/list")
	public String list(@ModelAttribute("vo") ReviewPaginationVO vo,
			Model model) {
		//게시글 개수(목록/검색이 다름)
		int totalCount = reviewDao.selectCount(vo);
		vo.setCount(totalCount);
		
		//인기 게시글 조회
		model.addAttribute("topList",reviewDao.selectTopList(3));
		
		//게시글
		List<ReviewDto> list = reviewDao.selectList(vo);
		model.addAttribute("list", list);
		
		return "/WEB-INF/views/review/list.jsp";
	}
	
	//게시글 상세
	@GetMapping("/detail")
	public String detail(
			Model model,
			@RequestParam int reviewNo,
			HttpSession session) {
		
		//사용자가 작성자인지 판단
		ReviewDto reviewDto = reviewDao.selectOne(reviewNo);
		String memberId = (String) session.getAttribute("memberId");
		
		boolean owner = reviewDto.getReviewWriter() != null
				&& reviewDto.getReviewWriter().equals(memberId);
		model.addAttribute("owner", owner);
		
		//사용자가 관리자인지 판정
		String memberLevel = (String) session.getAttribute("memberLevel");
		boolean admin = memberLevel != null && memberLevel.equals("관리자");
		model.addAttribute("admin", admin);
		
		//조회수 증가
		if(!owner) {
			
			Set<Integer> reviewMemory = (Set<Integer>) session.getAttribute("reviewMemory");
			
			if(reviewMemory == null) {
				reviewMemory = new HashSet<>();
			}
			
			if(!reviewMemory.contains(reviewNo)) {
				reviewDao.updateReadCount(reviewNo);
				reviewDto.setReviewRead(reviewDto.getReviewRead() + 1);
				reviewMemory.add(reviewNo);
			}
			session.setAttribute("reviewMemory", reviewMemory);
		}
		model.addAttribute("reviewDto",reviewDto);
		return "/WEB-INF/views/review/detail.jsp";
	}
	
	
	//게시글 등록
	@GetMapping("/write")
	public String write() {
		return "/WEB-INF/views/review/write.jsp";
	}
	
//	@PostMapping("/write")
//	public String write(@ModelAttribute ReviewDto reviewDto,
//			HttpSession session) {
//		String memberId = (String)session.getAttribute("memberId");
//		int reviewNo = reviewDao.sequence();
//		reviewDto.setReviewNo(reviewNo);
//		reviewDto.setReviewWriter(memberId);
//		reviewDao.insert(reviewDto);
//		return "redirect:detail";
//	}
	
	@PostMapping("/write")
	public String write(@ModelAttribute ReviewDto reviewDto,
			HttpSession session, @RequestParam(required = false) List<Integer> attachmentNo,
			RedirectAttributes attr) {
		String memberId = (String)session.getAttribute("memberId");
		reviewDto.setReviewWriter(memberId);
		
		int reviewNo = reviewService.write(reviewDto, attachmentNo);
		
		//상세페이지로 redirect
		attr.addAttribute("reviewNo", reviewNo);
		
		return "redirect:detail";
	}
	
	
	//게시글 수정
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
	
	//게시글 삭제
	@GetMapping("/delete")
	public String delete(@RequestParam int reviewNo) {
		reviewDao.delete(reviewNo);
		return "redirect:list";
	}
	
	
}
