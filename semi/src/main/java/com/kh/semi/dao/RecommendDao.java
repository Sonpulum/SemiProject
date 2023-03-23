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
			return recommendDto;
		}
	};
	
	public int sequence() {
		String sql = "select recommend_seq.nextval from dual";
		return jdbcTemplate.queryForObject(sql, int.class);
	}
	
	public void insert(RecommendDto recommendDto) {
		String sql = "insert into recommend("
				+ "reco_no, reco_writer, reco_title, reco_content,"
				+ "reco_theme, reco_location, reco_season)"
				+ "values ("
				+ "?, ?, ?, ?, ?, ?, ?)";
		Object[] param = {recommendDto.getRecoNo(), recommendDto.getRecoWriter(), recommendDto.getRecoTitle(),
							recommendDto.getRecoContent(), recommendDto.getRecoTheme(),
							recommendDto.getRecoLocation(),recommendDto.getRecoSeason()};
		jdbcTemplate.update(sql, param);
	}
	
	public RecommendDto selectOne(int recoNo) {
		String sql = "select * from recommend where reco_no = ?";
		Object[] param = {recoNo};
		List<RecommendDto> list = jdbcTemplate.query(sql, mapper, param);
		return list.isEmpty() ? null : list.get(0);
	}
	
}
