package com.kh.semi.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.kh.semi.dto.MemberDto;
import com.kh.semi.dto.ReviewDto;
import com.kh.semi.vo.MemberPaginationVO;
import com.kh.semi.vo.ReviewPaginationVO;

@Repository
public class MemberDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	private RowMapper<MemberDto> mapper = new RowMapper<MemberDto>() {
		
		@Override
		public MemberDto mapRow(ResultSet rs, int rowNum) throws SQLException {
			MemberDto memberDto = new MemberDto();
			memberDto.setMemberId(rs.getString("member_id"));
			memberDto.setMemberPw(rs.getString("member_pw"));
			memberDto.setMemberNick(rs.getString("member_nick"));
			memberDto.setMemberTel(rs.getString("member_tel"));
			memberDto.setMemberEmail(rs.getString("member_email"));
			memberDto.setMemberBirth(rs.getString("member_birth"));
			memberDto.setMemberPost(rs.getString("member_post"));
			memberDto.setMemberBasicAddr(rs.getString("member_basic_addr"));
			memberDto.setMemberDetailAddr(rs.getString("member_detail_addr"));
			memberDto.setMemberLevel(rs.getString("member_level"));
			return memberDto;
		}
	};
	
	public void insert(MemberDto memberDto) {
		String sql = "insert into member(member_id, member_pw, member_nick, member_tel, "
				+ "member_email, member_birth, member_post, member_basic_addr, "
				+ "member_detail_addr, member_level) "
				+ "values("
				+ "?, ?, ?, ?, ?, ?, ?, ?, ?, '일반회원')";
		Object[] param = {
				memberDto.getMemberId(), memberDto.getMemberPw(), memberDto.getMemberNick(),
				memberDto.getMemberTel(), memberDto.getMemberEmail(), memberDto.getMemberBirth(),
				memberDto.getMemberPost(), memberDto.getMemberBasicAddr(), memberDto.getMemberDetailAddr()
		};
		jdbcTemplate.update(sql, param);
	}
	
	//회원 목록
	public List<MemberDto> selectList(MemberPaginationVO vo){
		if(vo.isSearch()) {
			String sql = "select * from ( "
					+ "select rownum rn, TMP.* from ( "
					+ "select * from member "
					+ "where instr(#1,?)>0"
					+ "order by member_level"
					+ ")TMP"
					+ ") where rn between ? and ?";
			sql = sql.replace("#1", vo.getColumn());
			Object[] param = {vo.getKeyword(), vo.getBegin(), vo.getEnd()};
			return jdbcTemplate.query(sql, mapper, param);
		}
		else {
			String sql = "select * from( "
					+ "select rownum rn, TMP.* from( "
					+ "select*from member "
					+ "order by member_level"
					+ ")TMP) where rn between ? and ?";
			Object[] param = {vo.getBegin(), vo.getEnd()};
			return jdbcTemplate.query(sql, mapper,param);			
		}
		
	}
	
	//페이징 적용된 조회 및 카운트
	public int selectCount(MemberPaginationVO vo) {
		if(vo.isSearch()) {
			String sql = "select count(*) from member where instr(#1,?)>0";
			sql=sql.replace("#1", vo.getColumn());
			Object[] param = {vo.getKeyword()};
			return jdbcTemplate.queryForObject(sql, int.class, param);
		}
		else {
			String sql = "select count(*) from member";
			return jdbcTemplate.queryForObject(sql, int.class);
		}
	}

	
	public MemberDto selectOne(String id) {
		String sql = "select * from member where member_id = ?";
		Object[] param = {id};
		List<MemberDto> list = jdbcTemplate.query(sql, mapper, param);
		return list.isEmpty() ? null : list.get(0);
	}
	
	public boolean updateMemberLogin(String memberId) {
		String sql = "update member set member_login = sysdate where member_id = ?";
		Object[] param = {memberId};
		return jdbcTemplate.update(sql, param) > 0;
	}
	
	public boolean changePassword(String memberPw, String memberId) {
		String sql = "update member set member_pw = ? where member_id = ?";
		Object[] param = {memberPw, memberId};
		return jdbcTemplate.update(sql, param) > 0;
	}
	
	public boolean changeInformation(MemberDto memberDto) {
		String sql = "update member set member_nick = ?, member_tel = ?, member_email = ?,"
				+ "member_birth = ?, member_post = ?, member_basic_addr = ?, member_detail_addr = ?"
				+ "where member_id = ?";
		Object[] param = {memberDto.getMemberNick(), memberDto.getMemberTel(), memberDto.getMemberEmail(),
				memberDto.getMemberBirth(), memberDto.getMemberPost(), memberDto.getMemberBasicAddr(),
				memberDto.getMemberDetailAddr(), memberDto.getMemberId()};
		
		return jdbcTemplate.update(sql, param) > 0;
		}
	
	public boolean delete(String memberId) {
		String sql = "delete member where member_id = ?";
		Object[] param = {memberId};
		return jdbcTemplate.update(sql,param) > 0;
	}
	
	public String findId(MemberDto memberDto) {
		String sql = "select member_id from member where member_nick = ? and member_tel = ? and member_birth = ?";
		Object[]param = {memberDto.getMemberNick(), memberDto.getMemberTel(), memberDto.getMemberBirth()};
		return jdbcTemplate.queryForObject(sql, String.class, param);
	}

	public MemberDto selectByNickname(String memberNick) {
		String sql = "select * from member where member_nick = ?";
		Object[] param = {memberNick};
		List<MemberDto> list = jdbcTemplate.query(sql, mapper, param);
		return list.isEmpty() ? null : list.get(0);
	}
	
	public MemberDto selectByEmail(String memberEmail) {
		String sql = "select * from member where member_email = ?";
		Object[] param = {memberEmail};
		List<MemberDto> list = jdbcTemplate.query(sql, mapper, param);
		return list.isEmpty() ? null : list.get(0);
	}
	
	//탈퇴 예정 회원 정보 담아두기
	public void wating(String memberId) {
		String sql = "insert into wating select*from member where member_id=?";
		Object[] param = {memberId};
		jdbcTemplate.update(sql,param);
	}
	
	//관리자용 회원 정보 변경
	public boolean changeInformationByAdmin(MemberDto memberDto) {
		String sql = "update member set "
						+ "member_nick=?, member_tel=?, "
						+ "member_email=?, member_birth=?, "
						+ "member_post=?, member_basic_addr=?, "
						+ "member_detail_addr=? , member_level=? "
						+ "where member_id = ?";
		Object[] param = {
			memberDto.getMemberNick(), memberDto.getMemberTel(),
			memberDto.getMemberEmail(), memberDto.getMemberBirth(),
			memberDto.getMemberPost(), memberDto.getMemberBasicAddr(),
			memberDto.getMemberDetailAddr(), memberDto.getMemberLevel(),
			 memberDto.getMemberId()
		};
		return jdbcTemplate.update(sql, param) > 0;
	}

}