package com.kh.semi.dto;

import java.sql.Date;
import java.text.SimpleDateFormat;

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
	private int recoLike;
	private int recoRead;
	private Date recoTime;
	private String recoAddr;
	private int attachNo;
	
	public String getTimeConvert() {
		java.util.Date now = new java.util.Date();
		java.util.Date write = new java.util.Date(recoTime.getTime());
		SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		
		String nowStr = f.format(now);
		String writeStr = f.format(write);
		
		if(nowStr.substring(0,10).equals(writeStr.substring(0,10))) {
			return writeStr.substring(11); // HH:mm
		}
		else {
			return writeStr.substring(0,10); // yyyy-MM-dd
		}
	}
}
