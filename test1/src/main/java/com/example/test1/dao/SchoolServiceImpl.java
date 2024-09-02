package com.example.test1.dao;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.test1.mapper.SchoolMapper;
import com.example.test1.model.SchoolStudent;

@Service
public class SchoolServiceImpl implements SchoolService {

	@Autowired
	SchoolMapper schoolMapper;

	@Autowired
	HttpSession session;

	@Override
	public HashMap<String, Object> searchSchool(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap();
		try {
			System.out.println(map);

			List<SchoolStudent> list = schoolMapper.searchSchool(map);
			int cntSchool = schoolMapper.cntSchool(map);
			resultMap.put("list", list);
			resultMap.put("cntSchool", cntSchool);
			resultMap.put("result", true);
		} catch(Exception e) {
			System.out.println("Exception : "+ e);
			resultMap.put("result", false);
			
		}
		return resultMap;			
	}

	@Override
	public HashMap<String, Object> searchView(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap();
		try {
			SchoolStudent schoolStudent = schoolMapper.searchView(map);
			resultMap.put("list", schoolStudent);
			resultMap.put("result", true);
		} catch(Exception e) {
			System.out.println("Exception : "+ e);
			resultMap.put("result", false);
			
		}
		return resultMap;	
	}

}
