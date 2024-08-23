package com.example.test1.dao;

import java.util.HashMap;
import java.util.List;

import com.example.test1.model.EMP;
import com.example.test1.model.Student;

public interface StudentService {
	// 게시글 조회
	List<Student> searchStudentList(HashMap<String, Object> map);
	Student searchQwer();
	HashMap<String, Object> searchNumb(HashMap<String,Object> map);
	List<EMP> searchEMP();
	
}
