package com.project.cotudy.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.project.cotudy.service.BoardService;
import com.project.cotudy.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
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

	/*
	 * @RequestMapping("/logout") public String logout(HttpServletRequest request)
	 * throws Exception{ request.getSession().removeAttribute("login");
	 * 
	 * return "/main";
	 * 
	 * }
	 */
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
		boardService.updateFreeBoardHitCount(freeNum);
		FreeBoardDto freeboard = boardService.selectFreeBoardCont(freeNum);
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
	 
	 
	

	@RequestMapping("/freeWriteForm")
	public String freeBoardWriteForm() throws Exception {
		return "/freeboard/freeBoardWrite";
	}
	
	@RequestMapping("/freeWrite")
	public String freeBoardWrite(FreeBoardDto freeboard) throws Exception {
		boardService.insertFreeBoard(freeboard);
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
