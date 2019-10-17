package com.project.cotudy.service;

import com.project.cotudy.model.FreeBoardDto;
import com.project.cotudy.model.StudyBoardDto;
import com.project.cotudy.model.StudyMemberDto;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MemberServiceImpl implements MemberService {
    @Override
    public void resister() {

    }

    @Override
    public boolean loginCheck(String memId, String memPwd) {
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
