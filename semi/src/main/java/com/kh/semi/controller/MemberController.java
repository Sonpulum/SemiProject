package com.kh.semi.controller;

import java.io.IOException;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.semi.component.RandomComponent;
import com.kh.semi.dao.MemberDao;
import com.kh.semi.dao.MemberProfileDao;
import com.kh.semi.dto.MemberDto;
import com.kh.semi.service.MemberService;

@Controller
@RequestMapping("/member")
public class MemberController {
	@Autowired
	private MemberDao memberDao;
	
	@Autowired
	private JavaMailSender sender;
	
	@Autowired
	private RandomComponent randomComponent;
	
	@Autowired
	private MemberProfileDao memberProfileDao;
	
	@Autowired
	private MemberService memberService;
	
	// 회원 가입
	@GetMapping("/join")
	public String join() {
		return "/WEB-INF/views/member/join.jsp";
	}
	
	@PostMapping("/join")
	 public String join(
			 @ModelAttribute MemberDto memberDto,
			 @RequestParam MultipartFile attach) throws IllegalStateException, IOException {
		 memberService.join(memberDto, attach);
		 return "redirect:login";
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
	       session.setAttribute("memberNick", findDto.getMemberNick());
	       
	       return "redirect:/";
	    }
	 
	//로그아웃 - 세션에 저장된 데이터를 삭제하는 작업
		@GetMapping("/logout")
		public String logout(HttpSession session) {
			session.removeAttribute("memberId");
			session.removeAttribute("memberLevel");
			session.removeAttribute("memberNick");
			session.removeAttribute("recommendMemory");
			session.removeAttribute("reviewMemory");
			return "redirect:/";
			
		}

	//마이페이지
	@GetMapping("/mypage")
	public String mypage(Model model, HttpSession session) {
			String memberId = (String)session.getAttribute("memberId");
			MemberDto memberDto = memberDao.selectOne(memberId);
			model.addAttribute("memberDto",memberDto);
			model.addAttribute("profile", memberProfileDao.selectOne(memberId));
			
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
       model.addAttribute("profile", memberProfileDao.selectOne(memberId));
       
       model.addAttribute("memberDto", memberDto);
       return "/WEB-INF/views/member/edit.jsp";
    }
    
	 //개인정보 변경 처리 기능
	 @PostMapping("/edit")
	 public String edit(
			 @ModelAttribute MemberDto memberDto,
			 @RequestParam MultipartFile attach,
			 HttpSession session,
			 RedirectAttributes attr
		 ) throws IllegalStateException, IOException {
		 String memberId = (String)session.getAttribute("memberId");
		 MemberDto findDto = memberDao.selectOne(memberId);

		 //비밀번호가 일치하지 않는다면 → 에러 표시 후 이전 페이지로 리다이렉트
		 if(!findDto.getMemberPw().equals(memberDto.getMemberPw())) {
			 attr.addAttribute("mode", "error");
			 return "redirect:edit";
		 }

		 //비밀번호가 일치한다면 → 비밀번호 변경 및 완료 페이지로 리다이렉트
		 memberDto.setMemberId(memberId);
		 memberService.update(memberDto, attach);
		 
		 return "redirect:editFinish";
	 }
	 
	 //개인정보 변경 완료 페이지
	 @GetMapping("/editFinish")
	 public String editFinish() {
		 return "/WEB-INF/views/member/editFinish.jsp";
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
   
   //비밀번호 찾기
   @GetMapping("/findPw")
   public String findPw() {
      return "/WEB-INF/views/member/findPw.jsp";
   }
   
   @PostMapping("/findPw")
   public String findPw(@ModelAttribute MemberDto memberDto,
         @RequestParam String memberId,
         @RequestParam String memberEmail,
         RedirectAttributes attr) {
      try {
         MemberDto userDto = memberDao.selectOne(memberId);
         
         if (userDto == null || !userDto.getMemberEmail().equals(memberEmail)) {
               throw new IllegalArgumentException("일치하는 정보가 없습니다.");
           }
         
         String userEmail = userDto.getMemberEmail();
         String userId = userDto.getMemberId();
         
         String temporaryPw = randomComponent.generateString(10);
         
         if(memberId.equals(userId) && memberEmail.equals(userEmail)) {
            //1회용 비밀번호 이메일로 발급
            SimpleMailMessage message = new SimpleMailMessage();
            message.setTo(memberEmail);
            message.setSubject("일회용 비밀번호 발급");
            message.setText(temporaryPw);
            
            sender.send(message);
            
            //비밀번호 변경
            memberDao.changePassword(temporaryPw, memberId);
         }
      }
         catch(Exception e) {
             attr.addAttribute("mode", "error");
             return "redirect:findPw";
          }
         return "/WEB-INF/views/member/findPwResult.jsp";
   }

   
   //비밀번호 재설정
   @GetMapping("/password")
   public String password() {
	   return "/WEB-INF/views/member/password.jsp";
	}
   
   @PostMapping("/password")
   public String password(
			@RequestParam String currentPw,//현재 비밀번호
			@RequestParam String newPw,//변경할 비밀번호
			HttpSession session,
			RedirectAttributes attr) {
		String memberId = (String)session.getAttribute("memberId");
		MemberDto memberDto = memberDao.selectOne(memberId);
		
		if(!memberDto.getMemberPw().equals(currentPw)) {
			attr.addAttribute("mode", "error");
			return "redirect:password";
		}
		
		//비밀번호가 일치한다면 → 비밀번호 변경 처리
		memberDao.changePassword(newPw, memberId);
		return "redirect:passwordFinish";
	}
   
   @GetMapping("/passwordFinish")
   public String passwordFinish() {
	   return "/WEB-INF/views/member/passwordFinish.jsp";
	}
   
}
