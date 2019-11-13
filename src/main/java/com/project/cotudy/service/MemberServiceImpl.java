package com.project.cotudy.service;

import com.project.cotudy.mapper.BoardMapper;
import com.project.cotudy.mapper.MemberMapper;
import com.project.cotudy.model.*;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.PrintWriter;
import java.util.List;

@Service
public class MemberServiceImpl implements MemberService {

   @Autowired
   private MemberMapper memberMapper;

    @Override
    public void register(StudyMemberDto MemberDto) throws Exception {
        memberMapper.register(MemberDto);
    }

    //카카오 가입시키기
    @Override
    public void kakaoRegister(String memId, String memName, String memEmail) throws Exception {
        memberMapper.kakaoRegister(memId,memName,memEmail);
    }
    
    
    @Override
    public boolean loginCheck(String memId, String memPwd) throws Exception {
        StudyMemberDto member = memberMapper.loginCheck(memId);
        if(member == null) {
           return false;
        }else{
            if (member.getMemId().equals(memId)) {
                if (member.getMemPwd().equals(memPwd)) {
                    return true;
                }
            }
        }
        return false;
    }

    //카카오로그인 유저의 id가 db에 저장되어있는지 확인
    @Override
    public boolean kakaoDbCheck(String memId) throws Exception {
    	String ismem = memberMapper.kakaoDbCheck(memId);
    	if(ismem == null) {
    		return false;  //db에 저장된 아이디 없음(회원가입시키기)  		
    	}else {
    		return true;
    	}

    }//end of kakaoDbCheck
     
    
    @Override
    public List<FreeBoardDto> selectMyPostList(String memId) {
        return null;
    }

    @Override
    public List<StudyBoardDto> selectMyStudyList(String memId) {
        return null;
    }

    @Override
    public void updateMember(StudyMemberDto memberDto) throws Exception {
    	memberMapper.updateMember(memberDto);
    }
    
	@Override
	public void updateMemberpwd(String memId, String editpwd) throws Exception {	//비밀번호 변경
		memberMapper.updateMemberpwd(memId, editpwd);
	}    

    @Override
    public void deleteMember(String memId) throws Exception {
        memberMapper.deleteMember(memId);
    }

    @Override
    public void bookmark(String memId, int studyNum) {

    }

    @Override
    public int checkMemberId(String memId) throws Exception {
        int result =0;
        StudyMemberDto dto =  memberMapper.checkMemberId(memId);
        if(dto != null){
            result = 1;
        }else if(dto==null){
            result=0;
        }
        System.out.println(result+"111");
        return result;
    }

    @Override
    public String findId(String memName, String memEmail) throws Exception {
        return memberMapper.findId(memName,memEmail);
    }

    @Override
    public String findPwd(String memId, String memName, String memEmail) throws Exception {
        return memberMapper.findPwd(memId,memName,memEmail);
    }

	@Override
	public StudyMemberDto selectMyInfo(String memId) throws Exception {
		StudyMemberDto meminfodto = memberMapper.selectMyInfo(memId);	//회원정보 가져오기
		return meminfodto;
	}
    @Override
    public List<FreeBoardDto> selectMyFreeBoardList(String memId) throws Exception {
        System.out.println(memId);
        System.out.println(memId);
        System.out.println(memId);
        return memberMapper.selectMyFreeBoardList(memId);
    }
    // 북마크 추가 부분시작
    @Override
    public boolean checkBookMark(String memId, int studyNum) throws Exception {
        if(memberMapper.checkBookMark(memId,studyNum).isEmpty()){
            System.out.println(memberMapper.checkBookMark(memId,studyNum));
            return false;
        }else{
            System.out.println("...null값이 아니다"+memberMapper.checkBookMark(memId,studyNum));
            return true;
        }
    }
    @Override
    public void insertBookMark(String memId, int studyNum) throws Exception {
        memberMapper.insertBookMark(memId,studyNum);
    }
    @Override
    public void deleteBookMark(String memId, int studyNum) throws Exception {
        memberMapper.deleteBookMark(memId,studyNum);
    }
    
    //id로 salt값 가져오기
	@Override
	public String getSaltById(String id) throws Exception {
		return memberMapper.getSaltById(id);
	}
}
