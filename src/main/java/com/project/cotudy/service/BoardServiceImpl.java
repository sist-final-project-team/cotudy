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
import org.springframework.web.multipart.MultipartHttpServletRequest;
import java.util.List;

@Service
public class BoardServiceImpl implements BoardService {


	@Autowired
	private FileUtils fileUtils;
	
	@Autowired
	private BoardMapper boardMapper;

	@Override
	public List<FreeBoardDto> selectFreeBoardList() throws Exception {
		return boardMapper.selectFreeBoardList();
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
	
	
	
	
	@Override public void updateFreeBoardHitCount(int freeNum) throws Exception {
		boardMapper.updateFreeBoardHitCount(freeNum); // 조회수 증가시키기
	}

	@Override
	public List<FreeBoardReplyDto> selectFreeBoardReplyList(int freeNum) throws Exception {
		return null;
	}

	@Override
	public void deleteFreeBoardReply(int freeReplyNum) throws Exception {

	}

	@Override
	public void insertFreeBoard(FreeBoardDto freeboard, MultipartHttpServletRequest multireq) throws Exception {
		boardMapper.insertFreeBoard(freeboard);
		//업로드된 파일을 서버에 저장하고 파일정보를 가져옴
		List<BoardFileDto> list = fileUtils.parseFileInfo(freeboard.getFreeNum(), multireq);
		System.out.println("list stored는1>??"+list.get(0).getStoredFilePath());
		//System.out.println("list stored는2>??"+list.get(1).getStoredFilePath());
		//파일정보를 맵에 저장
		if(CollectionUtils.isEmpty(list) == false){
			boardMapper.insertBoardFileList(list);
		}
		
	}


	@Override
	public void updateFreeBoard(FreeBoardDto freeBoard) throws Exception {
		boardMapper.updateFreeBoard(freeBoard);
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

	
	  @Override public List<FreeBoardDto> selectFreeBoardSearchList(SearchDto searchdto) throws Exception {
	  System.out.println("freeSubject는???" + searchdto.getFreeSubject());
	  System.out.println("searchType는???" + searchdto.getSearchType());
	  System.out.println("searchKeyword는???" + searchdto.getSearchKeyword()); //1.
	  //  키워드를 넣느냐 마느냐? 
	  // 1-1 키워드 넣는 경우 
	  // 1-1-1 only 키워드 
	  // 1-1-2 키워드+말머리 
	  // 
	  // 1-2 키워드 안넣는 경우 
	  // 1-2-1 말머리도 안고름(사실상 전체글보기) 
	  // 1-2-2 only 말머리
	  
	  List<FreeBoardDto> list = null; 
	  if(searchdto.getSearchKeyword() != ""){ //1-1.키워드 넣음
		  System.out.println("1-1.키워드 넣음");
		  if(searchdto.getFreeSubject().equals("전체보기")) { //1-1-1.only 키워드
			  System.out.println("1-1-1.only 키워드"); 
			  list = boardMapper.selectFreeBoardKeySearchList(searchdto); 
		  }else { //1-1-2.말머리 + 키워드
			  System.out.println("1-1-2.말머리 + 키워드"); 
			  list = boardMapper.selectFreeBoardSubKeySearchList(searchdto); 
	  		}
		  
	  }else {//1-2.키워드 x System.out.println("키워드x");
		  if(searchdto.getFreeSubject().equals("전체보기")) { //1-2-1.말머리선택x ->전체글보기
			  System.out.println("1-2-1.말머리선택x ->전체글보기"); 
			  list = boardMapper.selectFreeBoardList(); }
		  else { //1-2-2.only 말머리
			  System.out.println("1-2-2.only 말머리");
			  list = boardMapper.selectFreeBoardSubSearchList(searchdto); } } 
	  for(int i=0; i<list.size(); i++) 
	  {
		  System.out.println(list.get(i).getFreeTitle());
		  
	  }
	  return list; }
	 
	  @Override
	  public BoardFileDto selectBoardFileInformation(int idx, int freeNum) throws Exception {
		  
		  return boardMapper.selectBoardFileInformation(idx,freeNum);
	  }
	 
	
	// ============================study 게시판 관련
    @Override
    public List<StudyBoardDto> selectStudyBoardList() {
        return null;
    }
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
    public void writeFreeBoardReply(FreeBoardReplyDto freeReplyBoard) throws Exception {
        boardMapper.writeFreeReplyBoard(freeReplyBoard);
    }

    @Override
    public void updateFreeBoardReply(FreeBoardReplyDto freeReplyBoard) throws Exception {
        boardMapper.updateFreeReplyBoard(freeReplyBoard);
    }
}
