package com.project.cotudy.controller;

import java.io.File;
import java.util.List;
import org.apache.commons.io.FileUtils;
import java.net.URLEncoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.project.cotudy.service.BoardService;
import com.project.cotudy.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.project.cotudy.model.BoardFileDto;
import com.project.cotudy.model.FreeBoardDto;
import com.project.cotudy.model.SearchDto;

@Controller
public class StudyController {

	@Autowired
	private MemberService memberService;

	@Autowired
	private BoardService boardService;

	@RequestMapping("/")
	public String main(HttpServletRequest request) {
		String rtnPage = "index";
		String ipAddress = request.getHeader("X-FORWARDED-FOR");
		if (ipAddress == null) {
			ipAddress = request.getRemoteAddr();
		}

		return "/main";
	}

	@RequestMapping("/event")
	public String event() {
		return "/event";
	}

	@RequestMapping("/login")
	public String login() {
		return "/login";
	}
	
	@RequestMapping(method = RequestMethod.POST, value = "/loginCheck")
	public String loginCheck(HttpSession session, @RequestParam("id") String id, @RequestParam("pwd") String pwd)
			throws Exception {
		if (memberService.loginCheck(id, pwd)) {
			session.setAttribute("login", id);
		} else {
			return "redirect:/login";
		}
		return "/main";
	}

	@RequestMapping("/logout") public String logout(HttpSession session) throws Exception{
		
		session.setAttribute("login", null);
		session.invalidate();
		
		return "/main";
	}
	
	@RequestMapping("/join")
	public String join() {
		return "/join";
	}

	@RequestMapping("/notice")
	public String notice() {
		return "/notice";
	}

	@RequestMapping("/freeCont")
	public ModelAndView freeBoardCont(@RequestParam int freeNum) throws Exception {
		ModelAndView mv = new ModelAndView("/freeboard/freeBoardCont");
		boardService.updateFreeBoardHitCount(freeNum);	//조회수증가
		FreeBoardDto freeboard = boardService.selectFreeBoardCont(freeNum);	//가져오기
		mv.addObject("freeboard", freeboard);

		return mv;
	}

	@RequestMapping("/freeEdit")
	public String freeBoardEdit(FreeBoardDto freeBoard) throws Exception{
		boardService.updateFreeBoard(freeBoard);
	
		return "redirect:/freeList";
	}
	
	@RequestMapping("/freeEditForm")
	public ModelAndView freeBoardEditForm(int freeNum) throws Exception{
		ModelAndView mv = new ModelAndView("/freeboard/freeBoardEdit");
		FreeBoardDto freeboard = boardService.selectFreeBoardCont(freeNum);
		mv.addObject("freeboard", freeboard);

		return mv;
	}	
	
	//게시글 목록 부르기
	@RequestMapping("/freeList")
	public ModelAndView freeBoardList() throws Exception {

		ModelAndView mv = new ModelAndView("/freeboard/freeBoardList");
		List<FreeBoardDto> list = boardService.selectFreeBoardList();
		mv.addObject("list", list);

		return mv;
	}
	
	
	
	  @RequestMapping("/freeSearchList") public ModelAndView freeSearch(SearchDto searchdto) throws Exception {
	  
	  System.out.println("freeSearchList메소드");
	  
	  ModelAndView mv = new ModelAndView("/freeboard/freeBoardList");
	  List<FreeBoardDto> list = boardService.selectFreeBoardSearchList(searchdto);
	  mv.addObject("list", list);
	  
	  return mv; }
	 
		@RequestMapping("downloadBoardFile")
		public void downloadBoardFile(@RequestParam int idx, @RequestParam int freeNum, HttpServletResponse response) throws Exception{
			//선택된 파일의 정보를 DB에서 조회
			BoardFileDto boardFile = boardService.selectBoardFileInformation(idx, freeNum);
			if(ObjectUtils.isEmpty(boardFile) == false) {
				String fileName = boardFile.getOriginalFileName();
				
				//위에서 조회된 파일을 읽어온 후 byte[]형태로 변환
				byte[] files = FileUtils.readFileToByteArray(new File(boardFile.getStoredFilePath()));
				
				//response의 헤더에 컨텐츠 타입, 크기, 형태 등을 설정
				response.setContentType("application/octet-stream");
				response.setContentLength(files.length);
				response.setHeader("Content-Disposition", "attachment; fileName=\"" + URLEncoder.encode(fileName,"UTF-8")+"\";");
				response.setHeader("Content-Transfer-Encoding", "binary");
				
				//위의 files를 response에 작성
				response.getOutputStream().write(files);
				
				//response 버퍼 정리 후 닫기
				response.getOutputStream().flush();
				response.getOutputStream().close();
			}
		}
	

	@RequestMapping("/freeWriteForm")
	public String freeBoardWriteForm() throws Exception {
		return "/freeboard/freeBoardWrite";
	}
	
	@RequestMapping("/freeWrite")
	public String freeBoardWrite(FreeBoardDto freeboard, MultipartHttpServletRequest multireq) throws Exception {
		boardService.insertFreeBoard(freeboard, multireq);
	
		return "redirect:/freeList";
	}
	
	@RequestMapping("/freeDelete")
	public String freeBoardDelete(int freeNum) throws Exception{
		boardService.deleteFreeBoard(freeNum);
		return "redirect:/freeList";
	}

	@RequestMapping("/studyCont")
	public String studyBoardCont() {
		return "/studyBoardCont";
	}

	@RequestMapping("/studyCreate")
	public String studyBoardCreate() {
		return "/studyBoardCreate";
	}

	@RequestMapping("/bookMark")
	public String memBookMark() {
		return "/memBookMark";
	}

	@RequestMapping("/infoEdit")
	public String memInfoEdit() {
		return "/memInfoEdit";
	}

	@RequestMapping("/myWrite")
	public String memMyWrite() {
		return "/memMyWrite";
	}

	@RequestMapping("/out")
	public String memOut() {
		return "/memOut";
	}

	@RequestMapping("/myPage")
	public String memPage() {
		return "/memPage";
	}

}
