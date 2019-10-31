package com.project.cotudy.mapper;

import com.project.cotudy.model.BoardFileDto;
import com.project.cotudy.model.FreeBoardDto;
import com.project.cotudy.model.FreeBoardReplyDto;
import com.project.cotudy.model.SearchDto;
import com.project.cotudy.model.StudyBoardDto;
import com.project.cotudy.model.StudyBoardReplyDto;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

import java.util.List;
@Mapper
public interface BoardMapper {
	//freeboard 게시판 관련
    List<FreeBoardDto> selectFreeBoardList(int startNo,int endNo) throws Exception;
    List<FreeBoardDto> selectFreeBoardSubSearchList(SearchDto searchdto,int startNo,int endNo) throws Exception;
    List<FreeBoardDto> selectFreeBoardKeySearchList(SearchDto searchdto,int startNo,int endNo) throws Exception;
    List<FreeBoardDto> selectFreeBoardSubKeySearchList(SearchDto searchdto,int startNo,int endNo) throws Exception;
    FreeBoardDto selectFreeBoardCont(int freeNum) throws Exception;
    List<BoardFileDto> selectBoardFileDto(int freeNum) throws Exception;
    List<FreeBoardReplyDto> selectFreeBoardReplyList(int freeNum) throws Exception;
    void deleteFreeBoardReply(int freeReplyNum) throws Exception;
    void deleteFreeBoard(int freeNum) throws Exception;
    void deleteFreeBoardfile(int freeNum) throws Exception;
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
    //dto가아니라 map을써서 param으로 데려옴
    BoardFileDto selectBoardFileInformation(@Param("idx") int idx, @Param("freeNum") int freeNum) throws Exception;
    
    // study 게시판 관련
    List<StudyBoardDto> selectStudyBoardList() throws Exception;
    StudyBoardDto selectStudyBoardCont(int studyNum) throws Exception;
    List<StudyBoardReplyDto> selectStudyBoardReplyList(int studyNum) throws Exception;
    void deleteStudyBoardReply(int studyReplyNum) throws Exception;
    void updateStudyBoard(StudyBoardDto studyBoard) throws Exception;
    void deleteStudyBoard(int studyNum) throws Exception;
    void writeFreeReplyBoard(FreeBoardReplyDto freeReplyBoard) throws Exception;
//    void updateFreeReplyBoard(FreeBoardReplyDto freeReplyBoard) throws Exception;
}


