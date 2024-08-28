package com.example.test1.dao;

import java.util.HashMap;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.test1.mapper.UserMapper;
import com.example.test1.model.User;

import net.nurigo.sdk.NurigoApp;
import net.nurigo.sdk.message.exception.NurigoMessageNotReceivedException;
import net.nurigo.sdk.message.model.Message;
import net.nurigo.sdk.message.service.DefaultMessageService;

@Service
public class UserServiceImpl implements UserService {
//TODO 매퍼 다시 살려야함
	@Autowired
	UserMapper userMapper;

	private int makeConfirmNumbAndSendMessage(Object phoneNumb) {
		// TODO API키랑 시크릿 키는 지워둬야함
		DefaultMessageService messageService = NurigoApp.INSTANCE.initialize("ss",
				"ss", "https://api.coolsms.co.kr");
		// Message 패키지가 중복될 경우 net.nurigo.sdk.message.model.Message로 치환하여 주세요

		Random random = new Random();
		int randomInt = random.nextInt(100000, 1000000);
		Message message = new Message();
		message.setFrom("01000000000");
		message.setTo(String.valueOf(phoneNumb));
		message.setText("비밀번호 확인을 위한 인증번호입니다. 절대 타인에게 공유하지마세요. 인증번호 : " + randomInt);

		try {
			// send 메소드로 ArrayList<Message> 객체를 넣어도 동작합니다!
			messageService.send(message);
		} catch (NurigoMessageNotReceivedException exception) {
			// 발송에 실패한 메시지 목록을 확인할 수 있습니다!
			System.out.println(exception.getFailedMessageList());
			System.out.println(exception.getMessage());
		} catch (Exception exception) {
			System.out.println(exception.getMessage());
		}

		return randomInt;
	}

	@Override
	public HashMap<String, Object> makeConfirmNumbWithAPI(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap();
		int confirmNumb = makeConfirmNumbAndSendMessage(map.get("userPhone"));
		resultMap.put("confirmNumb", confirmNumb);

		return resultMap;
	}

	@Override
	public HashMap<String, Object> dupEx(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<>();
		System.out.println(map);
		User user = userMapper.dupEx(map);

		if (user == null) {
			resultMap.put("result", true);
		} else {
			resultMap.put("result", false);
		}
		return resultMap;
	}

	@Override
	public HashMap<String, Object> join(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<>();
		try {
			userMapper.join(map);
			resultMap.put("result", true);
			resultMap.put("message", "회원가입에 성공했습니다");
		} catch (Exception e) {
			System.out.println("Exception e : " + e);
			resultMap.put("result", false);
			resultMap.put("message", "회원가입에 실패했습니다");
		}
		return resultMap;
	}

	@Override
	public HashMap<String, Object> login(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		System.out.println(map);
		HashMap<String, Object> resultMap = new HashMap<>();
		User user = userMapper.login(map);
		String message;
		boolean result = false;
		if (user == null) {
			message = "아이디가 존재하지 않습니다";
		} else if (map.get("pwd").equals(user.getPwd())) {
			result = true;
			message = "로그인에 성공했습니다.";
		} else {
			message = "비밀번호가 일치하지않습니다.";
		}
		resultMap.put("message", message);
		resultMap.put("result", result);

		return resultMap;
	}

}
