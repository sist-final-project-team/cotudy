package com.project.cotudy.service;

import com.project.cotudy.model.BoardFileDto;
import com.project.cotudy.model.FreeBoardDto;
import com.project.cotudy.model.FreeBoardReplyDto;
import com.project.cotudy.model.SearchDto;
import com.project.cotudy.model.StudyBoardDto;
import com.project.cotudy.model.StudyBoardReplyDto;

import java.util.List;

import org.springframework.web.multipart.MultipartHttpServletRequest;

public interface BoardService {
//    ==================freeboard게시판 관련
    List<FreeBoardDto> selectFreeBoardList() throws Exception;
    List<FreeBoardDto> selectFreeBoardSearchList(SearchDto searchdto) throws Exception;
    FreeBoardDto selectFreeBoardCont(int freeNum) throws Exception;
    List<BoardFileDto> selectBoardFileDto(int freeNum) throws Exception;
    List<FreeBoardReplyDto> selectFreeBoardReplyList(int freeNum) throws Exception;
    void updateFreeBoardHitCount(int freeNum) throws Exception;
    void updateFreeBoard(FreeBoardDto freeBoard) throws Exception;
    void deleteFreeBoard(int freeNum) throws Exception;
    List<FreeBoardDto> searchFreeBoard(String searchKeyword) throws Exception;
    void insertFreeBoard(FreeBoardDto board,MultipartHttpServletRequest multireq) throws Exception;
    BoardFileDto selectBoardFileInformation(int idx, int freeNum) throws Exception;
    
//    ==================study게시판 관련
    List<StudyBoardDto> selectStudyBoardList() throws Exception;
    void deleteFreeBoardReply(int freeReplyNum) throws Exception;
    StudyBoardDto selectStudyBoardCont(int studyNum) throws Exception;
    List<StudyBoardReplyDto> selectStudyBoardReplyList(int studyNum) throws Exception;
    void deleteStudyBoardReply(int studyReplyNum) throws Exception;
    void updateStudyBoard(StudyBoardDto studyBoard) throws Exception;
    void deleteStudyBoard(int studyNum) throws Exception;
}
