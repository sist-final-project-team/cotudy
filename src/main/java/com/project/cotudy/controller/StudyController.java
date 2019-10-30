package com.project.cotudy.controller;

import java.io.File;
import java.util.ArrayList;
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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import com.project.cotudy.model.BoardFileDto;
import com.project.cotudy.model.FreeBoardDto;
import com.project.cotudy.model.SearchDto;
import com.project.cotudy.model.FreeBoardReplyDto;
import com.project.cotudy.model.StudyMemberDto;
import com.project.cotudy.service.Email;
import com.project.cotudy.service.EmailSender;
import org.springframework.web.bind.annotation.*;
import java.io.PrintWriter;

@Controller
public class StudyController {

	@Autowired
	private MemberService memberService;

	@Autowired
	private BoardService boardService;
	
    @Autowired
    private EmailSender emailSender;
    
    @Autowired
    private Email email;

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

	
	
	/*
	 * @RequestMapping(method = RequestMethod.POST, value = "/loginCheck") public
	 * String loginCheck(HttpSession session, @RequestParam("id") String
	 * id, @RequestParam("pwd") String pwd) throws Exception { if
	 * (memberService.loginCheck(id, pwd)) { session.setAttribute("login", id); }
	 * else { return "redirect:/login"; } return "/main"; }
	 */
	@RequestMapping("/notice")
	public String notice() {
		return "/notice";
	}

	@RequestMapping("/freeCont")
	public ModelAndView freeBoardCont(@RequestParam("freeNum") int freeNum) throws Exception {
		ModelAndView mv = new ModelAndView("/freeboard/freeBoardCont");
		List<FreeBoardReplyDto> replyDto = boardService.selectFreeBoardReplyList(freeNum);   
		boardService.updateFreeBoardHitCount(freeNum);	//조회수증가
		FreeBoardDto freeboard = boardService.selectFreeBoardCont(freeNum);	//글내용가져오기
		List<BoardFileDto> fileDtolist = boardService.selectBoardFileDto(freeNum);//첨부파일가져오기
		// System.out.println("파일경로는~?"+fileDtolist.get(0).getStoredFilePath());
		 int filecount = fileDtolist.size() -1;
		 System.out.println("파일개수는??"+filecount);
		 for(int i=0; i<freeboard.getFileList().size(); i++) {
			 freeboard.getFileList().get(i).setFileSize((int)(freeboard.getFileList().get(i).getFileSize()/1024));
		 }
		
				// filedto정보 가져오는 메소드 만들어서 가져온다음에
				//file dto를 아래처럼 add한 다음
				//cont 에서 받아서 dto.getstored해서 이름 가져와서
				//img src로 뽑기
		mv.addObject("replyDto",replyDto);
		mv.addObject("freeboard", freeboard);
		mv.addObject("fileDtolist", fileDtolist);
		mv.addObject("filecount",filecount );
		return mv;
	}

	@RequestMapping("/freeEdit")
	public String freeBoardEdit(FreeBoardDto freeBoard, MultipartHttpServletRequest multireq) throws Exception{
		List<MultipartFile> fileList =  multireq.getFiles("files"); //files:write에서 파일첨부의 files
		boardService.updateFreeBoard(freeBoard, multireq);
		
		 return "redirect:/freeCont?freeNum="+freeBoard.getFreeNum();			
		
	}

	
	@RequestMapping("/freeEditForm")
	public ModelAndView freeBoardEditForm(@RequestParam("freeNum") int freeNum) throws Exception{
		ModelAndView mv = new ModelAndView("/freeboard/freeBoardEdit");
		FreeBoardDto freeboard = boardService.selectFreeBoardCont(freeNum);	//글내용 가져오기
		
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
		List<MultipartFile> fileList =  multireq.getFiles("files"); //files:write에서 파일첨부의 files
		//System.out.println("fileList는1??"+fileList.get(0));
		//org.springframework.web.multipart.commons.CommonsMultipartFile@49c3ccb4 찍힘
		
		boardService.insertFreeBoard(freeboard, multireq);
	
		
		return "redirect:/freeList";
	}
	
