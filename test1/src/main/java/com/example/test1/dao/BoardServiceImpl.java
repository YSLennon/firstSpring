package com.example.test1.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.test1.mapper.BoardMapper;
import com.example.test1.model.Board;

@Service
public class BoardServiceImpl implements BoardService {

	@Autowired
	BoardMapper boardMapper;

	@Override
	public HashMap<String, Object> searchBoardList(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap();
		List<Board> list = boardMapper.searchBoardList(map);
		resultMap.put("list", list);
		resultMap.put("result", "success");
		return resultMap;
	}

	@Override
	public HashMap<String, Object> removeBoard(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap();
		try {
			int removedNo = boardMapper.removeBoard(map);
			resultMap.put("message", "삭제되었습니다.");
			resultMap.put("result", true);
		} catch (Exception e) {
			resultMap.put("message", "삭제에 실패하였습니다.");
			resultMap.put("result", false);
			System.out.println("Exception : " + e);
		}
		return resultMap;
	}

	@Override
	public HashMap<String, Object> insertBoard(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap();
		try {
			int insertBoard = boardMapper.insertBoard(map);
			System.out.println("insertBoard: "+insertBoard);
			resultMap.put("message", "작성되었습니다.");
			resultMap.put("result", true);
		} catch (Exception e) {
			resultMap.put("message", "작성에 실패하였습니다.");
			resultMap.put("result", false);
			System.out.println("Exception : " + e);
		}
		return resultMap;
	}

}
