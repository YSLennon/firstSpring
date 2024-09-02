package com.example.test1.model;

import lombok.Data;

@Data
public class Comment {
	private int commentNo;
	private int boardNo;
	private String contents;
	private String userId;
	private int favorite;
	private int pCommentNo;
	private String cDateTime;
	private String uDateTime;
}
