package com.kh.semi.dto;

import java.sql.Date;
import java.text.SimpleDateFormat;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @Builder @NoArgsConstructor @AllArgsConstructor
public class QnaDto {

   private int qnaNo;
   private String qnaWriter;
   private String qnaTitle;
   private String qnaContent;
   private Date qnaTime;
   private int qnaRead;
   private int qnaLike;
   
   private int qnaGroup;
   private Integer qnaParent;
   private int qnaDepth;
   
   //게시글 시각
   public String getQnaTimeAuto() {
      java.util.Date now = new java.util.Date();
      java.util.Date write = new java.util.Date(qnaTime.getTime());
      SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd HH:mm");
      
      String nowStr = f.format(now);
      String writeStr = f.format(write);
      
      if(nowStr.substring(0, 10).equals(writeStr.substring(0, 10))) {
         return writeStr.substring(11);
      }
      else {
         return writeStr.substring(0, 10);
      }
   }
   
   //새글
   public boolean isNew() {
      return qnaParent == null;
   }
   
   //답글
   public boolean isAnswer() {
      return !isNew();
   }
}