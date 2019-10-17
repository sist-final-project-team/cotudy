package com.project.cotudy.service;

import com.project.cotudy.model.FreeBoardDto;
import com.project.cotudy.model.FreeBoardReplyDto;
import com.project.cotudy.model.StudyBoardDto;
import com.project.cotudy.model.StudyBoardReplyDto;

import java.util.List;

public interface BoardService {
    List<FreeBoardDto> selectFreeBoardList();
    List<StudyBoardDto> selectStudyBoardList();
    FreeBoardDto selectFreeBoardCont(int freeNum);
    List<FreeBoardReplyDto> selectFreeBoardReplyList(int freeNum);
    void deleteFreeBoardReply(int freeReplyNum);
    StudyBoardDto selectStudyBoardCont(int studyNum);
    List<StudyBoardReplyDto> selectStudyBoardReplyList(int studyNum);
    void deleteStudyBoardReply(int studyReplyNum);
    void updateFreeBoardHitCount(int freeNum);
    void updateFreeBoard(FreeBoardDto freeBoard);
    void deleteFreeBoard(int freeNum);
    void updateStudyBoard(StudyBoardDto studyBoard);
    void deleteStudyBoard(int studyNum);
    List<FreeBoardDto> searchFreeBoard(String searchKeyword);
}
