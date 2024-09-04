package com.example.test1.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.test1.mapper.ChartMapper;
import com.example.test1.model.Area;
import com.example.test1.model.Chart;

@Service
public class ChartServiceImpl implements ChartService {

	@Autowired
	ChartMapper chartMapper;


	@Override

	public HashMap<String, Object> searchChartList(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap();
		List<Chart> list = chartMapper.searchChartList(map);
		System.out.println(list);
		resultMap.put("list", list);
		resultMap.put("result", "success");
		return resultMap;
	}


	@Override
	public HashMap<String, Object> searchArea(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap();
		List<Area> list = chartMapper.searchArea(map);
		
		System.out.println(map);
		resultMap.put("list", list);
		resultMap.put("result", "success");
		return resultMap;	
	}



}
