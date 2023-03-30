package com.kh.semi.configuration;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.kh.semi.interceptor.MemberInterceptor;
import com.kh.semi.interceptor.QnaInterceptor;

@Configuration
public class InterceptorConfiguration implements WebMvcConfigurer{
			
	@Autowired
	private QnaInterceptor qnaInterceptor;
	
	@Autowired
	private MemberInterceptor memberInterceptor;
	
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		
		//1. MemberInterceptor
		registry.addInterceptor(memberInterceptor)
				.addPathPatterns(
						"/member/**",
						"/admin/**",
						"/qna/**"
						)
				.excludePathPatterns(
						"/member/join", 
						"/member/joinFinish",
						"/member/login",
						"/member/find",
						"/member/findPw",
						"/member/exitFinish",
						"/qna/list",
						"/qna/detail"
						);

		//2. QnaInterceptor
		registry.addInterceptor(qnaInterceptor)
				.addPathPatterns(
						"/qna/edit",
						"/qna/delete"
						);
	}
}