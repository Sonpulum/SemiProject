package com.kh.semi.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.kh.semi.dto.RecommendDto;

@Repository
public class RecommendDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	private RowMapper<RecommendDto> mapper = new RowMapper<RecommendDto>() {

		@Override
		public RecommendDto mapRow(ResultSet rs, int rowNum) throws SQLException {
			RecommendDto recommendDto = new RecommendDto();
			recommendDto.setRecoNo(rs.getInt("reco_no"));
			recommendDto.setRecoWriter(rs.getString("reco_writer"));
			recommendDto.setRecoTitle(rs.getString("reco_title"));
			recommendDto.setRecoContent(rs.getString("reco_content"));
			recommendDto.setRecoTheme(rs.getString("reco_theme"));
			recommendDto.setRecoLocation(rs.getString("reco_location"));
			recommendDto.setRecoSeason(rs.getString("reco_season"));
			recommendDto.setRecoLike(rs.getInt("reco_like"));
			recommendDto.setRecoRead(rs.getInt("reco_read"));
			recommendDto.setRecoTime(rs.getDate("reco_time"));
			return recommendDto;
		}
	};
	
	public List<RecommendDto> selectList() {
		String sql = "select * from recommend order by reco_no desc";
		return jdbcTemplate.query(sql, mapper);
	}
	
//	public List<RecommendDto> selectList(String column, String keyword) {
//		String sql = "select * from board "
//						+ "where instr(#1, ?) > 0 "
//						+ "connect by prior board_no=board_parent "
//						+ "start with board_parent is null "
//						+ "order siblings by board_group desc, board_no asc";
//		sql = sql.replace("#1", column);
//		Object[] param = {keyword};
//		return jdbcTemplate.query(sql, mapper, param);
//	}
	
	// 게시글 번호 우선 생성
	public int sequence() {
		String sql = "select recommend_seq.nextval from dual";
		return jdbcTemplate.queryForObject(sql, int.class);
	}
	
	// 게시글 등록
	public void insert(RecommendDto recommendDto) {
		String sql = "insert into recommend("
				+ "reco_no, reco_writer, reco_title, reco_content,"
				+ "reco_theme, reco_location, reco_season, reco_like,"
				+ "reco_read, reco_time)"
				+ "values ("
				+ "?, ?, ?, ?, ?, ?, ?, 0, 0, sysdate)";
		Object[] param = {recommendDto.getRecoNo(), recommendDto.getRecoWriter(), recommendDto.getRecoTitle(),
							recommendDto.getRecoContent(), recommendDto.getRecoTheme(),
							recommendDto.getRecoLocation(),recommendDto.getRecoSeason()};
		jdbcTemplate.update(sql, param);
	}
	
	// 게시글 상세보기
	public RecommendDto selectOne(int recoNo) {
		String sql = "select * from recommend where reco_no = ?";
		Object[] param = {recoNo};
		List<RecommendDto> list = jdbcTemplate.query(sql, mapper, param);
		return list.isEmpty() ? null : list.get(0);
	}

	// 게시글과 첨부파일 연결
	public void connect(int recoNo, int attachNo) {
		String sql = "insert into recommend_attachment values(?, ?)";
		Object[] param = {recoNo, attachNo};
		jdbcTemplate.update(sql,param);
	}
	
	// 조회수 증가
	public boolean updateReadcount(int recoNo) {
		String sql = "update recommend set reco_read = reco_read+1 where reco_no = ?";
		Object[] param = {recoNo};
		return jdbcTemplate.update(sql, param)>0;
	}
	
	// 좋아요 증가
	public void updateLikecount (int recoNo, int cnt) {
		String sql = "update recommend set reco_like = ? where reco_no = ?";
		Object[] param = {cnt, recoNo};
		jdbcTemplate.update(sql, param);
	}
	
}
