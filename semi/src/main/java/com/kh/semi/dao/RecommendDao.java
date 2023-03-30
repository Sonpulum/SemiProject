package com.kh.semi.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.kh.semi.dto.RecommendAttachDto;
import com.kh.semi.dto.RecommendDto;
import com.kh.semi.dto.ReviewDto;

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
	
	private RowMapper<RecommendAttachDto> mapper2 = new RowMapper<RecommendAttachDto>() {

		@Override
		public RecommendAttachDto mapRow(ResultSet rs, int rowNum) throws SQLException {
			RecommendAttachDto recommendAttachDto = new RecommendAttachDto();
			recommendAttachDto.setRecoNo(rs.getInt("reco_no"));
			recommendAttachDto.setRecoWriter(rs.getString("reco_writer"));
			recommendAttachDto.setRecoTitle(rs.getString("reco_title"));
			recommendAttachDto.setRecoContent(rs.getString("reco_content"));
			recommendAttachDto.setRecoTheme(rs.getString("reco_theme"));
			recommendAttachDto.setRecoLocation(rs.getString("reco_location"));
			recommendAttachDto.setRecoSeason(rs.getString("reco_season"));
			recommendAttachDto.setRecoLike(rs.getInt("reco_like"));
			recommendAttachDto.setRecoRead(rs.getInt("reco_read"));
			recommendAttachDto.setRecoTime(rs.getDate("reco_time"));
			recommendAttachDto.setAttachNo(rs.getInt("attach_no"));
			return recommendAttachDto;
		}
	};
	
	public List<RecommendAttachDto> selectList() {
		String sql = "select R.*, IMG.attach_no from recommend R "
				+ "left outer join "
				+ "(select reco_no, min(attachment_no) attach_no from recommend_attachment group by reco_no) "
				+ "IMG on R.reco_no = IMG.reco_no";
		return jdbcTemplate.query(sql, mapper2);
	}
	
	//게시글 분류
	public List<RecommendAttachDto> selectList(String column, String keyword) {
		String sql = "select R.*, IMG.attach_no from recommend R "
				+ "left outer join "
				+ "(select reco_no, min(attachment_no) attach_no from recommend_attachment group by reco_no) "
				+ "IMG on R.reco_no = IMG.reco_no "
				+ "where instr(R.#1, ?) > 0 order by R.reco_no desc";
		sql = sql.replace("#1", column);
		Object[] param = {keyword};
		return jdbcTemplate.query(sql, mapper2, param);
	}
	
	//게시글 검색
	public List<RecommendDto> searchList(String keyword){
		String sql = "select * from recommend where instr(reco_title, ?) > 0 "
				+ "or instr(reco_content, ?) > 0 or instr(reco_location, ?) > 0 "
				+ "or instr(reco_theme, ?) > 0 or instr(reco_season, ?) > 0 order by reco_no";
		Object[] param = {keyword, keyword, keyword, keyword, keyword};
		return jdbcTemplate.query(sql, mapper, param);
	}
	
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
	
	//게시글 수정
	public boolean edit(RecommendDto recommendDto) {
		String sql = "update recommend set reco_title = ?, reco_content = ?, reco_theme = ?, "
				+ "reco_location = ?, reco_season = ? where reco_no = ?";
		Object[] param = {recommendDto.getRecoTitle(), recommendDto.getRecoContent(), recommendDto.getRecoTheme(),
							recommendDto.getRecoLocation(), recommendDto.getRecoSeason(), recommendDto.getRecoNo()};
		return jdbcTemplate.update(sql, param) > 0;
	}
	
	//게시글 삭제
	public boolean delete(int recoNo) {
		String sql = "delete recommend where reco_no = ?";
		Object[] param = {recoNo};
		return jdbcTemplate.update(sql, param) > 0;
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
	
	//인기 게시물 조회
	public List<RecommendDto> selectTopList(int count){
		String sql = "select * from (select * from recommend order by reco_read desc)\r\n"
				+ "where rownum<=?";
		Object[] param = {count};
		return jdbcTemplate.query(sql, mapper, param);
	}
	
}
