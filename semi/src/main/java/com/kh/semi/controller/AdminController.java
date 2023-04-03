package com.kh.semi.controller;

import java.util.List;

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
import com.kh.semi.dto.MemberDto;
import com.kh.semi.vo.MemberPaginationVO;

@Controller
@RequestMapping("/admin")
public class AdminController {
	
	@Autowired
	private MemberDao memberDao;
	
	//회원 목록
	@GetMapping("/member/list")
	public String memberList(Model model,
			@ModelAttribute("vo") MemberPaginationVO vo){
		int totalCount = memberDao.selectCount(vo);
		vo.setCount(totalCount);
		
		List<MemberDto> list = memberDao.selectList(vo);
		model.addAttribute("list",list);
		
		return "/WEB-INF/views/admin/member/list.jsp";
	}
	
	@GetMapping("/member/detail")
	public String memberDetail(Model model, @RequestParam String memberId) {
		MemberDto memberDto = memberDao.selectOne(memberId);
		model.addAttribute("memberDto",memberDto);
		return "/WEB-INF/views/admin/member/detail.jsp";
	}
	
	@GetMapping("/member/exit")
	public String memberExit(@RequestParam String memberId) {
		memberDao.wating(memberId);
		memberDao.delete(memberId);
		
		return "redirect:list";
	}
	
	@GetMapping("/member/edit")
	public String memberEdit(Model model, @RequestParam String memberId) {
		MemberDto memberDto = memberDao.selectOne(memberId);
		model.addAttribute("memberDto",memberDto);
		return "/WEB-INF/views/admin/member/edit.jsp";
	}
	
	@PostMapping("/member/edit")
	public String memberEdit(@ModelAttribute MemberDto memberDto,
			RedirectAttributes attr) {
		//정보변경
		attr.addAttribute("memberId",memberDto.getMemberId());
		memberDao.changeInformationByAdmin(memberDto);
		return "redirect:detail";
	}
}
