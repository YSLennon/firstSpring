package com.example.test1.dao;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.test1.mapper.BoardMapper;
import com.example.test1.model.Board;
import com.example.test1.model.Comment;

@Service
public class BoardServiceImpl implements BoardService {

	@Autowired
	BoardMapper boardMapper;

	@Autowired
	HttpSession session;

	@Override

	public HashMap<String, Object> searchBoardList(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap();
		int cntBoard = boardMapper.cntBoardList(map);
		List<Board> list = boardMapper.searchBoardList(map);
		
		resultMap.put("cntBoard", cntBoard);
		resultMap.put("list", list);
		resultMap.put("result", "success");
		return resultMap;
	}

	@Override
	public HashMap<String, Object> removeBoard(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap();
		try {
			if(session.getAttribute("userId").equals(map.get("userId"))) {
				int removedNo = boardMapper.removeBoard(map);
				resultMap.put("message", "삭제되었습니다.");
				resultMap.put("result", true);	
			} else {
				resultMap.put("message", "본인의 게시글만 삭제할 수 있습니다.");
				resultMap.put("result", false);	
				
			}
			
			
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
			System.out.println(map);
			map.put("userId", session.getAttribute("userId"));
			int insertBoard = boardMapper.insertBoard(map);
			resultMap.put("message", "작성되었습니다.");
			resultMap.put("idx", map.get("boardNo"));
			resultMap.put("result", true);
		} catch (Exception e) {
			resultMap.put("message", "작성에 실패하였습니다.");
			resultMap.put("result", false);
			System.out.println("Exception : " + e);
		}
		return resultMap;
	}

	@Override
	public HashMap<String, Object> viewBoard(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap();
		Board board = boardMapper.viewBoard(map);
		List<Comment> comment = boardMapper.viewBoardComment(map);
		resultMap.put("board", board);
		resultMap.put("comment", comment);
		resultMap.put("result", "success");
		return resultMap;

	}

	@Override
	public void insertBoardFile(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		try {
			System.out.println("hhhhhhhhhhh");
			boardMapper.insertBoardFile(map);
		} catch (Exception e) {
			System.out.println("Exception : " + e);
		}
	}
	@Override
	public HashMap<String, Object> fnCheckRemove(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap();
		try {
				int removedNo = boardMapper.fnCheckRemove(map);
				resultMap.put("message", "삭제되었습니다.");
				resultMap.put("result", true);	
						
		} catch (Exception e) {
			resultMap.put("message", "삭제에 실패하였습니다.");
			resultMap.put("result", false);
			System.out.println("Exception : " + e);
		}
		return resultMap;
	}


}
