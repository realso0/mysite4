package com.javaex.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.javaex.dao.GuestbookDao;
import com.javaex.vo.GuestbookVo;

@Service
public class GuestbookService {
	
	@Autowired
	private GuestbookDao guestbookDao;
	
	public List<GuestbookVo> getList() {
		List<GuestbookVo> list=guestbookDao.getList();
		
		return list;
	}
	
	public void write(GuestbookVo guestbookVo) {
		guestbookDao.insert(guestbookVo);
	}
	
	public void delete(int no, String password) {
		guestbookDao.delete(no, password);
	}
	
	public List<GuestbookVo> getListPage(int page) {
		return guestbookDao.getListPage(page);
	}
	
	public int insertAjax(GuestbookVo guestbookVo) {
		return guestbookDao.insertAjax(guestbookVo);
	}
	
	public GuestbookVo writeListAjax(int no) {
		return guestbookDao.selectListAjax(no);
	}
	
	public int deleteAjax(GuestbookVo guestbookVo) {
		return guestbookDao.deleteAjax(guestbookVo);
	}
}