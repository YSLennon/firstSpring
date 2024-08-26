package com.example.test1.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.test1.mapper.StudentMapper;
import com.example.test1.model.EMP;
import com.example.test1.model.Student;

// DAO는 SQL Exception이 발생했을 때 예외에대한 처리를 해야한다. 에러검출 부분도 분리되어있다.

@Service
public class StudentServiceImpl implements StudentService{

	@Autowired
	StudentMapper studentMapper;
	
	@Override
	public List<Student> searchStudentList() {
		// TODO Auto-generated method stub
		return studentMapper.selectStudentList();
	}

	@Override
	public Student searchQwer() {
		// TODO Auto-generated method stub
		return studentMapper.qwer();
	}

	@Override
	public HashMap<String, Object> searchNumb(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap();
		try {
		Student stu = studentMapper.searchNumb(map);
		resultMap.put("stu", stu);
		resultMap.put("result", "success");
		String msg = (stu != null)?"조회했습니다!":"학번을 확인해주세요";
		resultMap.put("message", msg);
		} catch(Exception e){
			System.out.println("SQLExcetpion : " + e);
			resultMap.put("result", "false");
			resultMap.put("message", "DB조회 오류");

		}
		
		return resultMap; 
	}

	@Override
	public List<EMP> searchEMP() {
		// TODO Auto-generated method stub
		List<EMP> list = studentMapper.searchEMP();
		System.out.println(list.get(0));
		return list;
	}

	@Override
	public HashMap<String, List<Student>> searchSubject() {
		// TODO Auto-generated method stub
		List<Student> subList = studentMapper.searchSubject();
		List<Student> stuList = studentMapper.selectStudentList();
		HashMap<String, List<Student>> resultMap = new HashMap();
		resultMap.put("subList", subList);
		resultMap.put("stuList", stuList);
		
		
		return resultMap;
	}
	
	
}
