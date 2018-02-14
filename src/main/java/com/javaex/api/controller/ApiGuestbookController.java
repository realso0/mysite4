package com.javaex.api.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.javaex.service.GuestbookService;
import com.javaex.vo.GuestbookVo;

@Controller
public class ApiGuestbookController {
	
	@Autowired
	private GuestbookService guestbookService;
	
	@ResponseBody //json방식으로 리턴하기(자바객체를 json문자열로 변환해서, 바디에 담아서, jsp로 보냄.(리턴타입을 데이터로 받을 수 있게 해줌.))
	@RequestMapping(value="/guestbook/api/list")
	public List<GuestbookVo> apiList(@RequestParam("page") int page) {
		System.out.println("apiList 진입");
		List<GuestbookVo> glist=guestbookService.getListPage(page); //다 뿌려지지 않고, 계산되서 5개씩 뿌려줌.
		//System.out.println(glist.toString()); //가장 최근 값 5개를 보여주게 됨.
		
		return glist; //로딩되기 전에 list를 보내줌.
	}
	
	@ResponseBody
	@RequestMapping(value="/guestbook/api/addAjax", method=RequestMethod.POST)
	public GuestbookVo apiAdd(@RequestBody GuestbookVo guestbookVo) { //시험시 리턴형 void로 해줄 것. 
		System.out.println("addAjax 진입");
		System.out.println(guestbookVo.toString()); //no, regDate 제외 나머지 값 넘어온 것 확인.
		
		guestbookService.insertAjax(guestbookVo);
		
		return guestbookVo; //return시 regDate 제외 전부 값 입력 되어있음.
	}
	
	@ResponseBody
	@RequestMapping(value="/guestbook/api/selectListAjax",method=RequestMethod.POST)
	public GuestbookVo selectList(@RequestParam("no") int no){ //처음 데이터 받았을 때는 리턴타입 void로 해주고 수행
		System.out.println("selectListAjax 진입");
		System.out.println(no);
		
		GuestbookVo writeListAjax = guestbookService.writeListAjax(no);

		return writeListAjax;
	}
	
	@ResponseBody
	@RequestMapping(value="/guestbook/api/deleteAjax")
	public int apiDelete(@RequestBody GuestbookVo guestbookVo) {
		System.out.println("deleteAjax 진입");
		System.out.println(guestbookVo.toString()); //no, password값 넘어온 것 확인.
		int count = guestbookService.deleteAjax(guestbookVo);
		return count;
	}
}
