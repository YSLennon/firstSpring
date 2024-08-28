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

import com.example.test1.dao.UserService;
import com.example.test1.model.Student;
import com.google.gson.Gson;

@Controller
public class UserController {
	
	@Autowired
	UserService userService;

	@RequestMapping("/user/confirm.do") 
    public String confirm(Model model) throws Exception{
         return "/confirmUserPage";
    }
	@RequestMapping("/user/join.do") 
    public String join(Model model) throws Exception{
         return "/join";
    }
	@RequestMapping("/user/login.do") 
	public String login(Model model) throws Exception{
		return "/login";
	}




	@RequestMapping(value = "/user/dupEx.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String dupEx(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = userService.dupEx(map);
		return new Gson().toJson(resultMap);
	}
	@RequestMapping(value = "/user/join.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String join(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = userService.join(map);
		return new Gson().toJson(resultMap);
	}
	@RequestMapping(value = "/user/login.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String login(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = userService.login(map);
		return new Gson().toJson(resultMap);
	}
	@RequestMapping(value = "/user/confirm.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String confirmMessage(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = userService.makeConfirmNumbWithAPI(map);
		resultMap.put("result", "success");
		return new Gson().toJson(resultMap);
	}

}


