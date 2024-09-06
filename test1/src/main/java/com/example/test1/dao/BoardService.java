package com.example.test1.dao;

import java.util.HashMap;
import java.util.List;

import com.example.test1.model.Board;

public interface BoardService {

	HashMap<String, Object> searchBoardList(HashMap<String, Object> map);
	HashMap<String, Object> removeBoard(HashMap<String, Object> map);
	HashMap<String, Object> fnCheckRemove(HashMap<String, Object> map);
	HashMap<String, Object> insertBoard(HashMap<String, Object> map);
	HashMap<String, Object> viewBoard(HashMap<String, Object> map);
	void insertBoardFile(HashMap<String, Object> map);

}
