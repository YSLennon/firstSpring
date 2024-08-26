package com.example.test1.dao;

import java.util.HashMap;
import java.util.List;

import com.example.test1.model.EMP;
import com.example.test1.model.Student;

public interface StudentService {
	// 게시글 조회
	List<Student> searchStudentList();
	Student searchQwer();
	HashMap<String, Object> searchNumb(HashMap<String,Object> map);
	List<EMP> searchEMP();
	HashMap<String, List<Student>> searchSubject();

	
}
