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
    public List<FreeBoardDto> selectFreeBoardList() throws Exception {
    	return boardMapper.selectFreeBoardList();
    }


    @Override
    public FreeBoardDto selectFreeBoardCont(int freeNum) throws Exception {
		FreeBoardDto freeboard = boardMapper.selectFreeBoardCont(freeNum);
		boardMapper.updateFreeBoardHitCount(freeNum);
		
		return freeboard;
    }

    @Override
    public List<FreeBoardReplyDto> selectFreeBoardReplyList(int freeNum) throws Exception {
        return null;
    }

    @Override
    public void deleteFreeBoardReply(int freeReplyNum) throws Exception {

    }

	@Override
	public void insertFreeBoard(FreeBoardDto freeboard) throws Exception {
		boardMapper.insertFreeBoard(freeboard);
	}

	/*
	 * @Override public void updateFreeBoardHitCount(int freeNum) throws Exception {
	 * 
	 * }
	 */

    @Override
    public void updateFreeBoard(FreeBoardDto freeBoard) throws Exception {
    	boardMapper.updateFreeBoard(freeBoard);
    }

    @Override
    public void deleteFreeBoard(int freeNum) throws Exception {
    	boardMapper.deleteFreeBoard(freeNum);
    }



    @Override
    public List<FreeBoardDto> searchFreeBoard(String searchKeyword) throws Exception {
        return null;
    }

	//============================study 게시판 관련
	@Override
	public List<StudyBoardDto> selectStudyBoardList() throws Exception {
		return null;
	}
	
    @Override
    public void updateStudyBoard(StudyBoardDto studyBoard) throws Exception {

    }

    @Override
    public void deleteStudyBoard(int studyNum) throws Exception {

    }
    
    @Override
    public StudyBoardDto selectStudyBoardCont(int studyNum) throws Exception {
        return null;
    }

    @Override
    public List<StudyBoardReplyDto> selectStudyBoardReplyList(int studyNum) throws Exception {
        return null;
    }

    @Override
    public void deleteStudyBoardReply(int studyReplyNum) throws Exception {

    }
}
