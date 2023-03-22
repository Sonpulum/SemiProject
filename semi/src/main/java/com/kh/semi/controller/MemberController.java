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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.semi.dao.MemberDao;
import com.kh.semi.dto.MemberDto;

@Controller
@RequestMapping("/member")
public class MemberController {
	@Autowired
	private MemberDao memberDao;
	
	// 회원 가입
	@GetMapping("/join")
	public String join() {
		return "/WEB-INF/views/member/join.jsp";
	}
	
	@PostMapping("/join")
	 public String join(@ModelAttribute MemberDto memberDto) {
		 memberDao.insert(memberDto);
		 return "redirect:joinFinish";
	 }
	 
	 @GetMapping("/joinFinish")
	 public String joinFinish() { 
		 return "/WEB-INF/views/member/joinFinish.jsp";
	 }
	 
	 //로그인
	 @GetMapping("/login")
	    public String login(HttpSession session) {
	       return "/WEB-INF/views/member/login.jsp";
	    }
	    
	 @PostMapping("/login")
	    public String login(
	          @ModelAttribute MemberDto userDto,
	          RedirectAttributes attr, HttpSession session) {

	       MemberDto findDto = memberDao.selectOne(userDto.getMemberId());
	       
	       if(findDto == null) {
	          attr.addAttribute("mode", "error");
	          return "redirect:login";
	       }
	       
	       if(!userDto.getMemberPw().equals(findDto.getMemberPw())) {
	          attr.addAttribute("mode", "error");
	          return "redirect:login";
	       }
	       
	       session.setAttribute("memberId", findDto.getMemberId());
	       session.setAttribute("memberLevel", findDto.getMemberLevel());
	       
	       return "redirect:/";
	    }

	 
	//마이페이지
		@GetMapping("/mypage")
		public String mypage(Model model, HttpSession session) {
				String memberId = (String)session.getAttribute("memberId");
				MemberDto memberDto = memberDao.selectOne(memberId);
				model.addAttribute("memberDto",memberDto);
				
				return "/WEB-INF/views/member/mypage.jsp";
		}
		
	//비밀번호를 제외한 나머지 개인정보 변경
    @GetMapping("/edit")
    public String edit(
          HttpSession session,
          Model model
         ) {
       String memberId = (String) session.getAttribute("memberId");
       MemberDto memberDto = memberDao.selectOne(memberId);
       model.addAttribute("memberDto", memberDto);
       return "/WEB-INF/views/member/edit.jsp";
    }
		
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
