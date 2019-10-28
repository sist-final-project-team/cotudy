package com.project.cotudy.mapper;

import com.project.cotudy.model.FreeBoardDto;
import com.project.cotudy.model.FreeBoardReplyDto;
import com.project.cotudy.model.StudyBoardDto;
import com.project.cotudy.model.StudyBoardReplyDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface BoardMapper {
    List<FreeBoardDto> selectFreeBoardList() throws Exception;
    List<StudyBoardDto> selectStudyBoardList() throws Exception;
    FreeBoardDto selectFreeBoardCont(int freeNum) throws Exception;
    List<FreeBoardReplyDto> selectFreeBoardReplyList(int freeNum) throws Exception;
    void deleteFreeBoardReply(int freeReplyNum) throws Exception;
    StudyBoardDto selectStudyBoardCont(int studyNum) throws Exception;
    List<StudyBoardReplyDto> selectStudyBoardReplyList(int studyNum) throws Exception;
    void deleteStudyBoardReply(int studyReplyNum) throws Exception;
    void updateFreeBoardHitCount(int freeNum) throws Exception;
    void updateFreeBoard(FreeBoardDto freeBoard) throws Exception;
    void deleteFreeBoard(int freeNum) throws Exception;
    void updateStudyBoard(StudyBoardDto studyBoard) throws Exception;
    void deleteStudyBoard(int studyNum) throws Exception;
    List<FreeBoardDto> searchFreeBoard(String searchKeyword) throws Exception;
    void writeFreeBoard(FreeBoardDto freeBoard) throws Exception;
    void writeFreeReplyBoard(FreeBoardReplyDto freeReplyBoard) throws Exception;
    void updateFreeReplyBoard(FreeBoardReplyDto freeReplyBoard) throws Exception;
}


