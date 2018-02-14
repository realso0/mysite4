package com.javaex.api.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.javaex.service.UserService;

@Controller //다른 controller는 상위 mapping 되어있으므로, 따로 패키지를 만들어, 이곳저곳의 service로부터, 값을 받는 패키지를 만듬.
public class ApiUserController { //비동기 방식 데이터만 넘기는 것들만 따로 모아둔 곳.

	@Autowired
	private UserService userService;

//  기존 방식 요청
	@ResponseBody //response body에 넣어서 보냄.
	@RequestMapping(value="/user/api/emailchk",method=RequestMethod.POST)
	public boolean emailChk(@RequestParam("email") String email) { //화면에서 보낸 email을 받음.
		System.out.println(email);
		boolean result=userService.emailChk(email);
		
		System.out.println(result);
		return result;
	}
	
//  json방식 요청	
//	@ResponseBody
//	@RequestMapping(value="/user/api/emailchk")
//	public boolean emailChk(@RequestBody UserVo userVo) {
//		return userService.emailChk(userVo.getEmail());
//	}
}
