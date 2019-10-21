package com.project.cotudy.service;


import com.project.cotudy.model.FreeBoardDto;
import com.project.cotudy.model.StudyBoardDto;
import com.project.cotudy.model.StudyMemberDto;

import java.util.List;

public interface MemberService {
    void register(StudyMemberDto memberDto);    //회원가입
    boolean loginCheck(String memId, String memPwd) throws Exception;   //로그인 체크
    List<FreeBoardDto> selectMyPostList(String memId);      // 내가 쓴 자유게시판 글 보기
    List<StudyBoardDto> selectMyStudyList(String memId);    // 내가 만든 스터디 보기
    void updateMember(StudyMemberDto memberDto);    //회원 정보 수정
    void deleteMember(String memId);    //회원 탈퇴
    void bookmark(String memId, int studyNum);  //북마크 등록
}

