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

import com.kh.semi.dao.MemberDao;
import com.kh.semi.dao.MemberProfileDao;
import com.kh.semi.dao.ReviewDao;
import com.kh.semi.dto.MemberProfileDto;
import com.kh.semi.dto.ReviewDto;
import com.kh.semi.service.ReviewService;
import com.kh.semi.vo.ReviewPaginationVO;
import com.kh.semi.vo.ReviewPaginationVO2;

@Controller
@RequestMapping("/review")
public class ReviewController {
	
	@Autowired 
	private ReviewDao reviewDao;
	
	@Autowired 
	private ReviewService reviewService;
	
	@Autowired
	private MemberProfileDao memberProfileDao;
	
	@Autowired
	private MemberDao memberDao;
	

	//게시글 목록
	@GetMapping("/list")
	public String list(@ModelAttribute("vo") ReviewPaginationVO vo,
	        @RequestParam(required = false, defaultValue = "latest") String sort,
	        Model model) {
	    //정렬 조건을 VO 객체에 설정
	    vo.setSort(sort);

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
	
	//게시글 통합 검색
	@GetMapping("/listTotal")
	public String listTotal(@ModelAttribute("vo") ReviewPaginationVO2 vo,
			Model model) {
		int totalCount = reviewDao.selectCount2(vo);
		vo.setCount(totalCount);
		model.addAttribute("list",reviewDao.searchList(vo));
		return "/WEB-INF/views/review/listTotal.jsp";
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
		
	    String reviewWriter = reviewDto.getReviewWriter();
		MemberProfileDto memberProfile = memberProfileDao.selectOne(reviewWriter);
		String memberNick = memberDao.selectOne(reviewWriter).getMemberNick();
		
		model.addAttribute("memberNick",memberNick);
		model.addAttribute("memberProfile", memberProfile);
		
		return "/WEB-INF/views/review/detail.jsp";
	}
	
	
	//게시글 등록
	@GetMapping("/write")
	public String write() {
		return "/WEB-INF/views/review/write.jsp";
	}
	
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
