package com.kh.semi.dto;

import java.sql.Date;
import java.text.SimpleDateFormat;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @Builder @NoArgsConstructor @AllArgsConstructor
public class ReviewDto {
	private int reviewNo;
	private String reviewWriter;
	private String reviewSeason;
	private String reviewTheme;
	private String reviewLocation;
	private String reviewTitle;
	private String reviewContent;
	private String reviewReply;
	private int reviewRead;
	private int reviewLike;
	private Date reviewTime;


//게시글 시각
public String getReviewTimeAuto() {
   java.util.Date now = new java.util.Date();
   java.util.Date write = new java.util.Date(reviewTime.getTime());
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
}