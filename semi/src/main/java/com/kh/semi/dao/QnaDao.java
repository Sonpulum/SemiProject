package com.kh.semi.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.kh.semi.dto.QnaDto;
import com.kh.semi.vo.QnaPaginationVO;

@Repository
public class QnaDao {

   @Autowired
   private JdbcTemplate jdbcTemplate;
   
   private RowMapper<QnaDto> mapper = new RowMapper<QnaDto>() {
      @Override
      public QnaDto mapRow(ResultSet rs, int idx) throws SQLException {
         QnaDto qnaDto = new QnaDto();
         qnaDto.setQnaNo(rs.getInt("qna_no"));
         qnaDto.setQnaHead(rs.getString("qna_head"));
         qnaDto.setQnaWriter(rs.getString("qna_writer")); 
         qnaDto.setQnaTitle(rs.getString("qna_title"));
         qnaDto.setQnaContent(rs.getString("qna_content"));
         qnaDto.setQnaTime(rs.getDate("qna_time"));
         qnaDto.setQnaRead(rs.getInt("qna_read"));
         qnaDto.setQnaLike(rs.getInt("qna_like"));
         qnaDto.setQnaSecret(rs.getBoolean("qna_secret"));
         qnaDto.setQnaGroup(rs.getInt("qna_group"));
         qnaDto.setQnaParent(rs.getObject("qna_parent") == null ?
               null : rs.getInt("qna_parent"));
         qnaDto.setQnaDepth(rs.getInt("qna_depth"));
         qnaDto.setQnaAnswer(rs.getInt("qna_answer"));
         return qnaDto;
      }
   };
   
   //리스트 전용 매퍼
   private RowMapper<QnaDto> mapper2 = new RowMapper<QnaDto>() {
	      @Override
	      public QnaDto mapRow(ResultSet rs, int idx) throws SQLException {
	         QnaDto qnaDto = new QnaDto();
	         qnaDto.setQnaNo(rs.getInt("qna_no"));
	         qnaDto.setQnaHead(rs.getString("qna_head"));
	         qnaDto.setQnaWriter(rs.getString("qna_writer"));
	         qnaDto.setMemberNick(rs.getString("member_nick"));
	         qnaDto.setQnaTitle(rs.getString("qna_title"));
	         qnaDto.setQnaContent(rs.getString("qna_content"));
	         qnaDto.setQnaTime(rs.getDate("qna_time"));
	         qnaDto.setQnaRead(rs.getInt("qna_read"));
	         qnaDto.setQnaLike(rs.getInt("qna_like"));
	         qnaDto.setQnaSecret(rs.getBoolean("qna_secret"));
	         qnaDto.setQnaGroup(rs.getInt("qna_group"));
	         qnaDto.setQnaParent(rs.getObject("qna_parent") == null ?
	               null : rs.getInt("qna_parent"));
	         qnaDto.setQnaDepth(rs.getInt("qna_depth"));
	         qnaDto.setQnaAnswer(rs.getInt("qna_answer"));
	         return qnaDto;
	      }
	   };
   
   //시퀀스
   public int sequence() {
      String sql = "select qna_seq.nextVal from dual";
      return jdbcTemplate.queryForObject(sql, int.class);
   }
   
   //Q&A 작성
   public void insert(QnaDto qnaDto) {
      String sql = "insert into qna(qna_no, qna_head, qna_writer, qna_title, "
            + "qna_content, qna_time, qna_read, "
            + "qna_like, qna_secret, qna_group, "
            + "qna_parent, qna_depth, qna_answer) "
            + "values(?, ?, ?, ?, ?, sysdate, 0, 0, ?, ?, ?, ?, ?)";
      Object[] param = {
            qnaDto.getQnaNo(), qnaDto.getQnaHead(), qnaDto.getQnaWriter(), qnaDto.getQnaTitle(),
            qnaDto.getQnaContent(), qnaDto.isQnaSecret(), qnaDto.getQnaGroup(), 
            qnaDto.getQnaParent(), qnaDto.getQnaDepth(), qnaDto.getQnaAnswer()};
      jdbcTemplate.update(sql, param);
   }
  
