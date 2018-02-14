package com.javaex.dao;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.javaex.vo.UserVo;

@Repository
public class UserDao {
	
	@Autowired
	private SqlSession sqlSession;
	
	public int insert(UserVo userVo) {
		return sqlSession.insert("user.insert", userVo);
//		int count=sqlSession.insert("guestbook.insert", guestbookVo);
//		System.out.println(count); //1건 추가완료 됬는다는 것을 출력함.
	}
	
	public UserVo getUser(String email, String password) {
		Map<String, Object> userMap=new HashMap<String, Object>();
		userMap.put("email", email);
		userMap.put("password", password);
		
		System.out.println(userMap.toString());
		return sqlSession.selectOne("user.getListByEmailPw", userMap);
	}
	
	public UserVo getUser(int no) {
		return sqlSession.selectOne("user.getListByNo", no);
	}
	
	public int update(UserVo userVo) {
		System.out.println(userVo.toString());
		return sqlSession.update("user.update", userVo);
	}
	
	public UserVo getUser(String email) {
		UserVo userVo=sqlSession.selectOne("user.getListByEmail", email);
		return userVo;
	}
	
}
