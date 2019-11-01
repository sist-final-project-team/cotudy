package com.project.cotudy.model;

import lombok.Data;

@Data
public class SearchDto {
	
	private String freeSubject;	//전체보기 기타 사담 질문
	private String searchType; //freeTitle freeCont memId
	private String searchKeyword; // 키워드
}
