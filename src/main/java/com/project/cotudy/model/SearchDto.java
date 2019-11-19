package com.project.cotudy.model;

import lombok.Data;

@Data
public class SearchDto {
	
	private String freeSubject;	//말머리
	private String searchType; //freeTitle freeCont memId
	private String searchKeyword; // 키워드
}
