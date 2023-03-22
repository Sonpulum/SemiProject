package com.kh.semi.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.semi.dao.MemberDao;
import com.kh.semi.dto.MemberDto;

@Controller
@RequestMapping("/member")
public class MemberController {
	
	@Autowired
	private MemberDao memberDao;
	
	//아이디 찾기
	@GetMapping("/find")
	public String find() {
		return "/WEB-INF/views/member/find.jsp";
	}
	
	@PostMapping("/find")
	public String find(@ModelAttribute MemberDto memberDto,
			Model model, RedirectAttributes attr) {
		try {
			String memberId = memberDao.findId(memberDto);
			model.addAttribute("findId", memberId);
			return "/WEB-INF/views/member/findResult.jsp";
		}
		catch(Exception e) {
			attr.addAttribute("mode", "error");
			return "redirect:find";
		}
	}
}