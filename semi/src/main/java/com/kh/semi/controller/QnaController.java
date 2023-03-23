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

import com.kh.semi.dao.QnaDao;
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
   
   @GetMapping("/write")
   public String write(
         @RequestParam(required = false) Integer qnaParent,
         Model model) {
      model.addAttribute("qnaParent", qnaParent);
      return "/WEB-INF/views/qna/write.jsp";
   }
   
   @PostMapping("/write")
   public String write(@ModelAttribute QnaDto qnaDto,
         @RequestParam List<Integer> attachmentNo,
         HttpSession session,
         RedirectAttributes attr) {
      String memberId = (String)session.getAttribute("memberId");
      qnaDto.setQnaWriter(memberId);
      
      //나머지 일반 프로그래밍 코드는 서비스를 호출하여 처리
      int qnaNo = qnaService.write(qnaDto, attachmentNo);
      
      attr.addAttribute("qnaNo", qnaNo);
      
      //상세 페이지로 redirect
      return "redirect:detail";
   }
   
   @GetMapping("/list")
   public String list(@ModelAttribute("vo") QnaPaginationVO vo,
         Model model) {
      int totalCount = qnaDao.selectCount(vo);
      vo.setCount(totalCount);
      
      //게시글
      List<QnaDto> list = qnaDao.selectList(vo);
      model.addAttribute("list", list);
      
      return "/WEB-INF/views/qna/list.jsp";
   }
   
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
      if(!owner) {//내가 작성한 글이 아니라면(시나리오 1번)
         
         //시나리오 2번 진행
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
      return "/WEB-INF/views/qna/detail.jsp";
   }
}