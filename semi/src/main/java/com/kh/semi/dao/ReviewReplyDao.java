package com.kh.semi.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.kh.semi.dto.ReviewReplyDto;

@Repository
public class ReviewReplyDao {
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	private RowMapper<ReviewReplyDto> mapper = (rs, rowNum) ->{
		return ReviewReplyDto.builder()
					.reviewReplyNo(rs.getInt("review_reply_no"))
					.reviewReplyWriter(rs.getString("review_reply_writer"))
					.reviewReplyOrigin(rs.getInt("review_reply_origin"))
					.reviewReplyContent(rs.getString("review_reply_content"))
					.reviewReplyTime(rs.getDate("review_reply_time"))
					.memberNick(rs.getString("member_nick"))
				.build();
	};
	
	public void insert(ReviewReplyDto reviewReplyDto) {
		String sql = "insert into review_reply("
				+ "review_reply_no, review_reply_writer, review_reply_origin,"
				+ "review_reply_content, review_reply_time) "
				+ "values(review_reply_seq.nextval,?,?,?,sysdate)";
		Object[] param = {
				reviewReplyDto.getReviewReplyWriter(),
				reviewReplyDto.getReviewReplyOrigin(),
				reviewReplyDto.getReviewReplyContent()
		};
		jdbcTemplate.update(sql,param);
	}
	
	public List<ReviewReplyDto> selectList(int reviewReplyOrigin){
	    String sql = "select r.*, m.member_nick from review_reply r "
	               + "join member m on r.review_reply_writer = m.member_id "
	               + "where r.review_reply_origin = ? "
	               + "order by r.review_reply_no asc";
	    Object[] param = {reviewReplyOrigin};
	    return jdbcTemplate.query(sql, mapper, param);
	}
	
	public void update(ReviewReplyDto reviewReplyDto) {
		String sql = "update review_reply set review_reply_content = ? "
				+ "where review_reply_no = ?";
		Object [] param = {reviewReplyDto.getReviewReplyContent(), reviewReplyDto.getReviewReplyNo()};
		jdbcTemplate.update(sql, param);
	}
	
	public void delete(int reviewReplyNo) {
		String sql = "delete review_reply where review_reply_no = ?";
		Object[] param = {reviewReplyNo};
		jdbcTemplate.update(sql, param);
	}
	
	public ReviewReplyDto selectOne(int reviewReplyNo) {
		String sql = "select * from review_reply where review_reply_no=?";
		Object[] param = {reviewReplyNo};
		List<ReviewReplyDto> list = jdbcTemplate.query(sql, mapper, param);
		return list.isEmpty() ? null:list.get(0);
	}
					
}


