package com.javaex.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.javaex.dao.BoardDao;
import com.javaex.vo.BoardVo;

@Service
public class BoardService {

	@Autowired
	private BoardDao boardDao;
	
	public Map<String, Object> getList(int crtPage, String kwd) { //crt는 화면에서 받아오려고 함.
		
		//페이지 뿌려주기 관련 작업
		int listCnt=10; //1페이지 당 표시할 게시글 수
		//int crtPage=1; //현재 페이지(1보다 큰 값이여야 함), 기준이 1페이지
		int startRnum=(crtPage-1)*listCnt; //0, 10, 20 순으로 올라갈 것임, 이 식은 구해야함.
		int endRnum=startRnum+listCnt; //10, 20, 30 순으로 올라감
		
		crtPage=(crtPage<0)? crtPage=1:crtPage; //crtPage가 0보다 작을 때, 처리해주기.
		
		System.out.println("startRnum: "+startRnum);
		System.out.println("endRnum: "+endRnum);
		
		List<BoardVo> boardList=boardDao.selectList(startRnum, endRnum, kwd);
		//페이지 하단 숫자버튼 관련 작업
		//전체 글 갯수
		int totalCount=boardDao.selectTotalCount(kwd);
		System.out.println("totalCount :"+totalCount);
		
		//페이지당 버튼 갯수
		int pageBtnCount=5;
		int endPageBtnNo=(int)(Math.ceil(crtPage/(double)pageBtnCount)*pageBtnCount); //endPageBtnNo부터 구하는게 더 편함.
		//ceil은 올림 메소드
		int startPageBtnNo=endPageBtnNo-(pageBtnCount-1);
		
		//prev,next는 보여줄 것인지 말 것인지를 결정하는 변수
		boolean next=false;
		if(endPageBtnNo*listCnt<totalCount) { //전체 글 개수보다 작으면 다음버튼이 보이게 하기
			next=true;
		} else {
			endPageBtnNo=(int)(Math.ceil(totalCount/(double)listCnt)); //마지막 페이지 계산
		}
		
		boolean prev=false;
		if(startPageBtnNo !=1) {//startPageBtnNo가 1이 아니면 무조건 보여야 함.
			prev=true;
		}
		
		Map<String, Object> bMap=new HashMap<String, Object>();
		bMap.put("boardList", boardList);
		bMap.put("prev", prev);
		bMap.put("startPageBtnNo", startPageBtnNo);
		bMap.put("endPageBtnNo", endPageBtnNo);
		bMap.put("next", next);
		bMap.put("crtPage", crtPage);
		
		return bMap;
	}
	
	@Transactional
	public BoardVo getListforView(int no) {
		BoardVo boardVo=boardDao.selectforView(no);
		boardDao.updateHit(no);
		return boardVo;
	}
	
	public int delete(BoardVo boardVo) {
		return boardDao.delete(boardVo);
	}
	
	public int write(BoardVo boardVo) {
//		for(int i=1;i<182;i++) {
//			boardVo.setTitle(i+" 번째 글입니다.");
//			boardDao.insert(boardVo);
//		}
//		return 1; //게시판에 글 수가 부족하여, 1번 글 추가할 때 182개 글이 추가되도록 강제 지정
		return boardDao.insert(boardVo);
	}
	
	public BoardVo getListforModify(int no) {
		BoardVo boardVo = boardDao.selectforModify(no);
		return boardVo; //그냥 return boardDao.selectforModify(no); 해도 괜찮음.
	}
	
	public int modify(BoardVo boardVo) {
		return boardDao.update(boardVo);
	}
	
	public List<BoardVo> search(String kwd) {
		return boardDao.search(kwd);
	}
}
