package com.project.cotudy.service;

import com.project.cotudy.mapper.BoardMapper;
import com.project.cotudy.mapper.MemberMapper;
import com.project.cotudy.model.*;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.PrintWriter;
import java.util.List;

@Transactional
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
    	String memPwd = Double.toString((Math.random() * 1000000) + 1); 
        memberMapper.kakaoRegister(memId,memName,memEmail,memPwd);
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
    public List<StudyBoardDto> selectMyStudyList(String memId) throws Exception {

        List<StudyBoardDto> studyList = memberMapper.selectMyStudyList(memId);
        return studyList;
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
        return result;
    }

    @Override
    public List<String> findId(String memName, String memEmail) throws Exception {
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

        return memberMapper.selectMyFreeBoardList(memId);
    }
    // 북마크 추가 부분시작
    @Override
    public boolean checkBookMark(String memId, int studyNum) throws Exception {
        if(memberMapper.checkBookMark(memId,studyNum).isEmpty()){
            return false;
        }else{
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

	//비밀번호 찾기시 새로 초기화시킨 난수 비번 저장시키기
	@Override
	public void insertNewPwd(String memId, String memPwd) throws Exception {
		memberMapper.insertNewPwd(memId, memPwd);
	}

	//카카오 탈퇴후 재가입하는사람 status O로 바꾸기
	@Override
	public void changeStatus(String memId) throws Exception {
		memberMapper.changeStatus(memId);

	}
}
