package com.project.cotudy.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.project.cotudy.model.*;
import org.apache.commons.io.FileUtils;
import java.net.URLEncoder;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.project.cotudy.service.BoardService;
import com.project.cotudy.service.MemberService;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import com.project.cotudy.service.Email;
import com.project.cotudy.service.EmailSender;
import com.project.cotudy.service.KakaoAPI;

import org.springframework.web.bind.annotation.*;
import java.io.PrintWriter;

@Controller
public class StudyController {

    @Autowired
    private KakaoAPI kakao;
    
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

    ///////.
    @RequestMapping("/event")
    public ModelAndView event() throws IOException {
        ModelAndView mv = new ModelAndView("/event");
        String URL = "https://meetup4u.com/";
        Document doc = Jsoup.connect(URL).get();
        Element elem = doc;
        Element elem2 = doc.select("tbody").first();
        System.out.println(elem);
        mv.addObject("doc", elem);
//        mv.addObject("doc2",elem2);
        return mv;
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
        System.out.println("파일개수 -1은 ??"+filecount);
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
        mv.addObject("freeNum",freeboard.getFreeNum());
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
    public ModelAndView freeBoardList(HttpServletRequest request) throws Exception {
        int rowsize = 10;
        int block = 4;
        int totalRecord = 0;
        int allPage = 0;
        int page = 0;
        if(request.getParameter("page")!=null){
            page = Integer.parseInt(request.getParameter("page"));
        }else{
            page = 1;
        }
        int startNo = (page * rowsize)- (rowsize-1);
        int endNo = (page * rowsize);
        int startBlock = (((page-1) / block)*block)+1;
        int endBlock = (((page-1) / block)*block)+block;
        totalRecord =  boardService.getListCount();

        //   List<FreeBoardDto> list = boardService.selectFreeBoardList(page,rowsize);
        List<FreeBoardDto> list = boardService.selectFreeBoardList(page,rowsize);
        allPage = (int)Math.ceil(totalRecord / (double)rowsize);
        if(endBlock > allPage) {
            endBlock = allPage;
        }
        System.out.println(page + " " + rowsize);
        System.out.println(list.size());
        ModelAndView mv = new ModelAndView("/freeboard/freeBoardList");

        mv.addObject("page", page);
        mv.addObject("rowsize", rowsize);
        mv.addObject("block", block);
        mv.addObject("totalRecord", totalRecord);
        mv.addObject("allPage", allPage);
        mv.addObject("startNo", startNo);
        mv.addObject("endNo", endNo);
        mv.addObject("startBlock", startBlock);
        mv.addObject("endBlock", endBlock);
        mv.addObject("list", list);

        return mv;
    }


    @RequestMapping("/freeSearchList")
    public ModelAndView freeSearch(SearchDto searchdto,HttpServletRequest request) throws Exception {
        int rowsize = 10; //한번에 보여주는 글 갯수
        int block = 4; // 보여주는 페이지수 [1][2][3]
        int totalRecord = 0; // 총 글갯수
        int allPage = 0; // 총 페이지
        int page = 0; // 현재 페이지
        if(request.getParameter("page")!=null){
            page = Integer.parseInt(request.getParameter("page"));
        }else{
            page = 1;
        }
        int startNo = (page * rowsize)- (rowsize-1); //한페이지의첫글
        int endNo = (page * rowsize); //한페이지의 끝 끝
        int startBlock = (((page-1) / block)*block)+1; // 2
        int endBlock = (((page-1) / block)*block)+block; // 6
//        System.out.println("page==>" + page);
//        System.out.println("block==>" + block);
//        System.out.println("endBlock==>" + endBlock);
//        System.out.println("freeSubject=>"+searchdto.getFreeSubject());
//        System.out.println("getSearchKeyword=>"+searchdto.getSearchKeyword());
//        System.out.println("getSearchType=>"+searchdto.getSearchType());
        totalRecord =  boardService.getSearchListCount(searchdto); // '사담 검색' => 16
        allPage = (int)Math.ceil(totalRecord / (double)rowsize); // 2
        if(endBlock > allPage) {
            endBlock = allPage;
        }
        System.out.println("totalRecord =>" + totalRecord);
        System.out.println("카운트먼저 실행");
        ModelAndView mv = new ModelAndView("/freeboard/freeBoardSearchList");
        List<FreeBoardDto> list = boardService.selectFreeBoardSearchList(searchdto,page,rowsize);
//        if(list.size()==0){
//            list = boardService.selectFreeBoardSearchList(searchdto,page,rowsize);
//        }
        mv.addObject("page1", page);
        mv.addObject("rowsize1", rowsize);
        mv.addObject("block1", block);
        mv.addObject("totalRecord1", totalRecord);
        mv.addObject("allPage1", allPage);
        mv.addObject("startNo1", startNo);
        mv.addObject("endNo1", endNo);
        mv.addObject("startBlock1", startBlock);
        mv.addObject("endBlock1", endBlock);
        mv.addObject("freeSubject", searchdto.getFreeSubject());
        mv.addObject("searchType", searchdto.getSearchType());
        mv.addObject("searchKeyword", searchdto.getSearchKeyword());
        mv.addObject("list1", list);

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
    public void freeBoardWrite(FreeBoardDto freeboard, MultipartHttpServletRequest multireq, HttpServletResponse response) throws Exception {
    	 response.setContentType("text/html; charset=UTF-8");
	        PrintWriter out = response.getWriter();
	        
    	if(freeboard.getMemId().equals("null")) {	       
	        out.println("<script>");
	        out.println("alert('로그인 후 글작성 해주세요.')");
	        out.println("location.href='/freeList'");
	        out.println("</script>");
    	}else {
    		  List<MultipartFile> fileList =  multireq.getFiles("files"); //files:write에서 파일첨부의 files
              //System.out.println("fileList는1??"+fileList.get(0));
              //org.springframework.web.multipart.commons.CommonsMultipartFile@49c3ccb4 찍힘

            boardService.insertFreeBoard(freeboard, multireq);
            out.println("<script>");
  	        out.println("alert('글작성 완료.')");
  	        out.println("location.href='/freeList'");
  	        out.println("</script>");
    	}
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
    public void findId_ok(@RequestParam("memName") String memName, @RequestParam("memEmail") String memEmail, HttpServletResponse response) throws Exception {
        response.setContentType("text/html; charset= UTF-8");
        PrintWriter out = response.getWriter();
        String id = memberService.findId(memName, memEmail);
        if (id != null) {
            out.println("<script>");
            out.println("alert('회원님의 아이디는" + id + "입니다')");
            out.println("window.open(\"/login\", \"로그인 화면\", \"top=300, left=300, width=500, height=600, status=no, menubar=no, toolbar=no, resizable=no\");");
            out.println("self.close()");
            out.println("</script>");
        } else {
            out.println("<script>");
            out.println("alert('회원정보가없습니다.')");
            out.println("self.close()");
            out.println("</script>");
        }

    }

    @RequestMapping("findid")
    public String findId() {
        return "/findid";
    }

    @RequestMapping("findPwd")
    public String findPwd() {
        return "/findPwd";
    }

    @RequestMapping("findPwd_ok")
    public void findPw(@RequestParam("memId") String memId, @RequestParam("memName") String memName, @RequestParam("memEmail") String memEmail, HttpServletResponse response) throws Exception {
        response.setContentType("text/html; charset= UTF-8");
        PrintWriter out = response.getWriter();
        String id = memId;
        String e_mail = memEmail;
        String pwd = memberService.findPwd(memId, memName, memEmail);
        if (pwd != null) {

            email.setContent("비밀번호는 " + pwd + " 입니다.");
            email.setReceiver(e_mail);
            email.setSubject(id + "님 비밀번호 찾기 메일입니다.");
            emailSender.SendEmail(email);
            out.println("<script>");
            out.println("alert('메일을 보냈습니다 확인하세요')");
            out.println("self.close()");
            out.println("</script>");
        } else {
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
        if (memberService.checkMemberId(memId) == 1) {
            result = memberService.checkMemberId(memId);
        }
        return result;
    }

    @RequestMapping("/join_ok")
    public String joinOk(StudyMemberDto memberDto) throws Exception {
        memberService.register(memberDto);
        return "/main";
    }

    @ModelAttribute("memId")
    public String member(HttpServletRequest request) {       // session에 저장된 memId호출해서 넘길거임.
        return (String) request.getSession().getAttribute("memId");
    }

    @RequestMapping("/logout")
    public String logout(HttpSession session) {
    	//아래 세줄은 카카오 로그아웃 관련
    	kakao.kakaoLogout((String)session.getAttribute("access_Token"));
    	session.removeAttribute("access_Token");
    	session.removeAttribute("userId");
        return "/logout";
    }

    @RequestMapping("/join")
    public String join() {
        return "/join";
    }

    @RequestMapping("/login")
    public String login() {
        return "/login";
    }

    //일반로그인
    @RequestMapping(method = RequestMethod.POST, value = "/login_ok")
    public void loginOk(HttpSession session, @RequestParam("id") String id, @RequestParam("pwd") String pwd, HttpServletResponse response) throws Exception {
        response.setContentType("text/html; charset= UTF-8");
        PrintWriter out = response.getWriter();
        if (memberService.loginCheck(id, pwd)) {
            session.setAttribute("memId", id);
            out.println("<script>");
            //부모창을 원하는 페이지로 이동시킨후 자식창(자기자신)은 닫는다.
            out.println(" window.opener.top.location.href='/'");
            out.println("self.close()");
            out.println("</script>");
        } else {
            out.println("<script>");
            out.println("alert('정보가 잘못되었습니다.')");
            out.println("location.href='/login'");
            out.println("</script>");
        }
    }

    
    //카카오로그인	
    @RequestMapping("/main")
    public void callback(@RequestParam("code") String code, HttpSession session, HttpServletResponse response) throws Exception {
        response.setContentType("text/html; charset= UTF-8");
        PrintWriter out = response.getWriter(); 
        
       // ModelAndView mv = new ModelAndView("/main");
    	System.out.println("code는???" + code);

    	String access_Token = kakao.getAccessToken(code);
        System.out.println("controller access_token는???" + access_Token);    	
        
        HashMap<String, Object> userInfo = kakao.getUserInfo(access_Token);
        System.out.println("1.userInfo 닉네임은??"+userInfo.get("nickname")+"2.userInfo id는??"+userInfo.get("id")+"3.userInfo email은???"+userInfo.get("email"));
        System.out.println("컨트롤러 아이디는?"+userInfo.get("id"));
        String memId = (String)userInfo.get("id");
        String memName = (String)userInfo.get("nickname");
        String memEmail = (String)userInfo.get("email");
        //카카오로그인 id가 db에 없으면 저장시키기(가입시키기. ID, 닉네임, 이메일)
        if(memberService.kakaoDbCheck(memId)==false) {//true(아이디없을경우. 가입시켜야함)
        	memberService.kakaoRegister(memId, memName, memEmail);
        	}
        
            session.setAttribute("access_Token", access_Token);//로그아웃시 사용
            session.setAttribute("memId", userInfo.get("id"));
            out.println("<script>");
            //부모창을 원하는 페이지로 이동시킨후 자식창(자기자신)은 닫는다.
            out.println(" window.opener.top.location.href='/'");
            out.println("self.close()");
            out.println("</script>");
            
        //return mv;
    }    
    
    
    
    /* 자유게시판 댓글 관련*/
    @RequestMapping("/freeReplyWrite")
    public void freeReplyWrite(FreeBoardReplyDto dto, HttpServletResponse response) throws Exception {
        //  boardService.updateFreeBoardReply(dto);
        boardService.writeFreeBoardReply(dto);
        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();
        out.println("<script>");
        out.println("alert('댓글이 등록되었습니다.')");
        out.println("location.href='/freeCont?freeNum=" + dto.getFreeNum() + "'");
        out.println("</script>");
    }

    /* 스터디 게시판 관련 */
    @RequestMapping("/studyList")
    public ModelAndView studyBoardList() throws Exception {
        ModelAndView mv = new ModelAndView("/studyList");
        List<StudyBoardDto> studyBoardList = boardService.selectStudyBoardList();
        mv.addObject("studyList", studyBoardList);

        return mv;
    }

    @RequestMapping("/studyCont")
    public ModelAndView studyBoardCont(@RequestParam("studyNum") int studyNum) throws Exception {
        ModelAndView mv = new ModelAndView("/studyCont");
        StudyBoardDto studyBoard = boardService.selectStudyBoardCont(studyNum);
        mv.addObject("studyCont", studyBoard);

        return mv;
    }

    @RequestMapping("/studyCreate")
    public String studyBoardCreate() {
        return "/study/studyBoardCreate";
    }
    
    @RequestMapping("/studyCreateOk")
    public String studyBoardCreateOk(StudyBoardDto studyboarddto, MultipartHttpServletRequest multireq) throws Exception{
    	List<MultipartFile> fileList =  multireq.getFiles("files");
    	boardService.updateStudyBoard(studyboarddto, multireq);
    	
        return "redirect:/studyList";
    }    
    
    
    
    /* 마이페이지 관련 */

    @RequestMapping("/bookMark")
    public String memBookMark() {
        return "/mypage/memBookMark";
    }



    @RequestMapping("/myWrite")
    public ModelAndView memMyWrite(HttpSession session) throws Exception {

        ModelAndView mv = new ModelAndView("/mypage/memMyWrite");
        String memId = (String)session.getAttribute("memId");
        List<FreeBoardDto> list = memberService.selectMyFreeBoardList(memId);
        mv.addObject("list", list);
        return mv;
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

    /* 마이페이지 관련 */
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

    @RequestMapping("/memOutOk")
    public String memOutOk(HttpSession session) throws Exception {
        String memId = (String)session.getAttribute("memId");
        memberService.deleteMember(memId);
        //세션 해제 하고 메인으로 넘겨야함
        session.invalidate();
        return "/main";
    }
    // 서지훈 추가사항 대댓글 달기
    @RequestMapping("/reReply")
    public void addRereply(FreeBoardReplyDto replyDto,HttpServletResponse response) throws Exception {
        boardService.writeFreeBoardRereply(replyDto);
        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();
        out.println("<script>");
        out.println("location.href='/freeCont?freeNum=" + replyDto.getFreeNum() + "'");
        out.println("</script>");
    }
}
