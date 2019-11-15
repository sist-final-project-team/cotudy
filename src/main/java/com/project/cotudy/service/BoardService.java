package com.project.cotudy.service;

import com.project.cotudy.model.BoardFileDto;
import com.project.cotudy.model.FreeBoardDto;
import com.project.cotudy.model.FreeBoardReplyDto;
import com.project.cotudy.model.SearchDto;
import com.project.cotudy.model.StudyBoardDto;
import com.project.cotudy.model.StudyBoardReplyDto;
import com.project.cotudy.model.StudyMemberDto;

import org.springframework.stereotype.Service;

import java.util.List;

import org.springframework.web.multipart.MultipartHttpServletRequest;

public interface BoardService {
//    ==================freeboard게시판 관련
	List<FreeBoardDto> selectFreeBoardList(int page, int rowsize) throws Exception;
	FreeBoardDto selectFreeBoardCont(int freeNum) throws Exception;
    List<FreeBoardDto> selectFreeBoardSearchList(SearchDto searchdto,int page,int rowsize) throws Exception;
    List<BoardFileDto> selectBoardFileDto(int freeNum) throws Exception;
    List<FreeBoardDto> searchFreeBoard(String searchKeyword) throws Exception;
    void insertFreeBoard(FreeBoardDto board,MultipartHttpServletRequest multireq) throws Exception;
    BoardFileDto selectBoardFileInformation(int idx, int freeNum) throws Exception;
    int getListCount() throws Exception;
    int getSearchListCount(SearchDto searchDto) throws Exception;
    void writeFreeBoardRereply(FreeBoardReplyDto replyDto) throws Exception;
    void modifyFreeBoardReply(FreeBoardReplyDto replyDto) throws Exception;
    void deleteFreeBoardfile(int idx) throws Exception;
    
//    ==================study게시판 관련
    List<StudyBoardDto> selectStudyBoardList() throws Exception;
    void deleteFreeBoardReply(int freeReplyNum) throws Exception;
    StudyBoardDto selectStudyBoardCont(int studyNum) throws Exception;
    List<StudyBoardReplyDto> selectStudyBoardReplyList(int studyNum) throws Exception;
    void deleteStudyBoardReply(int studyReplyNum) throws Exception;
    void updateStudyBoard(StudyBoardDto studyBoard);
    void deleteStudyBoard(int studyNum) throws Exception;
    void insertStudyBoard(StudyBoardDto studyBoard) throws Exception;
//    ===================추가된 부분
  
    List<FreeBoardReplyDto> selectFreeBoardReplyList(int freeNum) throws Exception;
    void updateFreeBoardHitCount(int freeNum) throws Exception;
    void updateFreeBoard(FreeBoardDto freeBoard, MultipartHttpServletRequest multireq) throws Exception;
    void deleteFreeBoard(int freeNum) throws Exception;
    void deleteFreeBoardRereply(int freeReplyNum) throws Exception;
    void writeFreeBoardReply(FreeBoardReplyDto freeReplyBoard) throws Exception;
  //  void updateFreeBoardReply(FreeBoardReplyDto freeReplyBoard) throws Exception;
    // ======================== 북마크 리스트 가져오기
  List<StudyBoardDto> myBookmark(String memId) throws Exception;
// studyboard 댓글달기
void insertStudyBoardReply(StudyBoardReplyDto studyBoardReplyDto) throws Exception;
}
