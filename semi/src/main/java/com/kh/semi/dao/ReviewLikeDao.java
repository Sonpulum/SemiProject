package com.kh.semi.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.web.bind.annotation.RestController;

import com.kh.semi.dto.ReviewLikeDto;

@RestController
public class ReviewLikeDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	public void insert(ReviewLikeDto reviewLikeDto) {
		String sql = "insert into review_like(member_id, review_no) values(?, ?)";
		Object[] param = {reviewLikeDto.getMemberId(), reviewLikeDto.getReviewNo()};
		jdbcTemplate.update(sql, param);
	}
	
	public void delete(ReviewLikeDto reviewLikeDto) {
		String sql = "delete review_like where member_id = ? and review_no = ?";
		Object[] param = {reviewLikeDto.getMemberId(), reviewLikeDto.getReviewNo()};
		jdbcTemplate.update(sql, param);
	}
	
	public boolean check(ReviewLikeDto reviewLikeDto) {
		String sql = "select count(*) from review_like where member_id = ? and review_no = ?";
		Object[] param = {reviewLikeDto.getMemberId(), reviewLikeDto.getReviewNo()};
		int count = jdbcTemplate.queryForObject(sql, int.class, param);
		return count == 1;
	}
	
	public int count(int reviewNo) {
		String sql = "select count(*) from review_like where review_no = ?";
		Object[] param = {reviewNo};
		return jdbcTemplate.queryForObject(sql, int.class, param);
	}
	
}
