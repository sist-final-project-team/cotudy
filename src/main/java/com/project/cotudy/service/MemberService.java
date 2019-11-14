package com.project.cotudy.service;


import com.project.cotudy.model.BookmarkDto;
import com.project.cotudy.model.FreeBoardDto;
import com.project.cotudy.model.StudyBoardDto;
import com.project.cotudy.model.StudyMemberDto;
import org.springframework.stereotype.Service;

import java.util.List;

public interface MemberService {
    void register(StudyMemberDto MemberDto) throws Exception;    //회원가입
    boolean loginCheck(String memId, String memPwd) throws Exception;   //로그인 체크
    boolean kakaoDbCheck(String memId) throws Exception;   //카카오로그인 유저의 id가 db에 저장되어있는지 확인
    void kakaoRegister(String memId, String memName, String memEmail) throws Exception;//카카오정보 db에 저장시키기
    List<FreeBoardDto> selectMyPostList(String memId);      // 내가 쓴 자유게시판 글 보기
    List<StudyBoardDto> selectMyStudyList(String memId);    // 내가 만든 스터디 보기
    void updateMember(StudyMemberDto memberDto) throws Exception;    //회원 정보 수정
    void updateMemberpwd(String memId, String editpwd) throws Exception;//비밀번호 변경
    void deleteMember(String memId) throws Exception;    //회원 탈퇴
    void bookmark(String memId, int studyNum);  //북마크 등록
    int checkMemberId(String memId) throws Exception;
    String findId(String memName,String memEmail) throws Exception;
    String findPwd(String memId,String memName,String memEmail) throws Exception;
    StudyMemberDto selectMyInfo(String memId) throws Exception;//아이디로 내 정보 가져오기
    List<FreeBoardDto> selectMyFreeBoardList(String memId) throws Exception;
    boolean checkBookMark(String memId, int studyNum) throws Exception;
    void insertBookMark(String memId,int studyNum) throws Exception;
    void deleteBookMark(String memId,int studyNum) throws Exception;
	String getSaltById(String id) throws Exception;
	void insertNewPwd( String memId, String memPwd) throws Exception;//비번찾기시 새로운비번 저장시키기
	void changeStatus(String memId) throws Exception;
}

