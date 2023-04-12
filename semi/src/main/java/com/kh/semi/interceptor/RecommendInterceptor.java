package com.kh.semi.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.HandlerInterceptor;

import com.kh.semi.dao.RecommendDao;

@Service
public class RecommendInterceptor implements HandlerInterceptor{
	
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		HttpSession session = request.getSession();
		String memberLevel = (String)session.getAttribute("memberLevel");
		boolean isAdmin = memberLevel.equals("관리자");
		
		if(isAdmin) {
			if(request.getRequestURI().equals(request.getContextPath()+"/recommend/delete") || request.getRequestURI().equals(request.getContextPath()+"/recommend/write")) {
				return true;
			}
		}
		
		return false;
	}
	
}
