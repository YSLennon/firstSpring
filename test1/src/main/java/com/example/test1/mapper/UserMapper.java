package com.example.test1.mapper;

import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

import com.example.test1.model.User;

@Mapper
public interface UserMapper {
	User dupEx(HashMap<String, Object> map);
	void join(HashMap<String, Object> map);
	User login(HashMap<String, Object> map);
}
