package com.project.cotudy.service;

import com.project.cotudy.common.FileUtils;
import com.project.cotudy.mapper.BoardMapper;
import com.project.cotudy.model.BoardFileDto;
import com.project.cotudy.model.FreeBoardDto;
import com.project.cotudy.model.FreeBoardReplyDto;
import com.project.cotudy.model.SearchDto;
import com.project.cotudy.model.StudyBoardDto;
import com.project.cotudy.model.StudyBoardReplyDto;
import org.springframework.util.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Transactional
@Service
public class BoardServiceImpl implements BoardService {


	@Autowired
	private FileUtils fileUtils;

	@Autowired
	private BoardMapper boardMapper;

	@Override
	public List<FreeBoardDto> selectFreeBoardList(int page,int rowsize) throws Exception {
		int startNo = ((page-1)*rowsize)+1;
		int endNo = (page * rowsize);

		List<FreeBoardDto> list = boardMapper.selectFreeBoardList(startNo,endNo);
		if(list.size()==0){
			list = boardMapper.selectFreeBoardList(startNo,endNo);
		}
		return list;
	}

	@Override
	public FreeBoardDto selectFreeBoardCont(int freeNum) throws Exception {
		FreeBoardDto freeboard = boardMapper.selectFreeBoardCont(freeNum); // 글내용 가져오기
		List<BoardFileDto> fileList = boardMapper.selectBoardFileList(freeNum);
		freeboard.setFileList(fileList);
		return freeboard;
	}

	@Override
	public List<BoardFileDto> selectBoardFileDto(int freeNum) throws Exception {
		List<BoardFileDto> fileDtolist = boardMapper.selectBoardFileDto(freeNum);//filedto list로 가져오기

		return fileDtolist;
	}

	@Override
	public int getListCount() throws Exception {
		return boardMapper.getListCount();
	}

	@Override public void updateFreeBoardHitCount(int freeNum) throws Exception {
		boardMapper.updateFreeBoardHitCount(freeNum); // 조회수 증가시키기
	}

	@Override
	public List<FreeBoardReplyDto> selectFreeBoardReplyList(int freeNum) throws Exception {
		return boardMapper.selectFreeBoardReplyList(freeNum);
	}

	@Override
	public void deleteFreeBoardReply(int freeReplyNum) throws Exception {
		boardMapper.deleteFreeBoardReply(freeReplyNum);
	}

	@Override
	public void insertFreeBoard(FreeBoardDto freeboard, MultipartHttpServletRequest multireq) throws Exception {
		boardMapper.insertFreeBoard(freeboard);
		//업로드된 파일을 서버에 저장하고 파일정보를 가져옴
		List<BoardFileDto> list = fileUtils.parseFileInfo(freeboard.getFreeNum(), multireq);
		//System.out.println("list stored는2>??"+list.get(1).getStoredFilePath());
		//파일정보를 맵에 저장
		if(CollectionUtils.isEmpty(list) == false){
			boardMapper.insertBoardFileList(list);
		}

	}


	@Override
	public void updateFreeBoard(FreeBoardDto freeboard, MultipartHttpServletRequest multireq) throws Exception {
		boardMapper.updateFreeBoard(freeboard); //수정내용 업데이트

		List<BoardFileDto> list = fileUtils.parseFileInfo(freeboard.getFreeNum(), multireq);
		//파일정보를 맵에 저장
		if(CollectionUtils.isEmpty(list) == false){	//새로올린파일이있다면
			boardMapper.insertBoardFileList(list);
		}else {//없다면..?

		}
	}

	@Override
	public void deleteFreeBoard(int freeNum) throws Exception {
		boardMapper.deleteFreeBoard(freeNum);
		boardMapper.deleteFreeBoardfile(freeNum);
	}

	@Override
	public List<FreeBoardDto> searchFreeBoard(String searchKeyword) throws Exception {
		return null;
	}


