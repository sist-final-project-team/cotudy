package com.project.cotudy.mapper;

import com.project.cotudy.model.BoardFileDto;
import com.project.cotudy.model.FreeBoardDto;
import com.project.cotudy.model.FreeBoardReplyDto;
import com.project.cotudy.model.SearchDto;
import com.project.cotudy.model.StudyBoardDto;
import com.project.cotudy.model.StudyBoardReplyDto;
import com.project.cotudy.model.StudyMemberDto;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Map;
@Mapper
public interface BoardMapper {
	//freeboard 게시판 관련
    List<FreeBoardDto> selectFreeBoardList(@Param("startNo") int startNo,@Param("endNo") int endNo) throws Exception;
    List<FreeBoardDto> selectFreeBoardSubSearchList(@Param("searchdto") SearchDto searchdto,@Param("startNo")int startNo,@Param("endNo")int endNo) throws Exception;
    List<FreeBoardDto> selectFreeBoardKeySearchList(@Param("searchdto") SearchDto searchdto,@Param("startNo")int startNo,@Param("endNo")int endNo) throws Exception;
    List<FreeBoardDto> selectFreeBoardSubKeySearchList(@Param("searchdto") SearchDto searchdto,@Param("startNo")int startNo,@Param("endNo")int endNo) throws Exception;
    FreeBoardDto selectFreeBoardCont(int freeNum) throws Exception;
    List<BoardFileDto> selectBoardFileDto(int freeNum) throws Exception;
    List<FreeBoardReplyDto> selectFreeBoardReplyList(int freeNum) throws Exception;

    void deleteFreeBoard(int freeNum) throws Exception;
    void deleteFreeBoardfile(int idx) throws Exception;
    void updateFreeBoardHitCount(int freeNum) throws Exception;
    void updateFreeBoard(FreeBoardDto freeBoard) throws Exception;
    void insertFreeBoard(FreeBoardDto freeBoard) throws Exception;
    List<FreeBoardDto> searchFreeBoard(String searchKeyword) throws Exception;
    void insertBoardFileList(List<BoardFileDto> list) throws Exception;
    List<BoardFileDto> selectBoardFileList(int freeNum) throws Exception;
    int getListCount() throws Exception;
    int getSearchkeyListCount(SearchDto searchDto) throws Exception;
    int getSearchsubkeyListCount(SearchDto searchDto) throws Exception;
    int getSearchsubListCount(SearchDto searchDto) throws Exception;
    void modifyFreeBoardReply(FreeBoardReplyDto replyDto) throws Exception;
    //dto가아니라 map을써서 param으로 데려옴
    BoardFileDto selectBoardFileInformation(@Param("idx") int idx, @Param("freeNum") int freeNum) throws Exception;
    void writeFreeBoardRereply(FreeBoardReplyDto replyDto) throws Exception;
    // study 게시판 관련
    List<StudyBoardDto> selectStudyBoardList() throws Exception;
    StudyBoardDto selectStudyBoardCont(int studyNum) throws Exception;
    List<StudyBoardReplyDto> selectStudyBoardReplyList(int studyNum) throws Exception;
    void deleteStudyBoardReply(int studyReplyNum) throws Exception;
    void updateStudyBoard(StudyBoardDto studyBoard) throws Exception;
    void deleteStudyBoard(int studyNum) throws Exception;
    void writeFreeReplyBoard(FreeBoardReplyDto freeReplyBoard) throws Exception;
//    void updateFreeReplyBoard(FreeBoardReplyDto freeReplyBoard) throws Exception;
    // 서지훈 댓글 삭제 추가
    void deleteFreeBoardReply(int freeReplyNum) throws Exception;
    void deleteFreeBoardRereply(int freeReplyNum) throws Exception;
    void insertStudyBoard(StudyBoardDto studyBoard) throws Exception;
    // 북마크 관련
    List<StudyBoardDto> myBookmark(String memId) throws Exception;
    //북마크 체크 최다빈추가
    int contBookmark(@Param("studyNum") int studyNum,@Param("memId") String memId) throws Exception;
    // 스터디보드 댓글
    void insertStudyBoardReply(StudyBoardReplyDto studyBoardReplyDto) throws Exception;
    void updateStudyBoardReply(@Param("studyReplyNum") int studyReplyNum,@Param("studyReplyCont") String studyReplyCont) throws Exception;
    void insertStudyBoardReReply(StudyBoardReplyDto studyBoardReplyDto) throws Exception;
    void deleteStudyBoardReReply(int studyReplyNum) throws Exception;
}


