package com.javaex.vo;

public class FileuploadVo {
	private int no;
	private String regDate;
	private int userNo;
	private String orgName;
	private String extName;
	private String saveName;
	private String filePath;
	private long fileSize;
	
	
	public FileuploadVo() {
	}

	public FileuploadVo(int no, String regDate, int userNo, String orgName, String extName, String saveName,
			String filePath, long fileSize) {
		this.no = no;
		this.regDate = regDate;
		this.userNo = userNo;
		this.orgName = orgName;
		this.extName = extName;
		this.saveName = saveName;
		this.filePath = filePath;
		this.fileSize = fileSize;
	}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public String getRegDate() {
		return regDate;
	}

	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}

	public int getUserNo() {
		return userNo;
	}

	public void setUserNo(int userNo) {
		this.userNo = userNo;
	}

	public String getOrgName() {
		return orgName;
	}

	public void setOrgName(String orgName) {
		this.orgName = orgName;
	}

	public String getExtName() {
		return extName;
	}

	public void setExtName(String extName) {
		this.extName = extName;
	}

	public String getSaveName() {
		return saveName;
	}

	public void setSaveName(String saveName) {
		this.saveName = saveName;
	}

	public String getFilePath() {
		return filePath;
	}

	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}

	public long getFileSize() {
		return fileSize;
	}

	public void setFileSize(long fileSize) {
		this.fileSize = fileSize;
	}

	@Override
	public String toString() {
		return "FileuploadVo [no=" + no + ", regDate=" + regDate + ", userNo=" + userNo + ", orgName=" + orgName
				+ ", extName=" + extName + ", saveName=" + saveName + ", filePath=" + filePath + ", fileSize="
				+ fileSize + "]";
	}
	
}
