package com.example.test1.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.test1.model.EMP;
import com.example.test1.model.Student;

@Mapper
public interface StudentMapper {
	List<Student> selectStudentList();
	Student qwer();
	Student searchNumb(HashMap<String, Object> map);
	List<EMP> searchEMP();
	List<Student> searchSubject();

}
