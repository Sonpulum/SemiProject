package com.kh.semi.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.semi.dao.RecommendDao;
import com.kh.semi.dao.RecommendLikeDao;
import com.kh.semi.dto.RecommendLikeDto;
import com.kh.semi.vo.RecommendLikeVO;

@RestController
@RequestMapping("/rest/recommend")
public class RecommendRestController {

	@Autowired
	private RecommendDao recoDao;
	
	@Autowired
	private RecommendLikeDao recoLikeDao;
	
	@PostMapping("/like")
	public RecommendLikeVO like(HttpSession session,
			@ModelAttribute RecommendLikeDto recoLikeDto) {
		String memberId = (String)session.getAttribute("memberId");
		recoLikeDto.setMemberId(memberId);
		
		boolean current = recoLikeDao.check(recoLikeDto);
		if(current) recoLikeDao.delete(recoLikeDto);
		else recoLikeDao.insert(recoLikeDto);
		
		int cnt = recoLikeDao.count(recoLikeDto.getRecoNo());
		recoDao.updateLikecount(recoLikeDto.getRecoNo(), cnt);
		
		return RecommendLikeVO.builder()
								.result(!current)
								.count(cnt)
							.build();
	}
	
	@PostMapping("/check")
	public boolean check(HttpSession session,
					@ModelAttribute RecommendLikeDto recoLikeDto) {
		String memberId = (String)session.getAttribute("memberId");
		recoLikeDto.setMemberId(memberId);
		return recoLikeDao.check(recoLikeDto);
	}
	
	@PostMapping("/write")
	public String wirte(@Mo)
}
