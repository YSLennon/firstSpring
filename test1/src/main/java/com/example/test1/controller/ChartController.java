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

import com.example.test1.dao.ChartService;
import com.google.gson.Gson;

@Controller
public class ChartController {
	
	@Autowired
	ChartService chartService;
	
	@RequestMapping("chart.do")
	public String chart(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		return "/chart";
	}
	@RequestMapping("hi.do")
	public String charthi(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		return "/hi";
	}
	@RequestMapping("area.do")
	public String area(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		return "/area";
	}

	
	
	@RequestMapping(value = "/area.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String asd(Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		HashMap<String, Object> resultMap= chartService.searchArea(map);
		return new Gson().toJson(resultMap);	
	}
}
