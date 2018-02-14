package com.javaex.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.javaex.vo.BoardVo;

@Repository
public class BoardDao {

	@Autowired
	private SqlSession sqlSession;
	
	public List<BoardVo> selectList(int startRnum, int endRnum, String kwd) {
		Map<String, Object> mapCri=new HashMap<String, Object>();
		mapCri.put("startRnum", startRnum);
		mapCri.put("endRnum", endRnum);
		mapCri.put("kwd", kwd);
		System.out.println("dao: "+mapCri.toString());
		return sqlSession.selectList("board.selectPage", mapCri); //입력값 없이 출력만 하는 select
	}
	
	public int selectTotalCount(String kwd) {
		return sqlSession.selectOne("board.totalCount", kwd);
	}
	
	public BoardVo selectforView(int no) {
		return sqlSession.selectOne("board.selectforView",no); //no를 입력값으로 넘기고, 하나만을 select해서 출력
	}
	
	public int updateHit(int no) {
		return sqlSession.update("board.updateHit",no);
	}
	
	public int delete(BoardVo boardVo) {
		return sqlSession.delete("board.delete",boardVo);
	}
	
	public int insert(BoardVo boardVo) {
		return sqlSession.insert("board.insert",boardVo);
	}
	
	public BoardVo selectforModify(int no) {
		return sqlSession.selectOne("board.selectforModify",no);
	}
	
	public int update(BoardVo boardVo) {
		return sqlSession.update("board.update", boardVo);
	}
	
	public List<BoardVo> search(String kwd) {
		return sqlSession.selectList("board.search", kwd);
	}
}
