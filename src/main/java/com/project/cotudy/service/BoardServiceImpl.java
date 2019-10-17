package com.project.cotudy.service;

import com.project.cotudy.model.FreeBoardDto;
import com.project.cotudy.model.FreeBoardReplyDto;
import com.project.cotudy.model.StudyBoardDto;
import com.project.cotudy.model.StudyBoardReplyDto;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class BoardServiceImpl implements BoardService {
    @Override
    public List<FreeBoardDto> selectFreeBoardList() {
        return null;
    }

    @Override
    public List<StudyBoardDto> selectStudyBoardList() {
        return null;
    }

    @Override
    public FreeBoardDto selectFreeBoardCont(int freeNum) {
        return null;
    }

    @Override
    public List<FreeBoardReplyDto> selectFreeBoardReplyList(int freeNum) {
        return null;
    }

    @Override
    public void deleteFreeBoardReply(int freeReplyNum) {

    }

    @Override
    public StudyBoardDto selectStudyBoardCont(int studyNum) {
        return null;
    }

    @Override
    public List<StudyBoardReplyDto> selectStudyBoardReplyList(int studyNum) {
        return null;
    }

    @Override
    public void deleteStudyBoardReply(int studyReplyNum) {

    }

    @Override
    public void updateFreeBoardHitCount(int freeNum) {

    }

    @Override
    public void updateFreeBoard(FreeBoardDto freeBoard) {

    }

    @Override
    public void deleteFreeBoard(int freeNum) {

    }

    @Override
    public void updateStudyBoard(StudyBoardDto studyBoard) {

    }

    @Override
    public void deleteStudyBoard(int studyNum) {

    }

    @Override
    public List<FreeBoardDto> searchFreeBoard(String searchKeyword) {
        return null;
    }
}
