package com.kh.semi.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.semi.dao.ReviewDao;
import com.kh.semi.dto.ReviewDto;

@Service
public class ReviewService {
	
	@Autowired
	private ReviewDao reviewDao;
	
	public int write(ReviewDto reviewDto, List<Integer> attachmentNo) {
		int reviewNo = reviewDao.sequence();
		
		reviewDto.setReviewNo(reviewNo);
		
		reviewDao.insert(reviewDto);
		
		if(attachmentNo != null) {
			for(int no : attachmentNo) {
				reviewDao.connect(reviewNo, no);
			}			
		}
		
		return reviewNo;
	}
}
