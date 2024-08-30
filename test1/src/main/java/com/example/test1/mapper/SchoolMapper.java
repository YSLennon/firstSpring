package com.example.test1.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.test1.model.SchoolStudent;

@Mapper
public interface SchoolMapper {
	List<SchoolStudent> searchSchool(HashMap<String, Object> map);
	SchoolStudent searchView(HashMap<String, Object> map);
	
}
