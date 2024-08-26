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

import com.example.test1.dao.StudentService;
import com.example.test1.model.EMP;
import com.example.test1.model.Student;
import com.google.gson.Gson;

@Controller
public class StudentController {
	
	@Autowired
	StudentService studentService;
	
	@RequestMapping("/student.do") 
    public String main(Model model) throws Exception{
         return "/student-list";
    }
	
	@RequestMapping("/test.do")
	public String test(Model model) throws Exception{
		return "test";
	}
	@RequestMapping("/emp.do")
	public String testEmp(Model model) throws Exception{
		return "emp-list";
	}
	@RequestMapping("/subject.do")
	public String testSubject(Model model) throws Exception{
		return "subject-list";
	}
	
	@RequestMapping(value = "/list.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String searchBbsList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		List<Student> list = studentService.searchStudentList();
		resultMap.put("list", list);
		resultMap.put("result", "success");
		return new Gson().toJson(resultMap);
	}
	@RequestMapping(value = "/ok.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String qwer(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		Student stu = studentService.searchQwer();
		resultMap.put("stu", stu);
		resultMap.put("result", "success");
		return new Gson().toJson(resultMap);
	}
	@RequestMapping(value = "/search.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String searchNumb(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = studentService.searchNumb(map);

		return new Gson().toJson(resultMap);
	}
	@RequestMapping(value = "/empList.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String printEmp(Model model, @RequestParam HashMap<String, Object> map) throws Exception {

		List<EMP> list = studentService.searchEMP();

		return new Gson().toJson(list);
	}
	@RequestMapping(value = "/subject-list.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String printSubject(Model model, @RequestParam HashMap<String, Object> map) throws Exception {

		HashMap<String, List<Student>> resultMap = studentService.searchSubject();

		return new Gson().toJson(resultMap);
	}
}


