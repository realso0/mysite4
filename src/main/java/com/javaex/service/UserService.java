package com.javaex.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.javaex.dao.UserDao;
import com.javaex.vo.UserVo;

@Service
public class UserService {

	@Autowired
	private UserDao userDao;
	
	public int join(UserVo userVo) {
		if(userDao.getUser(userVo.getEmail())==null) {
			if ((userVo.getPassword().length()>7) && (userVo.getPassword().length()<21)) {
				return userDao.insert(userVo);
			}
			else return 0;
		}
		return 0;
		
	}
	
	public UserVo login(String email, String password) {
		return userDao.getUser(email, password);
	}
	
	public UserVo getUser(int no) {
		return userDao.getUser(no);
	}
	
	public int modify(UserVo userVo) {
		if(userVo.getPassword()!=null || userVo.getPassword()!="") {
			return userDao.update(userVo);
		} else {
			return 0;
		}
	}
	
	public boolean emailChk(String email) { //true, false로 값을 바꿔줌.
		boolean result;
		UserVo userVo=userDao.getUser(email);
		System.out.println(userVo);
		if (userVo!=null) { //이미 db에 있으면 result=false
			result=false; //false==0
		} else {
			result=true;
		}
		return result;
	}
}
