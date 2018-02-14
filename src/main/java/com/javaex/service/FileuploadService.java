package com.javaex.service;

import java.io.BufferedOutputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.javaex.dao.FileuploadDao;
import com.javaex.vo.FileuploadVo;

@Service
public class FileuploadService {

	@Autowired
	private FileuploadDao fileUploadDao;
	//서비스는 비즈니스 로직단계
	
	public String restore(MultipartFile file, FileuploadVo fileUploadVo) {
		String saveDir="D:\\javaStudy\\upload"; //서버에 저장할 공간 만들기(저장 위치), 경로를 줄 때 \\는 윈도우환경에서 사용하는 표현
		
		//1-파일정보 수집
		
		//원래 파일이름
		String orgName=file.getOriginalFilename();
		System.out.println(orgName); //첨부된 파일이름 출력됨.
		
		//확장자(본래이름에서 잘라내기)
		String extName=file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf("."));
		System.out.println(extName);
		
		//고유한 저장 파일이름(유일해야함)
		String saveName=System.currentTimeMillis()+UUID.randomUUID().toString()+extName; 
		//UUID가 랜덤하게 길게 값(이름)을 뽑아줌. 시간까지 추가해서 절대로 이름이 안겹치게 시간메소드까지 추가 + 확장자명
		System.out.println(saveName); //고유한 파일이름이 출력됨.
		
		//파일 위치(path)
		String filePath=saveDir+"\\"+saveName; //고유한 이름으로 찾은 파일의 위치
		System.out.println(filePath);
		
		//파일 사이즈
		long fileSize=file.getSize(); //크기를 알수 있는 메서드
		System.out.println(fileSize);
		
		//vo에 만들어서, 이후에 db저장하는 것은 알아서 할 것.
		fileUploadVo.setOrgName(orgName);
		fileUploadVo.setExtName(extName);
		fileUploadVo.setSaveName(saveName);
		fileUploadVo.setFilePath(filePath);
		fileUploadVo.setFileSize(fileSize);
		
		System.out.println(fileUploadVo.toString());
		fileUploadDao.insertUpload(fileUploadVo);
		
		//2-파일 카피
		try {
			byte[] fileData=file.getBytes(); //byte단위로 파일을 읽어와서, 배열에 담음.
			OutputStream out=new FileOutputStream(saveDir+"/"+saveName); //사용자로부터 서버 메모리에 올라온 데이터를 파일 위치에 저장해야함.
			//파일위치에 저장하기 위한 길(빨대)을 만듬.
			BufferedOutputStream bout=new BufferedOutputStream(out); 
			//저장하기 위한 길(out)에  buffered를 이용한 빠른길(buffered는 여러개씩 모아서, 한번에 많이씩 보내줌)을 하나 더 얹어주어, 저장 속도를 빠르게 해줌.
			//-1이 끝나는 값(eof=-1)
			bout.write(fileData);
			
			if(bout!=null) { //-1이면 끝내기
				bout.close();
			}
			
		} catch(IOException e) {
			e.printStackTrace();
		}
		//이제 업로드 해보면, 원래 있던 파일(사용자 컴퓨터)이 서버의 저장위치에 복사본으로 하나 저장되는 것을 볼 수 있음.
		//카피 제대로 됬으면 db에 저장되도록 하는게 좋음.
		return saveName; //이것을 넘김으로써 고유한 이름의 파일을 return함.
	}
}
