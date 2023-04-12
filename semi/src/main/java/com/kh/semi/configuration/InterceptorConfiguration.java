package com.kh.semi.configuration;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.kh.semi.interceptor.MemberInterceptor;
import com.kh.semi.interceptor.QnaInterceptor;
import com.kh.semi.interceptor.RecommendInterceptor;
import com.kh.semi.interceptor.ReviewInterceptor;

@Configuration
public class InterceptorConfiguration implements WebMvcConfigurer{
			
	@Autowired
	private QnaInterceptor qnaInterceptor;
	
	@Autowired
	private MemberInterceptor memberInterceptor;
	
	@Autowired
	private RecommendInterceptor recommendInterceptor;
	
	@Autowired
	private ReviewInterceptor reviewInterceptor;
	
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		
		//1. MemberInterceptor
		registry.addInterceptor(memberInterceptor)
				.addPathPatterns(
						"/member/**",
						"/admin/**",
						"/qna/**",
						"/review/**"
						)
				.excludePathPatterns(
						"/member/join", 
						"/member/joinFinish",
						"/member/login",
						"/member/find",
						"/member/findPw",
						"/member/exitFinish",
						"/qna/list",
						"/qna/detail",
						"/review/list",
						"/review/listTotal",
						"/review/detail"
						);

		//2. QnaInterceptor
		registry.addInterceptor(qnaInterceptor)
				.addPathPatterns(
						"/qna/delete"
						);
		
		//3. RecommendInterceptor
		registry.addInterceptor(recommendInterceptor)
				.addPathPatterns(
						"/recommend/write",
						"/recommend/delete",
						"/recommend/edit"
						);
		
		//4. ReviewInterceptor
		registry.addInterceptor(reviewInterceptor)
				.addPathPatterns(
						"/review/delete",
						"/review/edit"
						);
	}
}