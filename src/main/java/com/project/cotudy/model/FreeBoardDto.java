package com.project.cotudy.model;

import lombok.Data;

import java.time.LocalDateTime;
import java.util.List;

@Data
public class FreeBoardDto {
    private int freeNum;
    private String memId;
    private String freeTitle;
    private String freeCont;
    private String  freeCreatedDate;
    private String freeUpdatedDate;
    private int freeHit;
    private String freeDeleted;
    private String freeSubject;
	private List<BoardFileDto> fileList;	
	//	int idx; int freeNum; String originalFileName; String storedFilePath; long fileSize;
}
