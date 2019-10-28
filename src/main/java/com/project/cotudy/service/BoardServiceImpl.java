package com.project.cotudy.service;

import com.project.cotudy.mapper.BoardMapper;
import com.project.cotudy.model.FreeBoardDto;
import com.project.cotudy.model.FreeBoardReplyDto;
import com.project.cotudy.model.StudyBoardDto;
import com.project.cotudy.model.StudyBoardReplyDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class BoardServiceImpl implements BoardService {

    @Autowired
    private BoardMapper boardMapper;



    @Override
    public List<StudyBoardDto> selectStudyBoardList() {
        return null;
    }




    @Override
    public void deleteFreeBoardReply(int freeReplyNum) { }
    @Override
    public StudyBoardDto selectStudyBoardCont(int studyNum) {
        return null;
    }
    @Override
    public List<StudyBoardReplyDto> selectStudyBoardReplyList(int studyNum) {
        return null;
    }
    @Override
    public void deleteStudyBoardReply(int studyReplyNum) { }
    @Override
    public void updateStudyBoard(StudyBoardDto studyBoard) { }
    @Override
    public void deleteStudyBoard(int studyNum) { }
    @Override
    public List<FreeBoardDto> searchFreeBoard(String searchKeyword) {
        return null;
    }
    @Override
    public FreeBoardDto selectFreeBoardCont(int freeNum) throws Exception {
        boardMapper.updateFreeBoardHitCount(freeNum);
        return boardMapper.selectFreeBoardCont(freeNum);
    }
    @Override
    public List<FreeBoardDto> selectFreeBoardList() throws Exception {
        return boardMapper.selectFreeBoardList();
    }

    @Override
    public void writeFreeBoard(FreeBoardDto freeBoard) throws Exception {
        boardMapper.writeFreeBoard(freeBoard);
    }
    @Override
    public void updateFreeBoardHitCount(int freeNum) throws Exception {
        boardMapper.updateFreeBoardHitCount(freeNum);
    }

    @Override
    public void updateFreeBoard(FreeBoardDto freeBoard) throws Exception {
        boardMapper.updateFreeBoard(freeBoard);
    }
    @Override
    public void deleteFreeBoard(int freeNum) throws Exception {
        boardMapper.deleteFreeBoard(freeNum);
    }

    @Override
    public void writeFreeBoardReply(FreeBoardReplyDto freeReplyBoard) throws Exception {
        boardMapper.writeFreeReplyBoard(freeReplyBoard);
    }

    @Override
    public void updateFreeBoardReply(FreeBoardReplyDto freeReplyBoard) throws Exception {
        boardMapper.updateFreeReplyBoard(freeReplyBoard);
    }
    @Override
    public List<FreeBoardReplyDto> selectFreeBoardReplyList(int freeNum) throws Exception {
        return boardMapper.selectFreeBoardReplyList(freeNum);
    }
}
