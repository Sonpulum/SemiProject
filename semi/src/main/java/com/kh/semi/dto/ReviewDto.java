package com.kh.semi.dto;

import lombok.Data;

@Data
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
}
