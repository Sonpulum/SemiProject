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
      if(vo.isSearch()) {//검색
         String sql = "select * from ("
                  + "select rownum rn, TMP.* from ("
                     + "select * from qna "
                     + "where instr(#1, ?) > 0 "
                     + "connect by prior qna_no = qna_parent "
                     + "start with qna_parent is null "
                     + "order siblings by qna_group desc, qna_no asc"
                  + ")TMP"
               + ")where rn between ? and ?";
         sql = sql.replace("#1", vo.getColumn());
         Object[] param = {vo.getKeyword(), vo.getBegin(), vo.getEnd()};
         return jdbcTemplate.query(sql, mapper, param);
      }
      else {//목록
         String sql = "select * from ("
                  + "select rownum rn, TMP.* from ("
                     + "select * from qna "
                     + "connect by prior qna_no = qna_parent "
                     + "start with qna_parent is null "
                     + "order siblings by qna_group desc, qna_no asc"
                  + ")TMP"
               + ")where rn between ? and ?";
         Object[] param = {vo.getBegin(), vo.getEnd()};
         return jdbcTemplate.query(sql, mapper, param);   
      }
   }
   
   //페이징 적용된 조회 및 카운트
   public int selectCount(QnaPaginationVO vo) {
      if(vo.isSearch()) {//검색
         String sql = "select count(*) from qna where instr(#1, ?) > 0";
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
		String sql = "select * from("
					+ "select rownum rn, TMP.* from("
							+ "select * from qna where qna_head = '공지' "
							+ "order by qna_no desc"
						+ ")TMP"
				+ ")where rn between ? and ?";
		Object[] param = {begin, end};
		return jdbcTemplate.query(sql, mapper, param);
		
	}
}