package com.kh.semi.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.semi.dao.MemberDao;
import com.kh.semi.dto.MemberDto;

@Controller
@RequestMapping("/member")
public class MemberController {
	@Autowired
	private MemberDao memberDao;
	
//	 회원 탈퇴
	 @GetMapping("/exit")
	 public String exit(HttpSession session) {
		 return "/WEB-INF/views/member/exit.jsp";
	 }
	 
	 @PostMapping("/exit")
	 public String exit(
			 	HttpSession session, 
			 	@RequestParam String memberPw,
			 	RedirectAttributes attr
			 ) {
		 String memberId = (String)session.getAttribute("memberId");
		 MemberDto memberDto = memberDao.selectOne(memberId);
		 
		 if(!memberDto.getMemberPw().equals(memberPw)) {
			 attr.addAttribute("mode", "error");
			 return "redirect:exit";
		 }
		 
		 memberDao.delete(memberId);
		 
		 session.removeAttribute("memberId");
		 session.removeAttribute("memberLevel");
		 
		 return "redirect:exitFinish";
	 }
	 
	 @GetMapping("/exitFinish")
	 public String exitFinish() {
		 return "/WEB-INF/views/member/exitFinish.jsp";
	 }
}
