package com.project.cotudy.model;

import lombok.Data;

@Data
public class BoardFileDto {
	
	private int idx;
	
	private int freeNum;
	
	private String originalFileName;
	
	private String storedFilePath;
	
	private long fileSize;
}
