package com.example.test1.model;

import lombok.Data;

@Data
public class Board {
	private int boardNo;
	private String title;
	private String contents;
	private String userId;
	private int hit;
	private String category;
	private String favorite;
	private String tag1;
	private String tag2;
	private String noticeYN;
	private String cDatetime;
	private String uDatetime;
	
}
