package com.project.cotudy.service;

import com.project.cotudy.model.FreeBoardDto;
import com.project.cotudy.model.FreeBoardReplyDto;
import com.project.cotudy.model.StudyBoardDto;
import com.project.cotudy.model.StudyBoardReplyDto;
import org.springframework.stereotype.Service;

import java.util.List;

public interface BoardService {
    List<FreeBoardDto> selectFreeBoardList() throws Exception;
    List<StudyBoardDto> selectStudyBoardList();
    FreeBoardDto selectFreeBoardCont(int freeNum) throws Exception;
    List<FreeBoardReplyDto> selectFreeBoardReplyList(int freeNum) throws Exception;
    void deleteFreeBoardReply(int freeReplyNum);
    StudyBoardDto selectStudyBoardCont(int studyNum);
    List<StudyBoardReplyDto> selectStudyBoardReplyList(int studyNum);
    void deleteStudyBoardReply(int studyReplyNum);
    void updateFreeBoardHitCount(int freeNum) throws Exception;
    void updateFreeBoard(FreeBoardDto freeBoard) throws Exception;
    void deleteFreeBoard(int freeNum) throws Exception;
    void updateStudyBoard(StudyBoardDto studyBoard);
    void deleteStudyBoard(int studyNum);
    List<FreeBoardDto> searchFreeBoard(String searchKeyword);
    void writeFreeBoard(FreeBoardDto freeBoard) throws Exception;
    void writeFreeBoardReply(FreeBoardReplyDto freeReplyBoard) throws Exception;
    void updateFreeBoardReply(FreeBoardReplyDto freeReplyBoard) throws Exception;
}
