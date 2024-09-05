package com.example.test1.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.test1.model.Board;
import com.example.test1.model.Comment;

@Mapper
public interface BoardMapper {
	int cntBoardList(HashMap<String, Object> map);
	List<Board> searchBoardList(HashMap<String, Object> map);
	Board viewBoard(HashMap<String, Object> map);
	List<Comment> viewBoardComment(HashMap<String, Object> map);
	int removeBoard(HashMap<String, Object> map);
	int insertBoard(HashMap<String, Object> map);
	void insertBoardFile(HashMap<String, Object> map);
	
}
