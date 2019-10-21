package com.project.cotudy.service;

import com.project.cotudy.mapper.MemberMapper;
import com.project.cotudy.model.FreeBoardDto;
import com.project.cotudy.model.StudyBoardDto;
import com.project.cotudy.model.StudyMemberDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MemberServiceImpl implements MemberService {
    @Autowired
    private MemberMapper memberMapper;

    @Override
    public void register(StudyMemberDto memberDto) {

    }

    @Override
    public boolean loginCheck(String memId, String memPwd) throws Exception {
        StudyMemberDto member = memberMapper.loginCheck(memId);

        if (member.getMemId().equals(memId)) {
            if (member.getMemPwd().equals(memPwd)) {
                return true;
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
    public void updateMember(StudyMemberDto memberDto) {

    }

    @Override
    public void deleteMember(String memId) {

    }

    @Override
    public void bookmark(String memId, int studyNum) {

    }
}
