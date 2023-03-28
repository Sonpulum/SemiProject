package com.kh.semi.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.kh.semi.dto.ReviewDto;
import com.kh.semi.vo.ReviewPaginationVO;

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
			reviewDto.setReviewTime(rs.getDate("review_time"));
			return reviewDto;
		}
	};
	
	//인기 게시물 조회
	public List<ReviewDto> selectTopList(int count){
		String sql = "select * from (select * from review order by review_read desc)\r\n"
				+ "where rownum<=?";
		Object[] param = {count};
		return jdbcTemplate.query(sql, mapper, param);
	}
	
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
	
	//페이징 적용된 조회 및 카운트
		public int selectCount(ReviewPaginationVO vo) {
			if(vo.isSearch()) {
				String sql = "select count(*) from review where instr(#1,?)>0";
				sql=sql.replace("#1", vo.getColumn());
				Object[] param = {vo.getKeyword()};
				return jdbcTemplate.queryForObject(sql, int.class, param);
			}
			else {
				String sql = "select count(*) from review";
				return jdbcTemplate.queryForObject(sql, int.class);
			}
		}
		
		//페이징 적용
		public List<ReviewDto> selectList(ReviewPaginationVO vo){
			if(vo.isSearch()) {
				String sql = "select * from ( "
						+ "select rownum rn, TMP.* from ( "
						+ "select * from review "
						+ "where instr(#1,?)>0"
						+ "order by review_no desc"
						+ ")TMP"
						+ ") where rn between ? and ?";
				sql = sql.replace("#1", vo.getColumn());
				Object[] param = {vo.getKeyword(), vo.getBegin(), vo.getEnd()};
				return jdbcTemplate.query(sql, mapper, param);
			}
			else {
				String sql = "select * from ( "
						+ "select rownum rn, TMP.* from ( "
						+ "select * from review "
						+ "order by review_no desc"
						+ ")TMP"
						+ ") where rn between ? and ?";
				Object[] param = {vo.getBegin(), vo.getEnd()};
				return jdbcTemplate.query(sql, mapper,param);			
			}
			
		}
		
	//조회수 증가
	public boolean updateReadCount(int reviewNo) {
		String sql = "update review set review_read = review_read + 1 "
				+ "where review_no = ?";
		Object[] param = {reviewNo};
		return jdbcTemplate.update(sql, param) > 0;
	}
	
	//등록
	public int sequence() {
		String sql = "select review_seq.nextval from dual";
		return jdbcTemplate.queryForObject(sql, int.class);
	}
	
	public void insert(ReviewDto reviewDto) {
		String sql = "insert into review("
				+ "review_no, review_writer, review_title, review_content,"
				+ "review_theme, review_location, review_season, review_read, review_reply,review_like,review_time)"
				+ "values ("
				+ "?, ?, ?, ?, ?, ?, ?,0,0,0,sysdate)";
		Object[] param = {reviewDto.getReviewNo(), reviewDto.getReviewWriter(), reviewDto.getReviewTitle(),
							reviewDto.getReviewContent(), reviewDto.getReviewTheme(),
							reviewDto.getReviewLocation(),reviewDto.getReviewSeason()};
		jdbcTemplate.update(sql, param);
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
	
	//좋아요 개수 갱신 기능
	public void updateLikeCount(int reviewNo, int count) {
		String sql = "update review set review_like = ? where review_no = ?";
		Object[] param = {count, reviewNo};
		jdbcTemplate.update(sql, param);
	}
	
	//커넥트
	public void connect(int reviewNo, int attachmentNo) {
		String sql = "insert into review_attachment values(?, ?)";
		Object[] param = {reviewNo, attachmentNo};
		jdbcTemplate.update(sql, param);
	}
	
	//댓글 개수 갱신기능
	public void updateReplycount(int reviewNo) {
		String sql = "update review "
						+ "set review_reply = ("
							+ "select count(*) from review_reply where review_reply_origin = ?"
						+ ") "
					+ "where review_no = ?";
		Object[] param = {reviewNo, reviewNo};
		jdbcTemplate.update(sql, param);
	}

}
