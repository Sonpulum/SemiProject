package com.kh.semi.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.semi.dto.RecommendLikeDto;

@Repository
public class RecommendLikeDao {
	
	@Autowired
	private JdbcTemplate jdbcTempalte;
	
	// 등록
	public void insert(RecommendLikeDto recoLikeDto) {
		String sql = "insert into reco_like values(?, ?)";
		Object[] param = {recoLikeDto.getMemberId(), recoLikeDto.getRecoNo()};
		jdbcTempalte.update(sql, param);
	}
	
	// 삭제
	public void delete(RecommendLikeDto recoLikeDto) {
		String sql = "delete reco_like where member_id = ? and reco_no = ?";
		Object[] param = {recoLikeDto.getMemberId(), recoLikeDto.getRecoNo()};
		jdbcTempalte.update(sql, param);
	}
	
	// 확인
	public boolean check(RecommendLikeDto recoLikeDto) {
		String sql = "select count(*) from reco_like where member_id = ? and reco_no = ?";
		Object[] param = {recoLikeDto.getMemberId(), recoLikeDto.getRecoNo()};
		int cnt = jdbcTempalte.queryForObject(sql, int.class, param);
		return cnt==1;
	}
	
	// 글에 대한 좋아요 개수
	public int count(int recoNo) {
		String sql = "select count(*) from reco_like where reco_no = ?";
		Object[] param = {recoNo};
		return jdbcTempalte.queryForObject(sql, int.class, param);
	}
}
