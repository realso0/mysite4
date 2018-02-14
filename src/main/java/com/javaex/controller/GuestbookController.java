package com.javaex.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.javaex.service.GuestbookService;
import com.javaex.vo.GuestbookVo;

@Controller
@RequestMapping("/guestbook")
public class GuestbookController {
	
	@Autowired
	private GuestbookService guestbookService;

	@RequestMapping(value="/list")
	public String list(Model model) {
		System.out.println("list 진입");
		List<GuestbookVo> list=guestbookService.getList();
		model.addAttribute("elist",list);
		model.addAttribute("ctrl","\r\n");
		return "guestbook/list";
	}
	
	@RequestMapping(value="/add")
	public String write(@ModelAttribute GuestbookVo guestbookVo) {
		System.out.println("write 진입");
		guestbookService.write(guestbookVo);
		
		return "redirect:/guestbook/list";
	}
	
	@RequestMapping(value="/deleteform")
	public String deleteform(@RequestParam("no") int no, Model model) {
		System.out.println("deleteform 진입");
		
		model.addAttribute("no",no); //addAttribute는 setAttribute 와 비슷한 기능.
		return "guestbook/deleteform";
	}
	
	@RequestMapping(value="/delete")
	public String delete(@RequestParam("no") int no,  @RequestParam("password") String password) {
		System.out.println("delete 진입");
		
		guestbookService.delete(no, password);
		return "redirect:/guestbook/list";
	}
	
	@RequestMapping(value="/listajax")
	public String listajax() { //1.listajax페이지 띄우기
		System.out.println("listajax 진입");
		return "guestbook/listajax";
	}
	
}