package com.example.test1.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.test1.model.Board;

@Mapper
public interface BoardMapper {
	List<Board> searchBoardList(HashMap<String, Object> map);
	int removeBoard(HashMap<String, Object> map);
	int insertBoard(HashMap<String, Object> map);
}
