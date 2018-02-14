package com.javaex.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.javaex.vo.FileuploadVo;

@Repository
public class FileuploadDao {

	@Autowired
	private SqlSession sqlSession;
	
	public int insertUpload(FileuploadVo fileUploadVo) {
		System.out.println("dao진입");
		return sqlSession.insert("fileupload.insertUpload", fileUploadVo);
	}
}
