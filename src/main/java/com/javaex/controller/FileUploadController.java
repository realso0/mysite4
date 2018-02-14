package com.javaex.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.javaex.service.FileuploadService;
import com.javaex.vo.FileuploadVo;
import com.javaex.vo.UserVo;

@Controller
@RequestMapping("/fileupload")
public class FileUploadController {
	
	@Autowired
	private FileuploadService fileUploadService;
	
	@RequestMapping("/form") //하나만 옵션 줄때는 value생략 가능
	public String form() {
		
		return "fileupload/form";
	}
	
	@RequestMapping("/upload")
	public String upload(@RequestParam("file") MultipartFile file, @ModelAttribute FileuploadVo fileUploadVo, Model model, HttpSession session) { //file의 자료형에 주의
		System.out.println(file.toString()); //일단 여기까지 하면, 무언가 주소를 찍음.(첨부파일을 가져온 것임)
		UserVo authUser=(UserVo)session.getAttribute("authUser"); // 세션은 email,password를 매개값으로 받아, no, name 출력함.
		fileUploadVo.setUserNo(authUser.getNo());
		System.out.println(fileUploadVo.toString());
		
		String saveName=fileUploadService.restore(file,fileUploadVo);
		
		String url="upload/"+saveName; //url을 result.jsp로 보내야 함.
		
		model.addAttribute("url", url);
		return "fileupload/result"; //result.jsp에 내가 올린 이미지가 보이도록 해주는 작업을 할 것임.
	}
}
