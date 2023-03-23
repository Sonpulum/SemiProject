package com.kh.semi.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.kh.semi.dto.ReviewDto;

@Repository
public class ReviewDao {
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	private RowMapper<ReviewDto> mapper = new RowMapper<ReviewDto>() {
			
		@Override
		public ReviewDto mapRow(ResultSet rs, int rowNum) throws SQLException {
			ReviewDto reviewDto = new ReviewDto();
			reviewDto.setReviewNo(rs.getInt("review_no"));
			reviewDto.setReviewWriter(rs.getString("review_writer"));
			reviewDto.setReviewSeason(rs.getString("review_season"));
			reviewDto.setReviewTheme(rs.getString("review_Theme"));
			reviewDto.setReviewLocation(rs.getString("review_location"));
			reviewDto.setReviewTitle(rs.getString("review_title"));
			reviewDto.setReviewContent(rs.getString("review_content"));
			reviewDto.setReviewReply(rs.getString("review_reply"));
			reviewDto.setReviewRead(rs.getInt("review_read"));
			reviewDto.setReviewLike(rs.getInt("review_like"));
			return reviewDto;
		}
	};
	
	//목록
	public List<ReviewDto> selectList(){
		String sql = "select*from review order by review_no desc";
		return jdbcTemplate.query(sql, mapper);
	}
	
	//검색
	public List<ReviewDto> selectList(String column, String keyword){
		String sql = "select*from review "
				+ "where instr(#1,?)>0"
				+ "order by review_no desc";
		sql=sql.replace("#1", column);
		Object[] param = {keyword};
		return jdbcTemplate.query(sql, mapper, param);
	}
	
	//상세조회
	public ReviewDto selectOne(int reviewNo) {
		String sql="select*from review where review_no=?";
		Object[] param = {reviewNo};
		List<ReviewDto> list = jdbcTemplate.query(sql, mapper,param);
		return list.isEmpty()? null:list.get(0);
		
	}
	
	//게시물 등록
	public int sequence() {
			String sql = "select review_seq.nextval from dual";
			return jdbcTemplate.queryForObject(sql, int.class);
	}
	
	public void insert(ReviewDto reviewDto) {
		String sql = "insert into review(review_no, review_writer,review_title,"
				+ "review_content,review_season,review_theme,review_location, review_like,review_reply,"
				+ "review_read)"
				+ "values(?,?,?,?,?,?,?,0,0,0)";
		Object[] param = {reviewDto.getReviewNo(), reviewDto.getReviewWriter(), reviewDto.getReviewTitle(),
				reviewDto.getReviewContent(), reviewDto.getReviewSeason(), reviewDto.getReviewTheme(),
				reviewDto.getReviewLocation(), reviewDto.getReviewLike(), reviewDto.getReviewReply(), reviewDto.getReviewRead()};
		jdbcTemplate.update(sql,param);	
	}
	
	//수정
	public boolean update(ReviewDto reviewDto) {
		String sql = "update review set "
				+ "review_title = ?, review_content = ? "
				+ "where review_no = ?";
		Object[] param = {
			reviewDto.getReviewTitle(), reviewDto.getReviewContent(),
			reviewDto.getReviewNo()
		};
		return jdbcTemplate.update(sql, param) > 0;
	}
	
	//삭제
	public boolean delete(int reviewNo) {
		String sql = "delete review where review_no = ?";
		Object[] param = {reviewNo};
		return jdbcTemplate.update(sql, param) > 0;
	}
	
}