   //Q&A 목록
   public List<QnaDto> selectList(QnaPaginationVO vo) {
	   String sql = "";
	   Object[] param = null;
	      
	   if(vo.getSort().equals("공지")) {
           sql = "where qna_head = '공지'";
	   }
	   else if (vo.getSort().equals("질문")) {
		   sql = "where qna_head = '질문'";
	   }
	   else if (vo.getSort().equals("회원")) {
		   sql = "where qna_head = '회원'";
	   }
	   else if (vo.getSort().equals("혜택/이벤트")) {
           sql = "where qna_head = '혜택/이벤트'";
	   }
	   else if (vo.getSort().equals("제휴/서비스")) {
           sql = "where qna_head = '제휴/서비스'";
	   }
	   else if (vo.getSort().equals("기타")) {
           sql = "where qna_head = '기타'";
	   }
	   else {
           sql = "";
	   }
	   
	  if(vo.isSearch()) {//검색
		  sql = "select * from "
		  		+ "(select rownum rn, TMP.* from "
		  		+ "(select Q.*, M.member_nick from "
		  		+ "qna Q left outer join "
		  		+ "member M on Q.qna_writer = M.member_id "
		  		+ "where instr(#1,?) >0 connect by prior Q.qna_no = Q.qna_parent "
		  		+ "start with Q.qna_parent is null "
		  		+ "order siblings by Q.qna_group desc, Q.qna_no asc) "
		  		+ "TMP "
		  		//+ sql
		  		+ " ) "
		  		+ "where rn between ? and ?";
		  sql = sql.replace("#1", vo.getColumn());
		  param = new Object[] {vo.getKeyword(), vo.getBegin(), vo.getEnd()};
	  }
	  
      else {//목록
         sql = "select * from "
         		+ "(select rownum rn, TMP.* from "
         		+ "(select Q.*, M.member_nick from "
         		+ "qna Q left outer join "
         		+ "member M on Q.qna_writer = M.member_id "
         		+ "connect by prior Q.qna_no = Q.qna_parent "
         		+ "start with Q.qna_parent is null "
         		+ "order siblings by Q.qna_group desc, Q.qna_no asc) "
         		+ "TMP " 
         		+ sql 
         		+ ") "
         		+ "where rn between ? and ?";
         param = new Object[] {vo.getBegin(), vo.getEnd()};
      }
	  return jdbcTemplate.query(sql, mapper2, param);   
   }
   
   //페이징 적용된 조회 및 카운트
   public int selectCount(QnaPaginationVO vo) {
      if(vo.isSearch()) {//검색
         String sql = "select count(*) from qna Q left outer join member M on Q.qna_writer = M.member_id where instr(#1, ?) > 0";
         sql = sql.replace("#1", vo.getColumn());
         Object[] param = {vo.getKeyword()};
         return jdbcTemplate.queryForObject(sql, int.class, param);
      }
      else {//목록
         String sql = "select count(*) from qna";
         return jdbcTemplate.queryForObject(sql, int.class);
      }
   }
   
   //Q&A 상세
   public QnaDto selectOne(int qnaNo) {
      String sql = "select * from qna where qna_no = ?";
      Object[] param = {qnaNo};
      List<QnaDto> list = jdbcTemplate.query(sql, mapper, param);
      return list.isEmpty() ? null : list.get(0);
   }
   
   //첨부 파일 번호와 글 번호 연결
   public void connect(int qnaNo, int attachmentNo) {
      String sql ="insert into qna_attachment values(?, ?)";
      Object[] param = {qnaNo, attachmentNo};
      jdbcTemplate.update(sql, param);
   }
   
   //조회수 증가
   public boolean updateReadcount(int qnaNo) {
      String sql = "update qna set qna_read = qna_read + 1 "
            + "where qna_no = ?";
      Object[] param = {qnaNo};
      return jdbcTemplate.update(sql, param) > 0;
   }
   
   	//Q&A 게시글 삭제
   public boolean delete(int qnaNo) {
 		String sql ="delete qna where qna_no = ?";
 		Object[] param = {qnaNo};
 		return jdbcTemplate.update(sql, param) > 0;
 	}
 	
 	//Q&A 게시글 수정
	public boolean edit(QnaDto qnaDto) {
		String sql = "update qna set qna_head = ?, qna_title = ?, qna_content = ? where qna_no = ?";
		Object[] param = {qnaDto.getQnaHead(), qnaDto.getQnaTitle(), qnaDto.getQnaContent(), qnaDto.getQnaNo()};
		return jdbcTemplate.update(sql, param) > 0;
	}
	
	//Q&A 답글 개수 카운트
	public boolean update(QnaDto qnaDto) {
		String sql = "update qna set qna_answer = qna_answer + 1 where qna_no = ?";
		Object[] param = {qnaDto.getQnaNo()};
		return jdbcTemplate.update(sql, param) > 0;
	}
	
	//공지사항만 조회하는 기능
	public List<QnaDto> selectNoticeList(int begin, int end) {
		String sql = "SELECT * "
				+ "FROM ( "
				+ "  SELECT ROWNUM rn, TMP.*, m.member_nick "
				+ "  FROM ( "
				+ "    SELECT *"
				+ "    FROM qna "
				+ "    WHERE qna_head = '공지' "
				+ "    ORDER BY qna_no DESC "
				+ "  ) TMP "
				+ "  LEFT OUTER JOIN member m ON TMP.qna_writer = m.member_id "
				+ " ) "
				+ "WHERE rn BETWEEN ? AND ?";
		Object[] param = {begin, end};
		return jdbcTemplate.query(sql, mapper2, param);
	}
}