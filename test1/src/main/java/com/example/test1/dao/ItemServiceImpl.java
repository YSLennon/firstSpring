package com.example.test1.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.exceptions.PersistenceException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import com.example.test1.constants.ResMessage;
import com.example.test1.mapper.ItemMapper;
import com.example.test1.model.Item;

// DAO는 SQL Exception이 발생했을 때 예외에대한 처리를 해야한다. 에러검출 부분도 분리되어있다.

@Service
public class ItemServiceImpl implements ItemService{

	@Autowired
	ItemMapper itemMapper;


	@Override
	public HashMap<String, Object> searchItem(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap();
		
		try {
			List<Item> list = itemMapper.searchItem(map);
			List<Item> codeList = itemMapper.searchCodes(map);
			
			resultMap.put("result", true);
			resultMap.put("message", ResMessage.SUCCESS);
			resultMap.put("list", list);
			resultMap.put("codeList", codeList);
			
		} catch(DataAccessException e ) {
			resultMap.put("result", false);
			resultMap.put("message", "데이터 베이스 접근 에러"); 
			String str = ResMessage.DB_ACCESS_ERROR;
			
		} catch(PersistenceException e ) {
			resultMap.put("result", false);
			resultMap.put("message", "Mybatis sql 구문 에러");
			String str = ResMessage.MYBATIS_ERROR;
			
		} catch(Exception e) {
			System.out.println("Exception : " + e);
			resultMap.put("result", false);
			resultMap.put("message", "알 수 없는 에러");
			String str = ResMessage.UNKNOWN_ERROR;
		}


		
		return resultMap;
	}

	
}
