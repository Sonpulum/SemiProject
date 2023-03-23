package com.kh.semi.dto;

import lombok.Data;

@Data
public class RecommendDto {
	private int recoNo;
	private String recoWriter;
	private String recoTitle;
	private String recoContent;
	private String recoTheme;
	private String recoLocation;
	private String recoSeason;
}
