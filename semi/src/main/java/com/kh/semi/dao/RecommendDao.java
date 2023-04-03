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
import com.kh.semi.vo.RecommendPaginationVO;
import com.kh.semi.vo.RecommendPaginationVO2;

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
			recommendDto.setRecoAddr(rs.getString("reco_addr"));
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
			recommendAttachDto.setRecoAddr(rs.getString("reco_addr"));
			recommendAttachDto.setAttachNo(rs.getInt("attach_no"));
			return recommendAttachDto;
		}
	};
	
	
	//페이징 적용된 조회 및 카운트
	public int selectCount(RecommendPaginationVO vo) {
		if(vo.isSearch()) {
			String sql = "select count(*) from recommend where instr(#1,?)>0";
			sql=sql.replace("#1", vo.getColumn());
			Object[] param = {vo.getKeyword()};
			return jdbcTemplate.queryForObject(sql, int.class, param);
		}
		else {
			String sql = "select count(*) from recommend";
			return jdbcTemplate.queryForObject(sql, int.class);
		}
	}
	
	//페이징 적용
	public List<RecommendAttachDto> selectList(RecommendPaginationVO vo){
		if(vo.isSearch()) {
			String sql = "select * from ( "
					+ "select rownum rn, TMP.* from ( "
					+ "select R.*, IMG.attach_no from recommend R "
					+ "left outer join "
					+ "(select reco_no, min(attachment_no) attach_no from recommend_attachment group by reco_no) "
					+ "IMG on R.reco_no = IMG.reco_no "
					+ "where instr(R.#1, ?) > 0 order by R.reco_no desc"
					+ ")TMP"
					+ ") where rn between ? and ?";
			sql = sql.replace("#1", vo.getColumn());
			Object[] param = {vo.getKeyword(), vo.getBegin(), vo.getEnd()};
			return jdbcTemplate.query(sql, mapper2, param);
		}
		else {
			String sql = "select * from ( "
					+ "select rownum rn, TMP.* from ( "
					+ "select R.*, IMG.attach_no from recommend R "
					+ "left outer join "
					+ "(select reco_no, min(attachment_no) attach_no from recommend_attachment group by reco_no) "
					+ "IMG on R.reco_no = IMG.reco_no order by R.reco_no desc"
					+ ")TMP"
					+ ") where rn between ? and ?";
			Object[] param = {vo.getBegin(), vo.getEnd()};
			return jdbcTemplate.query(sql, mapper2,param);			
		}
		
	}
	
	// 통합검색 페이징을 위한 카운트
	public int selectCount2(RecommendPaginationVO2 vo) {
		String sql = "select count(*) from recommend "
				+ "where instr(reco_title, ?) > 0 or instr(reco_content, ?) > 0 or "
				+ "instr(reco_location, ?) > 0 or instr(reco_season, ?) > 0 or "
				+ "instr(reco_theme, ?) > 0";
		Object[] param = {vo.getKeyword(), vo.getKeyword(), vo.getKeyword(), vo.getKeyword(), vo.getKeyword()};
		return jdbcTemplate.queryForObject(sql, int.class, param);
	}
	
	// 통합검색 페이징
	public List<RecommendAttachDto> searchList(RecommendPaginationVO2 vo){
		String sql = "select * from ( "
				+ "select rownum rn, TMP.* from ( "
				+ "select R.*, IMG.attach_no from recommend R "
				+ "left outer join "
				+ "(select reco_no, min(attachment_no) attach_no from recommend_attachment group by reco_no) "
				+ "IMG on R.reco_no = IMG.reco_no "
				+ "where instr(R.reco_title, ?) > 0 or instr(R.reco_content, ?) > 0 or "
				+ "instr(R.reco_location, ?) > 0 or instr(R.reco_season, ?) > 0 or "
				+ "instr(R.reco_theme, ?) > 0 order by R.reco_no desc"
				+ ")TMP"
				+ ") where rn between ? and ?";
			Object[] param = {vo.getKeyword(), vo.getKeyword(), vo.getKeyword(), vo.getKeyword(), vo.getKeyword(), vo.getBegin(), vo.getEnd()};
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
				+ "reco_theme, reco_location, reco_season, reco_addr, reco_like,"
				+ "reco_read, reco_time)"
				+ "values ("
				+ "?, ?, ?, ?, ?, ?, ?, ?, 0, 0, sysdate)";
		Object[] param = {recommendDto.getRecoNo(), recommendDto.getRecoWriter(), recommendDto.getRecoTitle(),
							recommendDto.getRecoContent(), recommendDto.getRecoTheme(),
							recommendDto.getRecoLocation(),recommendDto.getRecoSeason(),recommendDto.getRecoAddr()};
		jdbcTemplate.update(sql, param);
	}
	
	//게시글 수정
	public boolean edit(RecommendDto recommendDto) {
		String sql = "update recommend set reco_title = ?, reco_content = ?, reco_addr = ?, reco_theme = ?, "
				+ "reco_location = ?, reco_season = ? where reco_no = ?";
		Object[] param = {recommendDto.getRecoTitle(), recommendDto.getRecoContent(), recommendDto.getRecoAddr(), recommendDto.getRecoTheme(),
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