	@RequestMapping(method = RequestMethod.GET, value = "/freeDelete")
	public void freeBoardDelete(@RequestParam("freeNum") int freeNum,HttpServletResponse response) throws Exception{
		boardService.deleteFreeBoard(freeNum);
		 response.setContentType("text/html; charset=UTF-8");
	        PrintWriter out = response.getWriter();
	        out.println("<script>");
	        out.println("alert('삭제가 완료되었습니다.')");
	        out.println("location.href='/freeList'");
	        out.println("</script>");
	}

	 /* 로그인 및 회원가입 관련 */
    @RequestMapping("findid_ok")
    public void findId_ok(@RequestParam("memName") String memName,@RequestParam("memEmail") String memEmail,HttpServletResponse response) throws Exception {
        response.setContentType("text/html; charset= UTF-8");
        PrintWriter out = response.getWriter();
        String id = memberService.findId(memName,memEmail);
        if(id != null){
            out.println("<script>");
            out.println("alert('회원님의 아이디는"+id+"입니다')");
            out.println("window.open(\"/login\", \"로그인 화면\", \"top=300, left=300, width=500, height=600, status=no, menubar=no, toolbar=no, resizable=no\");");
            out.println("</script>");
        }else{
            out.println("<script>");
            out.println("alert('회원정보가없습니다.')");
            out.println("self.close()");
            out.println("</script>");
        }

    }
    @RequestMapping("findid")
    public String findId(){return "/findid";}
    @RequestMapping("findPwd")
    public String findPwd(){return "/findPwd";}
    @RequestMapping("findPwd_ok")
    public void findPw(@RequestParam("memId") String memId,@RequestParam("memName") String memName,@RequestParam("memEmail") String memEmail,HttpServletResponse response) throws Exception {
        response.setContentType("text/html; charset= UTF-8");
        PrintWriter out = response.getWriter();
        String id = memId;
        String e_mail = memEmail;
        String pwd = memberService.findPwd(memId,memName,memEmail);
        if(pwd!=null){

            email.setContent("비밀번호는 "+pwd+" 입니다.");
            email.setReceiver(e_mail);
            email.setSubject(id+"님 비밀번호 찾기 메일입니다.");
            emailSender.SendEmail(email);
            out.println("<script>");
            out.println("alert('메일을 보냈습니다 확인하세요')");
            out.println("self.close()");
            out.println("</script>");
        }else{
            out.println("<script>");
            out.println("alert('정보가 잘못되었습니다.')");
            out.println("location.href='/findPwd'");
            out.println("</script>");
        }
    }

    @RequestMapping("/check")      // id중복 확인해서 ajax data값으로 넘기기 위한 jsp
    @ResponseBody
    public int idcheck(@RequestParam("userId") String memId) throws Exception {
        int result = 0;
        if(memberService.checkMemberId(memId)==1){
            result = memberService.checkMemberId(memId);
        }
        System.out.println(result);
        return result;
    }
    @RequestMapping("/join_ok")
    public String joinOk(StudyMemberDto memberDto) throws Exception {
        memberService.register(memberDto);
        return "/main";
    }
    
    @ModelAttribute("memId")
    public String member(HttpServletRequest request){       // session에 저장된 memId호출해서 넘길거임.
        return (String) request.getSession().getAttribute("memId");
    }

    @RequestMapping("/logout")
    public String logout(){
        return "/logout";
    }

    @RequestMapping("/join")
    public String join() { return "/join"; }

    @RequestMapping("/login")
    public String login() { return "/login";   }