	@Override
	public List<FreeBoardDto> selectFreeBoardSearchList(SearchDto searchdto,int page,int rowsize) throws Exception {
		int startNo = ((page-1)*rowsize)+1;
		int endNo = (page * rowsize);
		List<FreeBoardDto> list = null;
System.out.println("getFreeSubject????????????"+searchdto.getFreeSubject());
System.out.println("getSearchKeyword????????????"+searchdto.getSearchKeyword());
System.out.println("getSearchType???????????"+searchdto.getSearchType());

		if(searchdto.getSearchKeyword() == null || searchdto.getSearchKeyword().equals("")){ //1-1.키워드 안넣음
			System.out.println("1-1.키워드 안넣음");			
			if(searchdto.getFreeSubject().equals("전체보기")) { //1-1-1.말머리선택x ->전체글보기
				list = boardMapper.selectFreeBoardList(startNo,endNo); }
			else { //1-1-2.only 말머리
				list = boardMapper.selectFreeBoardSubSearchList(searchdto,startNo,endNo); } 
			
		}else {//1-2.키워드 넣음  
			System.out.println("1-2.키워드 넣음");			
			if(searchdto.getFreeSubject()!=null) { //이거 왜있는거?
				if (searchdto.getFreeSubject().equals("전체보기")) { //1-1-1.only 키워드
					System.out.println("1-2-1.only 키워드");
					list = boardMapper.selectFreeBoardKeySearchList(searchdto, startNo, endNo);
				} else { //1-1-2.말머리 + 키워드
					System.out.println("1-2-2.말머리 + 키워드");
					System.out.println(searchdto.getSearchKeyword());
					list = boardMapper.selectFreeBoardSubKeySearchList(searchdto, startNo, endNo);
				}
			}
			}
		return list; }

	@Override
	public int getSearchListCount(SearchDto searchDto) throws Exception {
		int result = 0;
		if(searchDto.getSearchKeyword() == null || searchDto.getSearchKeyword().equals("")){ //1-1.키워드 안넣음
			if(searchDto.getFreeSubject().equals("전체보기")) { //1-1-1.말머리선택x ->전체글보기
				System.out.println("1-1-1 말머리 선택x 전체글보기 카운트");
				result = boardMapper.getListCount(); }
			else { //1-1-2.only 말머리
				System.out.println("1-1-2 말머리 보기 카운트");
				result = boardMapper.getSearchsubListCount(searchDto);
			}
			
		}else {
		 //1-2.키워드 넣음
		if(searchDto.getFreeSubject()!=null){
			System.out.println("1-2.키워드 넣음 카운트");
			if(searchDto.getFreeSubject().equals("전체보기")) { //1-2-1.only 키워드
				System.out.println("1-2-1.only 키워드 카운트");
				System.out.println(searchDto.getSearchKeyword());
				System.out.println(searchDto.getSearchType());
				result =boardMapper.getSearchkeyListCount(searchDto);
				System.out.println("result======>"+result);
			}else { //1-2-2.말머리 + 키워드
				System.out.println("1-2-2.말머리 + 키워드 카운트");
				result = boardMapper.getSearchsubkeyListCount(searchDto);
			}
		}
	
		System.out.println("result=>"+result);
	}
		return result;
		}

	@Override
	public BoardFileDto selectBoardFileInformation(int idx, int freeNum) throws Exception {

		return boardMapper.selectBoardFileInformation(idx,freeNum);
	}


	// ============================study 게시판 관련
	@Override
	public List<StudyBoardDto> selectStudyBoardList() throws Exception {
		return boardMapper.selectStudyBoardList();
	}
	@Override
	public StudyBoardDto selectStudyBoardCont(int studyNum) throws Exception {
		return boardMapper.selectStudyBoardCont(studyNum);
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
	public void writeFreeBoardReply(FreeBoardReplyDto freeReplyBoard) throws Exception {
		boardMapper.writeFreeReplyBoard(freeReplyBoard);
	}

	@Override
	public void writeFreeBoardRereply(FreeBoardReplyDto replyDto) throws Exception {
		boardMapper.writeFreeBoardRereply(replyDto);
	}


	@Override
	public void modifyFreeBoardReply(FreeBoardReplyDto replyDto) throws Exception {
		boardMapper.modifyFreeBoardReply(replyDto);
	}

	@Override
	public void deleteFreeBoardRereply(int freeReplyNum) throws Exception {
		boardMapper.deleteFreeBoardRereply(freeReplyNum);
	}

	@Override
	public void deleteFreeBoardfile(int idx) throws Exception {
		boardMapper.deleteFreeBoardfile(idx);
	}

	@Override
		public void insertStudyBoard(StudyBoardDto studyBoard) throws Exception {
			boardMapper.insertStudyBoard(studyBoard);
		}

	@Override
	public List<StudyBoardDto> myBookmark(String memId) throws Exception {
		return boardMapper.myBookmark(memId);
	}
}
