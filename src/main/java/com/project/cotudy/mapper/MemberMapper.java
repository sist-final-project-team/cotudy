package com.project.cotudy.mapper;

import com.project.cotudy.model.FreeBoardDto;
import com.project.cotudy.model.StudyBoardDto;
import com.project.cotudy.model.StudyMemberDto;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.HashMap;
import java.util.List;

@Mapper
public interface MemberMapper {
    void register(StudyMemberDto MemberDto) throws Exception;    //회원가입
    StudyMemberDto loginCheck(String memId) throws Exception;   //로그인 체크
    List<FreeBoardDto> selectMyPostList(String memId) throws Exception;      // 내가 쓴 자유게시판 글 보기
    List<StudyBoardDto> selectMyStudyList(String memId) throws Exception;    // 내가 만든 스터디 보기
    void updateMember(StudyMemberDto memberDto) throws Exception;    //회원 정보 수정
    void updateMemberpwd(@Param("memId") String memId,@Param("editpwd") String editpwd) throws Exception;//비밀번호 변경
    void deleteMember(String memId) throws Exception;    //회원 탈퇴
    void bookmark(String memId, int studyNum) throws Exception;  //북마크 등록
    StudyMemberDto checkMemberId(String memId) throws Exception;
    String findId(@Param("memName") String memName, @Param("memEmail") String memEmail) throws Exception;
    String findPwd(String memId,String memName,String memEmail) throws Exception;
	 StudyMemberDto selectMyInfo(String memId) throws Exception;
}