    @RequestMapping(method = RequestMethod.POST, value = "/login_ok")
    public void loginOk(HttpSession session, @RequestParam("id") String id, @RequestParam("pwd") String pwd, HttpServletResponse response) throws Exception {
        response.setContentType("text/html; charset= UTF-8");
        PrintWriter out = response.getWriter();
        if(memberService.loginCheck(id,pwd)){
            session.setAttribute("memId",id);
            out.println("<script>");
            out.println(" window.opener.top.location.href='/'");
            out.println("self.close()");
            out.println("</script>");
        }else{
            out.println("<script>");
            out.println("alert('정보가 잘못되었습니다.')");
            out.println("location.href='/login'");
            out.println("</script>");
        }
    }

    /* 자유게시판 댓글 관련*/
    @RequestMapping("/freeReplyWrite")
    public void freeReplyWrite(FreeBoardReplyDto dto,HttpServletResponse response) throws Exception {
      //  boardService.updateFreeBoardReply(dto);
        boardService.writeFreeBoardReply(dto);
        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();
        out.println("<script>");
        out.println("alert('댓글이 등록되었습니다.')");
        out.println("location.href='/freeCont?freeNum="+dto.getFreeNum()+"'");
        out.println("</script>");
    }

    /* 스터디 게시판 관련 */
    @RequestMapping("/studyCont")
	public String studyBoardCont() {
		return "/studyBoardCont";
	}

	@RequestMapping("/studyCreate")
	public String studyBoardCreate() {
		return "/studyBoardCreate";
	}
	/* 마이페이지 관련 */

	@RequestMapping("/bookMark")
	public String memBookMark() {
		return "/mypage/memBookMark";
	}

	@RequestMapping("/infoEditForm")
	public ModelAndView memInfoEditForm(HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView("/mypage/memInfoEditForm");
		String memId = (String) request.getSession().getAttribute("memId");
		StudyMemberDto meminfodto = memberService.selectMyInfo(memId); //회원정보 가져오기
		mv.addObject("meminfodto", meminfodto);
		
		return mv;
	}
	
	 @RequestMapping("/infoEdit") public String memInfoEdit(StudyMemberDto memberDto) throws Exception{
		 memberService.updateMember(memberDto);
		 return "redirect:/myPage";
	  
	  }	
	
	@RequestMapping("/pwdEditForm")
	public ModelAndView mempwdEditForm() throws Exception {
		ModelAndView mv = new ModelAndView("/mypage/mempwdEditForm");
		return mv;
	}
	
	 @RequestMapping("/pwdEdit") public void mempwdEdit(HttpServletRequest request, HttpServletResponse response,
			 					@RequestParam("nowpwd") String nowpwd, @RequestParam("editpwd") String editpwd ) throws Exception{
		 String memId = (String) request.getSession().getAttribute("memId");
		 StudyMemberDto meminfodto = memberService.selectMyInfo(memId);
		 response.setContentType("text/html; charset=UTF-8");
		 PrintWriter out = response.getWriter();

		 if(meminfodto.getMemPwd().equals(nowpwd)) { //비밀번호 제대로 입력
			 
			 //System.out.println("아이디 비밀번호는?????"+memId+editpwd);
			 memberService.updateMemberpwd(memId, editpwd );	
		        out.println("<script>");
		        out.println("alert('비밀번호 변경이 완료되었습니다.')");
		        out.println("location.href='/myPage'");
		        out.println("</script>");
		 }else { //비번 틀림
		        out.println("<script>");
		        out.println("alert('비밀번호를 잘못 입력하셨습니다.')");
		        out.println("history.back()");
		        out.println("</script>");
		 }
	  
	  }
	

	 

	@RequestMapping("/myWrite")
	public String memMyWrite() {
		return "/mypage/memMyWrite";
	}

	@RequestMapping("/out")
	public String memOut() {
		return "/mypage/memOut";
	}
	
	@RequestMapping("/myPage")
	public ModelAndView memPage(HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView("/mypage/memPage");
		String memId = (String) request.getSession().getAttribute("memId");
		//System.out.println("아이디는?????"+memId);
		StudyMemberDto meminfodto = memberService.selectMyInfo(memId); //회원정보 가져오기
		mv.addObject("meminfodto", meminfodto);
		
		return mv;
	}
	
   
}
