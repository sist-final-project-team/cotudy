package com.project.cotudy.mapper;

import com.project.cotudy.model.BookmarkDto;
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
    void kakaoRegister(@Param("memId") String memId,@Param("memName") String memName,@Param("memEmail") String memEmail) throws Exception;    //회원가입
    StudyMemberDto loginCheck(String memId) throws Exception;   //로그인 체크
    String kakaoDbCheck(String memId) throws Exception;   //카카오아이디 db에 있는지 체크
    List<FreeBoardDto> selectMyPostList(String memId) throws Exception;      // 내가 쓴 자유게시판 글 보기
    List<StudyBoardDto> selectMyStudyList(String memId) throws Exception;    // 내가 만든 스터디 보기
    void updateMember(StudyMemberDto memberDto) throws Exception;    //회원 정보 수정
    void updateMemberpwd(@Param("memId") String memId,@Param("editpwd") String editpwd) throws Exception;//비밀번호 변경
    void deleteMember(String memId) throws Exception;    //회원 탈퇴
    void bookmark(String memId, int studyNum) throws Exception;  //북마크 등록
    StudyMemberDto checkMemberId(String memId) throws Exception;
    List<String> findId(@Param("memName") String memName, @Param("memEmail") String memEmail) throws Exception;
    String findPwd(@Param("memId")String memId,@Param("memName")String memName,@Param("memEmail")String memEmail) throws Exception;//비밀번호찾기
	 StudyMemberDto selectMyInfo(String memId) throws Exception;
    List<FreeBoardDto> selectMyFreeBoardList(String memId) throws Exception; //내가쓴글 불러오기 -최다빈-
    List<BookmarkDto> checkBookMark(@Param("memId") String memId, @Param("studyNum") int studyNum) throws Exception; // 북마크에 이미 있는지 확인용
    void insertBookMark(@Param("memId") String memId,@Param("studyNum") int studyNum) throws Exception;  // 북마크 추가
    void deleteBookMark(@Param("memId") String memId,@Param("studyNum") int studyNum) throws Exception; // 북마크 삭제
	String getSaltById(String id) throws Exception;//로그인시 입력한 id로 salt가져오기
	void insertNewPwd(@Param("memId") String memId, @Param("memPwd")String memPwd);//비번찾기시 새로운비번 초기화시켜서 저장시키기
	void changeStatus(String memId) throws Exception;
}
