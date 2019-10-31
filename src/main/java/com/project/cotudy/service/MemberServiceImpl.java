package com.project.cotudy.service;

import com.project.cotudy.mapper.BoardMapper;
import com.project.cotudy.mapper.MemberMapper;
import com.project.cotudy.model.BoardFileDto;
import com.project.cotudy.model.FreeBoardDto;
import com.project.cotudy.model.StudyBoardDto;
import com.project.cotudy.model.StudyMemberDto;

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
}
