package com.kh.semi.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.HandlerInterceptor;

import com.kh.semi.dao.QnaDao;
import com.kh.semi.dto.QnaDto;

@Service
public class QnaInterceptor implements HandlerInterceptor {
	
	@Autowired
	private QnaDao qnaDao;
	
	@Override
	public boolean preHandle(HttpServletRequest request, 
			HttpServletResponse response, 
			Object handler)
			throws Exception {

		//게시글 작성자 확인
		int qnaNo = Integer.parseInt(request.getParameter("qnaNo"));
		QnaDto qnaDto = qnaDao.selectOne(qnaNo);
		String writerId = qnaDto.getQnaWriter();
		
		//현재 로그인 회원 확인
		HttpSession session = request.getSession();
		String memberId = (String)session.getAttribute("memberId");
		
		//현재 로그인 회원의 등급 확인
		String memberLevel = (String)session.getAttribute("memberLevel");
		
		//작성자
		boolean isOwner = memberId.equals(writerId);
		
		//관리자
		boolean isAdmin = memberLevel.equals("관리자");

		if(isAdmin) {
			if(request.getRequestURI().equals(request.getContextPath()+"/qna/delete")) {
				return true;
			}
		}
		
		if(isOwner) {
			return true;
		}
			
		//조건에 해당하지 않는 경우는 모두 차단
		response.sendError(403);
		return false;
	}
}