package com.kh.semi.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @Builder @NoArgsConstructor @AllArgsConstructor
public class ReviewReplyDto {
	private int reviewReplyNo;
	private String reviewReplyWriter;
	private int reviewReplyOrigin;
	private String reviewReplyContent;
	private Date reviewReplyTime;
	private String memberNick;
}
