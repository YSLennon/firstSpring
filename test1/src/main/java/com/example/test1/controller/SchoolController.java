package com.example.test1.controller;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.test1.dao.SchoolService;
import com.google.gson.Gson;

@Controller
public class SchoolController {
	
	@Autowired
	SchoolService schoolService;
	
	@RequestMapping("school/stu.do")
	public String main(Model model) throws Exception{
		return "/school.stu";
	}	
	@RequestMapping("school/detail.do")
	public String detail(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		request.setAttribute("stuNo", map.get("stuNo"));
		return "/school.stuView";
	}	

	
	
	@RequestMapping(value = "/school/list.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String boardList(Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		HashMap<String, Object> resultMap = schoolService.searchSchool(map);
		return new Gson().toJson(resultMap);	
	}
	@RequestMapping(value = "/school/view.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String searchView(Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		HashMap<String, Object> resultMap = schoolService.searchView(map);
		return new Gson().toJson(resultMap);	
	}

}
