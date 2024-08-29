package com.example.test1.controller;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.test1.dao.BoardService;
import com.example.test1.model.Board;
import com.google.gson.Gson;

@Controller
public class BoardController {
	
	@Autowired
	BoardService boardService;
	
	@RequestMapping("board/list.do")
	public String main(Model model) throws Exception{
		return "/board-list";
	}	
	@RequestMapping("board/insert.do")
	public String maininsert(Model model) throws Exception{
		return "/board-insert";
	}

	
	
	@RequestMapping(value = "/board/list.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String boardList(Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		HashMap<String, Object> resultMap= boardService.searchBoardList(map);
		return new Gson().toJson(resultMap);	
	}
	@RequestMapping(value = "/board/remove.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String removeBoard(Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		HashMap<String, Object> resultMap= boardService.removeBoard(map);
		return new Gson().toJson(resultMap);
	}
	@RequestMapping(value = "/board/insert.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String insertBoard(Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		HashMap<String, Object> resultMap= boardService.insertBoard(map);
		return new Gson().toJson(resultMap);
	}
}
