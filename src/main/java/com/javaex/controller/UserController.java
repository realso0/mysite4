package com.javaex.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.javaex.service.UserService;
import com.javaex.vo.UserVo;

@Controller
@RequestMapping("/user")
public class UserController {

	@Autowired
	private UserService userService;

	@RequestMapping(value = "/joinform")
	public String joinform() {
		System.out.println("joinform 진입");
		return "user/joinform";
	}

	@RequestMapping(value = "/join")
	public String join(@ModelAttribute UserVo userVo) {
		System.out.println("insert 진입");
		int result=0;
		result = userService.join(userVo);

		if(result==1) {
			return "user/joinsuccess";
		}else {
			return "user/joinfail";
		}
	}

	@RequestMapping(value = "/loginform")
	public String loginform() {
		System.out.println("loginform 진입");
		return "user/loginform";
	}

	@RequestMapping(value = "login")
	public String login(@RequestParam("email") String email, @RequestParam("password") String password,
			HttpSession session) {
		System.out.println("login 진입");
		UserVo authUser = userService.login(email, password); // 세션은 email,password를 매개값으로 받아, no, name 출력함

		if (authUser == null) {
			System.out.println("로그인 실패"); // db 안에 해당 no,name이 없으면 null값임.
			return "redirect:/user/loginform?result=fail"; // 실패시에만 오류메시지 출력하도록 하기위한 작업
		} else {
			System.out.println("로그인 성공");
			session.setAttribute("authUser", authUser); // session은 안사라지는 공간이므로, session에 저장함.
			return "redirect:/main"; // 세션값이 서버에 있으면, 로그인으로 처리해주어야 함.
		}
	}

	@RequestMapping(value = "logout") // 세션 삭제
	public String logout(HttpSession session) {
		session.removeAttribute("authUser"); // 지정된 이름에 해당하는 객체를 세션에서 제거한다.
		session.invalidate();

		return "redirect:/main";
	}

	@RequestMapping(value = "modifyform")
	public String modifyform(Model model, HttpSession session) {
		System.out.println("modifyform 진입");

		UserVo authUser=(UserVo)session.getAttribute("authUser");
		if (authUser == null) {
			// 세션 없다면 로그인폼으로 이동(주소창에 바로 치고 들어오는 사람들이 존재하므로)
			return "/user/loginform";
		} else { // 로그인 상태
			// 로그인회원의 no
			int no = authUser.getNo();
			UserVo userVo = userService.getUser(no); // no 를 매개값으로 받아 모든 변수값 출력.

			model.addAttribute("userVo", userVo); // model에 담아 보내기
			return "/user/modifyform";
		}
	}
	
	@RequestMapping(value="/modify", method=RequestMethod.POST)
	public String modify(@ModelAttribute UserVo userVo, HttpSession session) {
		UserVo authUser = (UserVo)session.getAttribute("authUser");
		int no = authUser.getNo();
		userVo.setNo(no); //jsp로부터 가져온 값에다가 사용자 고유 세션no만 그대로 유지시킴.
		int result=0;
		
		if(result==1) {
			userService.modify(userVo);
			authUser.setName(userVo.getName()); //바뀐 이름에 대하여 세션에 다시 저장.
			return "redirect:/main";
		}else {
			return "user/modifyfail";
		}
	}

}
