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
import com.kh.semi.dao.QnaDao;
import com.kh.semi.dto.MemberDto;
import com.kh.semi.dto.MemberProfileDto;
import com.kh.semi.dto.QnaDto;
import com.kh.semi.service.QnaService;
import com.kh.semi.vo.QnaPaginationVO;

@Controller
@RequestMapping("/qna")
public class QnaController {

   @Autowired
   private QnaDao qnaDao;
   
   @Autowired
   private QnaService qnaService;
   
   @Autowired
	private MemberProfileDao memberProfileDao;
   
   @Autowired
   private MemberDao memberDao;
   
   //Q&A 작성
   @GetMapping("/write")
   public String write(
         @RequestParam(required = false) Integer qnaParent,
         Model model) {
      model.addAttribute("qnaParent", qnaParent);
      return "/WEB-INF/views/qna/write.jsp";
   }
   
   @PostMapping("/write")
   public String write(@ModelAttribute QnaDto qnaDto,
		   @RequestParam(required=false) List<Integer> attachmentNo,
		   @RequestParam(defaultValue = "false") boolean qnaSecret,
         HttpSession session,
         RedirectAttributes attr,
         Model model) {
      String memberId = (String)session.getAttribute("memberId");
      qnaDto.setQnaWriter(memberId);
      
      MemberDto memberDto = memberDao.selectOne(memberId);
      String memberNick = memberDto.getMemberNick();
      qnaDto.setMemberNick(memberNick);
      
      //나머지 일반 프로그래밍 코드는 서비스를 호출하여 처리
      int qnaNo = qnaService.write(qnaDto, attachmentNo, qnaSecret);
      
      //작성자 여부 확인
      boolean owner = qnaDto.getQnaWriter() != null
    		  && qnaDto.getQnaWriter().equals(memberId);
      model.addAttribute("owner", owner);
      
      //관리자 여부 확인
      String memberLevel = (String)session.getAttribute("memberLevel");
      boolean admin = memberLevel != null && memberLevel.equals("관리자");
      model.addAttribute("admin", admin);
      
      model.addAttribute("attachmentNo", attachmentNo);
      attr.addAttribute("qnaNo", qnaNo);
      
      //상세 페이지로 redirect
      return "redirect:detail";
   }
   
   //Q&A 목록
   @GetMapping("/list")
   public String list(@ModelAttribute("vo") QnaPaginationVO vo,
         HttpSession session,
         Model model) {
     //정렬 조건을 VO 객체에 설정  
      int totalCount = qnaDao.selectCount(vo);
      vo.setCount(totalCount);
      
      //공지사항
      model.addAttribute("noticeList", qnaDao.selectNoticeList(1, 3));
      
      String memberNick = (String)session.getAttribute("memberNick");
      model.addAttribute("memberNick", memberNick);
      
      //게시글
      List<QnaDto> list = qnaDao.selectList(vo);
      model.addAttribute("list", list);
      
      return "/WEB-INF/views/qna/list.jsp";
   }
   
   	//Q&A 상세
 	@GetMapping("/detail")
 	public String detail(
 			@RequestParam int qnaNo, 
 			Model model,
 			HttpSession session) {
 		//사용자가 작성자인지 판정 후 JSP로 전달
 		QnaDto qnaDto = qnaDao.selectOne(qnaNo);
 		String memberId = (String)session.getAttribute("memberId");
 		
 		boolean owner = qnaDto.getQnaWriter() != null
 				&& qnaDto.getQnaWriter().equals(memberId);
 		model.addAttribute("owner", owner);
 		
 		//사용자가 관리자인지 판정 후 JSP로 전달
 		String memberLevel = (String)session.getAttribute("memberLevel");
 		boolean admin = memberLevel != null && memberLevel.equals("관리자");
 		model.addAttribute("admin", admin);
 		
 		//조회수 증가
 		if(!owner) {
 			Set<Integer> memory = (Set<Integer>) session.getAttribute("memory");
 			if(memory == null) {
 				memory = new HashSet<>();
 			}
 			
 			if(!memory.contains(qnaNo)) {//읽은 적이 없는가(기억에 없는가)
 				qnaDao.updateReadcount(qnaNo);
 				qnaDto.setQnaRead(qnaDto.getQnaRead() + 1);//DTO 조회
 				memory.add(qnaNo);//저장소에 추가(기억에 추가)
 			}
 			session.setAttribute("memory", memory);//저장소 갱신
 		}
 		
 		model.addAttribute("qnaDto", qnaDto);
 		
 		String qnaWriter = qnaDto.getQnaWriter();
		MemberProfileDto memberProfile = memberProfileDao.selectOne(qnaWriter);
		String memberNick = memberDao.selectOne(qnaWriter).getMemberNick();
		
		model.addAttribute("qnaWriterNick", memberNick);
		model.addAttribute("memberProfile", memberProfile);
 		
 		return "/WEB-INF/views/qna/detail.jsp";
 	}
   
   	//Q&A 게시글 삭제
 	@GetMapping("/delete")
 	public String delete(@RequestParam int qnaNo) {
 		qnaDao.delete(qnaNo);
 		return "redirect:list";
 	}
 	
 	//Q&A 게시글 수정
	@GetMapping("/edit")
	public String edit(@RequestParam int qnaNo,
			Model model) {
		qnaDao.selectOne(qnaNo);
		model.addAttribute("qnaDto", qnaDao.selectOne(qnaNo));
		return "/WEB-INF/views/qna/edit.jsp";
	}
	
	@PostMapping("/edit")
	public String edit(
			@ModelAttribute QnaDto qnaDto,
			Model model, RedirectAttributes attr,
			HttpSession session) {
		qnaDao.edit(qnaDto);
		attr.addAttribute("qnaNo", qnaDto.getQnaNo());
		
		String memberLevel = (String)session.getAttribute("memberLevel");
		attr.addAttribute("memberLevel", memberLevel);
		
		return "redirect:detail";
	}
}