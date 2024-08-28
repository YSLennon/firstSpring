package com.example.test1.dao;

import java.util.HashMap;
import java.util.List;

import com.example.test1.model.Board;

public interface UserService {

	HashMap<String, Object> makeConfirmNumbWithAPI(HashMap<String, Object> map);
	HashMap<String, Object> dupEx(HashMap<String, Object> map);
	HashMap<String, Object> join(HashMap<String, Object> map);
	HashMap<String, Object> login(HashMap<String, Object> map);
	

}
