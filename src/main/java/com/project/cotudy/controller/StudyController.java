package com.project.cotudy.controller;

import com.project.cotudy.common.SHA256Util;
import com.project.cotudy.model.*;
import com.project.cotudy.service.*;
import org.apache.commons.io.FileUtils;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.awt.*;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

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

    @RequestMapping("/event")
    public ModelAndView event() throws IOException {
        ModelAndView mv = new ModelAndView("/event");
        String URL = "https://meetup4u.com/";
        Document doc = Jsoup.connect(URL).get();
        Element elem = doc;
        Element elem2 = doc.select("tbody").first();
        mv.addObject("doc", elem);
        return mv;
    }

    @RequestMapping("/notice")
    public String notice() {
        return "/notice";
    }

    @RequestMapping("/freeCont")
    public ModelAndView freeBoardCont(@RequestParam("freeNum") int freeNum) throws Exception {

        ModelAndView mv = new ModelAndView("/freeboard/freeBoardCont");
        List<FreeBoardReplyDto> replyDto = boardService.selectFreeBoardReplyList(freeNum);
        boardService.updateFreeBoardHitCount(freeNum);    //조회수증가
        FreeBoardDto freeboard = boardService.selectFreeBoardCont(freeNum);    //글내용가져오기
        List<BoardFileDto> fileDtolist = boardService.selectBoardFileDto(freeNum);//첨부파일가져오기
        // System.out.println("파일경로는~?"+fileDtolist.get(0).getStoredFilePath());
        int filecount = fileDtolist.size() - 1;
        System.out.println("파일개수 -1은 ??" + filecount);
        for (int i = 0; i < freeboard.getFileList().size(); i++) {
            freeboard.getFileList().get(i).setFileSize((int) (freeboard.getFileList().get(i).getFileSize() / 1024));
        }
        mv.addObject("replyDto", replyDto);
        mv.addObject("freeboard", freeboard);
        mv.addObject("fileDtolist", fileDtolist);
        mv.addObject("filecount", filecount);
        mv.addObject("freeNum", freeboard.getFreeNum());
        return mv;
    }

    @RequestMapping("/freeEdit")
    public String freeBoardEdit(FreeBoardDto freeBoard, MultipartHttpServletRequest multireq, @RequestParam("put") List<String> put, @RequestParam("fileList1") List<String> file, @RequestParam("filePath") List<String> filepath) throws Exception {
        List<MultipartFile> fileList = multireq.getFiles("files");
        boardService.updateFreeBoard(freeBoard, multireq);
        String abc[] = new String[filepath.size()];
        for (int i = 0; i < put.size(); i++) {
            if (!put.get(i).equals("")) {
                int idx = Integer.parseInt(file.get(i));
                abc[i] = filepath.get(i);
                if (abc[i].length() > 0) {
                    File f = new File(abc[i]);
                    f.delete();
                }
                boardService.deleteFreeBoardfile(idx);
            }
        }
        return "redirect:/freeCont?freeNum=" + freeBoard.getFreeNum();

    }


    @RequestMapping("/freeEditForm")
    public ModelAndView freeBoardEditForm(@RequestParam("freeNum") int freeNum) throws Exception {
        ModelAndView mv = new ModelAndView("/freeboard/freeBoardEdit");
        FreeBoardDto freeboard = boardService.selectFreeBoardCont(freeNum);    //글내용 가져오기

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
        if (request.getParameter("page") != null) {
            page = Integer.parseInt(request.getParameter("page"));
        } else {
            page = 1;
        }
        int startNo = (page * rowsize) - (rowsize - 1);
        int endNo = (page * rowsize);
        int startBlock = (((page - 1) / block) * block) + 1;
        int endBlock = (((page - 1) / block) * block) + block;

        List<FreeBoardDto> list = boardService.selectFreeBoardList(page, rowsize);
        totalRecord = boardService.getListCount();

        allPage = (int) Math.ceil(totalRecord / (double) rowsize);
        if (endBlock > allPage) {
            endBlock = allPage;
        }

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
    public ModelAndView freeSearch(SearchDto searchdto, HttpServletRequest request) throws Exception {
        int rowsize = 10; //한번에 보여주는 글 갯수
        int block = 4; // 보여주는 페이지수 [1][2][3]
        int totalRecord = 0; // 총 글갯수
        int allPage = 0; // 총 페이지
        int page = 0; // 현재 페이지
        if (request.getParameter("page") != null) {
            page = Integer.parseInt(request.getParameter("page"));
        } else {
            page = 1;
        }
        int startNo = (page * rowsize) - (rowsize - 1); //한페이지의첫글
        int endNo = (page * rowsize); //한페이지의 끝 끝
        int startBlock = (((page - 1) / block) * block) + 1; // 2
        int endBlock = (((page - 1) / block) * block) + block; // 6
        totalRecord = boardService.getSearchListCount(searchdto); // '사담 검색' => 16
        allPage = (int) Math.ceil(totalRecord / (double) rowsize); // 2
        if (endBlock > allPage) {
            endBlock = allPage;
        }
        System.out.println("totalRecord =>" + totalRecord);
        System.out.println("카운트먼저 실행");
        ModelAndView mv = new ModelAndView("/freeboard/freeBoardSearchList");
        List<FreeBoardDto> list = boardService.selectFreeBoardSearchList(searchdto, page, rowsize);

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

        return mv;
    }

    @RequestMapping("downloadBoardFile")
    public void downloadBoardFile(@RequestParam int idx, @RequestParam int freeNum, HttpServletResponse response) throws Exception {
        //선택된 파일의 정보를 DB에서 조회
        BoardFileDto boardFile = boardService.selectBoardFileInformation(idx, freeNum);
        if (ObjectUtils.isEmpty(boardFile) == false) {
            String fileName = boardFile.getOriginalFileName();

            //위에서 조회된 파일을 읽어온 후 byte[]형태로 변환

            byte[] files = FileUtils.readFileToByteArray(new File(boardFile.getStoredFilePath()));

            //response의 헤더에 컨텐츠 타입, 크기, 형태 등을 설정
            response.setContentType("application/octet-stream");
            response.setContentLength(files.length);
            response.setHeader("Content-Disposition", "attachment; fileName=\"" + URLEncoder.encode(fileName, "UTF-8") + "\";");
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

    //조아라 수정 : 로그인안하고 글작성 금지start////////////////////////////
    @RequestMapping("/freeWrite")
    public void freeBoardWrite(FreeBoardDto freeboard, MultipartHttpServletRequest multireq, HttpServletResponse response) throws Exception {
        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();

        if (freeboard.getMemId().equals("null")) {
            out.println("<script>");
            out.println("alert('로그인 후 글작성 해주세요.')");
            out.println("location.href='/freeList'");
            out.println("</script>");
        } else {
            List<MultipartFile> fileList = multireq.getFiles("files"); //files:write에서 파일첨부의 files
            //System.out.println("fileList는1??"+fileList.get(0));
            //org.springframework.web.multipart.commons.CommonsMultipartFile@49c3ccb4 찍힘

            boardService.insertFreeBoard(freeboard, multireq);
            out.println("<script>");
            out.println("alert('글작성 완료.')");
            out.println("location.href='/freeList'");
            out.println("</script>");
        }

    }
    //조아라 수정 : 로그인안하고 글작성 금지end////////////////////////////


    //조아라 수정 : 남의 글 삭제 금지start////////////////////////////
    @RequestMapping(method = RequestMethod.GET, value = "/freeDelete")
    public void freeBoardDelete(@RequestParam("freeNum") int freeNum, @RequestParam("memId") String memId, HttpServletResponse response,HttpServletRequest request) throws Exception{
    	String id = (String)request.getSession().getAttribute("memId");
    	

    	response.setContentType("text/html; charset=UTF-8");
    	PrintWriter out = response.getWriter();

    	if(id.equals(memId)) {
    		boardService.deleteFreeBoard(freeNum);
    		out.println("<script>");
    		out.println("alert('삭제가 완료되었습니다.')");
    		out.println("location.href='/freeList'");
    		out.println("</script>");
    	}else {
    		out.println("<script>");
    		out.println("alert('남의 글 삭제하지 마셈.')");
    		out.println("location.href='/freeList'");
    		out.println("</script>");
    	}
    }
    //조아라 수정 : 남의 글 삭제 금지end////////////////////////////

    /* 로그인 및 회원가입 관련 */
    @RequestMapping("findid_ok")
    public void findId_ok(@RequestParam("memName") String memName, @RequestParam("memEmail") String memEmail, HttpServletResponse response) throws Exception {
        response.setContentType("text/html; charset= UTF-8");
        PrintWriter out = response.getWriter();
        List<String> id = memberService.findId(memName, memEmail);
        if (id != null) {
            out.println("<script>");
            out.println("alert('회원님의 아이디는" + id.toString() + "입니다')");
            out.println("window.open(\"/login\", \"로그인 화면\", \"top=300, left=300, width=500, height=600, status=no, menubar=no, toolbar=no, resizable=no\");");
           /* out.println("self.close()");*/
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
        //비번 가져와서
        String pwd = memberService.findPwd(memId, memName, memEmail);
        
    	//id로 salt 가져오기(암호화, 로그인종류(카카오or일반) 구분위해)
    	String salt = memberService.getSaltById(id);
    	System.out.println("salt는??????????????????????????????????????"+salt);
    	if(salt==null) {//카카오로그인
            out.println("<script>");
            out.println("alert('카카오 ID는 비밀번호 찾기가 불가능합니다.')");
            out.println("location.href='/findPwd'");
            out.println("</script>");
    	}else {//일반로그인
    		
        if (pwd != null) {//정보에 맞는 비번 있으면
        	//난수발생시켜서 새로운 비번으로 db에 저장한 후 사용자에게 난수 메일로 알려주기
        	//난수발생시키기
        	int intpwd = (int) (Math.random() * 1000000) + 1;
        	String newpwd = Integer.toString(intpwd);
        	
        	//암호화
        	String newpwdsha = SHA256Util.getEncrypt(newpwd, salt);         	
        	//db에 저장하고
        	memberService.insertNewPwd(memId ,newpwdsha);
        	
        	//난수 이메일로 보내주기
        	email.setReceiver(e_mail);
        	email.setSubject(id + "님 코터디 비밀번호 찾기 메일입니다.");
            email.setContent("비밀번호가 " + newpwd + "로 초기화 되었습니다. 로그인 후 마이페이지에서 비밀번호를 변경해 주세요.");
            emailSender.SendEmail(email);
            out.println("<script>");
            out.println("alert('메일을 보냈습니다. 확인하세요')");
            out.println("self.close()");
            out.println("</script>");
        } else {
        	System.out.println("PWD null이네...");
            out.println("<script>");
            out.println("alert('정보가 잘못되었습니다.')");
            out.println("location.href='/findPwd'");
            out.println("</script>");
        }
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
    	//비밀번호 암호화(SHA-256)start -조아라
    	String salt = SHA256Util.generateSalt();
    	memberDto.setMemSalt(salt);
    	
    	String pwd = memberDto.getMemPwd();
    	pwd = SHA256Util.getEncrypt(pwd, salt);
    	memberDto.setMemPwd(pwd);
    	//암호화해서 dto에 담기 끝
    	
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
    	if((String)session.getAttribute("access_Token")!=null) {
    		kakao.kakaoLogout((String)session.getAttribute("access_Token"));
    		session.removeAttribute("access_Token");
    		//session.removeAttribute("userId");
    		
    	}
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
        //암호화 관련
        //해당 id의 salt값 가져오기
        String salt = memberService.getSaltById(id);
        if(salt!=null){
            //로그인시 받은 비번 암호화(하면 db랑 같아짐)
            pwd = SHA256Util.getEncrypt(pwd, salt);
        }

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

        //이전에 탈퇴했다가 로그인하는사람일경우(status x일 경우) o로 바꿔주기
        StudyMemberDto meminfodto = memberService.selectMyInfo(memId); //회원정보 가져오기
        if(meminfodto.getMemStatus().equals("X")) {
        	memberService.changeStatus(memId);
        	}
        
            session.setAttribute("access_Token", access_Token);//로그아웃시 사용
            session.setAttribute("memId", userInfo.get("id"));
            out.println("<script>");
            //부모창을 원하는 페이지로 이동시킨후 자식창(자기자신)은 닫는다.
            out.println(" window.opener.top.location.href='/'");
            out.println("self.close()");
            out.println("</script>");
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
        ModelAndView mv = new ModelAndView("/study/studyBoardList");
        List<StudyBoardDto> studyBoardList = boardService.selectStudyBoardList();
        mv.addObject("studyList", studyBoardList);

        return mv;
    }

    @RequestMapping("/studyCont")
    public ModelAndView studyBoardCont(@RequestParam("studyNum") int studyNum, HttpSession session) throws Exception {
        String memId = (String) session.getAttribute("memId");
        ModelAndView mv = new ModelAndView("/study/studyBoardCont");
        int check = boardService.contBookmark(studyNum, memId);

        // System.out.println(studyNum+"   " +memId);
        StudyBoardDto studyBoard = boardService.selectStudyBoardCont(studyNum);

        mv.addObject("studyCont", studyBoard);
        mv.addObject("contBookmark", check);

        return mv;
    }

    @RequestMapping("/studyCreate")
    public void studyBoardCreate(HttpSession session, HttpServletResponse response) throws Exception {
        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();
        if (session.getAttribute("memId") == null) {
            out.println("<script>");
            out.println("alert('로그인이 필요합니다')");
            out.println("window.open('/login', '로그인 화면', 'top=300, left=700, width=500, height=600, status=no, menubar=no, toolbar=no, resizable=no')");
            out.println("location.href='/'");
            out.println("</script>");
        } else {
            out.println("<script>");
            out.println("location.href='/studyCreateForm'");
            out.println("</script>");
        }
    }

    @RequestMapping("/studySearch")
    public ModelAndView studyBoardSearch(@RequestParam(value = "areas", required = false) String[] areas, @RequestParam(value = "keywords", required = false) String[] keywords) throws Exception {
        ModelAndView mv = new ModelAndView("/study/studyBoardList");

        // 전체 스터디 리스트 호출
        List<StudyBoardDto> studyBoardList = boardService.selectStudyBoardList();

        List<StudyBoardDto> searchStudyBoardList = new ArrayList<>();

        // 검색 조건이 하나도 들어오지 않았을 경우에는 전체 리스트 출력
        if (areas == null && keywords == null) {
            mv.addObject("studyList", studyBoardList);
            return mv;
        }

        if (studyBoardList != null) {
            for (StudyBoardDto studyBoard : studyBoardList) {
                boolean addFlag = false;
                if (areas != null) {
                    for (String area : areas) {
                        if (studyBoard.getStudyArea().equals(area)) {
                            addFlag = true;
                            break;
                        }
                    }
                }
                if (keywords != null) {
                    String[] studyBoardKeywords = studyBoard.getStudyKeyword().split(",");
                    for (String keyword : keywords) {
                        for (String studyBoardKeyword : studyBoardKeywords) {
                            if (studyBoardKeyword.equals(keyword)) {
                                addFlag = true;
                                break;
                            }
                        }
                    }
                }
                if (addFlag) {
                    searchStudyBoardList.add(studyBoard);
                }
            }
        }
        mv.addObject("studyList", searchStudyBoardList);
        return mv;
    }

    @RequestMapping("/studyCreateForm")
    public String studyCreateForm() {
       return "/study/studyBoardCreate";
    }


    @RequestMapping("/studyCreateOk")
    public String studyCreateOk(StudyBoardDto studyBoard) throws Exception {
        boardService.insertStudyBoard(studyBoard);
        return "redirect:/studyList";
    }

    /* 마이페이지 관련 */
    @RequestMapping("/myWrite")
    public ModelAndView memMyWrite(HttpSession session) throws Exception {
        ModelAndView mv = new ModelAndView("/mypage/memMyWrite");
        String memId = (String) session.getAttribute("memId");
        List<FreeBoardDto> freeList = memberService.selectMyFreeBoardList(memId);
        List<StudyBoardDto> studyList = memberService.selectMyStudyList(memId);
        mv.addObject("freeList", freeList);
        mv.addObject("studyList", studyList);
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

    @RequestMapping("/infoEdit")
    public String memInfoEdit(StudyMemberDto memberDto) throws Exception {
        memberService.updateMember(memberDto);
        return "redirect:/myPage";

    }

    @RequestMapping("/pwdEditForm")
    public ModelAndView mempwdEditForm() throws Exception {
        ModelAndView mv = new ModelAndView("/mypage/mempwdEditForm");
        return mv;
    }

    @RequestMapping("/pwdEdit")
    public void mempwdEdit(HttpServletRequest request, HttpServletResponse response,
                           @RequestParam("nowpwd") String nowpwd, @RequestParam("editpwd") String editpwd) throws Exception {
        String memId = (String) request.getSession().getAttribute("memId");
        //회원정보 가져오기
        StudyMemberDto meminfodto = memberService.selectMyInfo(memId);
        
        //nowpwd 비밀번호 암호화
        //해당 id의 salt값 가져오기
        String salt = memberService.getSaltById(meminfodto.getMemId());
        //로그인시 받은 비번 암호화(하면 db랑 같아짐)
        String shapwd = SHA256Util.getEncrypt(nowpwd, salt);
        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();

        //nowpwd이랑 db비번이랑 비교
        if(meminfodto.getMemPwd().equals(shapwd)) { //비밀번호 제대로 입력
            //editpwd 암호화
            String epwd = SHA256Util.getEncrypt(editpwd, salt);
            //db에 넣기
            memberService.updateMemberpwd(memId, epwd );
            out.println("<script>");
            out.println("alert('비밀번호 변경이 완료되었습니다.')");
            out.println("location.href='/myPage'");
            out.println("</script>");
        } else { //비번 틀림
            out.println("<script>");
            out.println("alert('비밀번호를 잘못 입력하셨습니다.')");
            out.println("history.back()");
            out.println("</script>");
        }

    }
    
    //회원탈퇴
    @RequestMapping("/memOutOk")
    public String memOutOk(HttpSession session) throws Exception {
        String memId = (String) session.getAttribute("memId");
        memberService.deleteMember(memId);
        if((String)session.getAttribute("access_Token")!=null) {
            kakao.kakaoLogout((String)session.getAttribute("access_Token"));
            session.removeAttribute("access_Token");
            session.removeAttribute("userId");
        }
        //세션 해제 하고 메인으로 넘겨야함
        session.invalidate();
        //카카오 세션해제

        
        return "/main";
    }

    // 서지훈 추가사항 대댓글 달기
    @RequestMapping("/reReply")
    public void addRereply(FreeBoardReplyDto replyDto, HttpServletResponse response) throws Exception {
        boardService.writeFreeBoardRereply(replyDto);
        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();
        out.println("<script>");
        out.println("location.href='/freeCont?freeNum=" + replyDto.getFreeNum() + "'");
        out.println("</script>");
    }

    // 서지훈 추가사항 댓글 수정
    @RequestMapping("/freeReplyModify")
    public void modifyReply(FreeBoardReplyDto replyDto, HttpServletResponse response) throws Exception {
        boardService.modifyFreeBoardReply(replyDto);
        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();
        out.println("<script>");
        out.println("location.href='/freeCont?freeNum=" + replyDto.getFreeNum() + "'");
        out.println("</script>");
    }

    @RequestMapping("/freeReplyDelete")
    public void freeReplyDelete(@RequestParam("freeReplyNum") int freeReplyNum, @RequestParam("replyStep") int replyStep, HttpServletResponse response, @RequestParam("freeNum") int freeNum) throws Exception {
        boardService.deleteFreeBoardReply(freeReplyNum);
        if (replyStep == 0) {
            boardService.deleteFreeBoardRereply(freeReplyNum);
        }
        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();
        out.println("<script>");
        out.println("location.href='/freeCont?freeNum=" + freeNum + "'");
        out.println("</script>");
    }

    // 지훈이 북마크 추가 한다잉?
    @RequestMapping("/bookmark")
    @ResponseBody
    public int bookMark(@RequestParam("id") String memId, @RequestParam("studyNum") int StudyNum) throws Exception {
        int result = 0;
        System.out.println("들어와서 실행");
        if (memberService.checkBookMark(memId, StudyNum)) {
            memberService.deleteBookMark(memId, StudyNum);
            System.out.println("checkBookMark//" + result);
        } else {
            memberService.insertBookMark(memId, StudyNum);
            result = 1;
            System.out.println("checkBookMark And Insert//" + result);
        }
        System.out.println(result);
        return result;
    }

    @RequestMapping("/myBookMark")
    public ModelAndView myBookmark(HttpSession session) throws Exception {
        String memId = (String) session.getAttribute("memId");
        ModelAndView mv = new ModelAndView("/mypage/memBookMark");
        List<StudyBoardDto> list = boardService.myBookmark(memId);
        mv.addObject("list", list);
        return mv;
    }


    @RequestMapping(method = RequestMethod.GET, value = "/studyDelete")
    public void studyBoardDelete(@RequestParam("studyNum") int studyNum, @RequestParam("memId") String memId, HttpServletResponse response, HttpServletRequest request) throws Exception {
        String id = (String) request.getSession().getAttribute("memId");


        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();

        if (id.equals(memId)) {
            boardService.deleteStudyBoard(studyNum);
            out.println("<script>");
            out.println("alert('삭제가 완료되었습니다.')");
            out.println("location.href='/studyList'");
            out.println("</script>");

        } else {
            out.println("<script>");
            out.println("alert('남의 글 삭제하지 마셈.')");
            out.println("location.href='/studyList'");
            out.println("</script>");
        }
    }

    @RequestMapping("/studyEdit")
    public String studyBoardEdit(StudyBoardDto studyBoard) throws Exception {
        //List<MultipartFile> fileList =  multireq.getFiles("files");
        boardService.updateStudyBoard(studyBoard);

        return "redirect:/studyCont?studyNum=" + studyBoard.getStudyNum();
    }

    @RequestMapping("/studyEditForm")
    public ModelAndView studyBoardEditForm(@RequestParam("studyNum") int studyNum) throws Exception {
        ModelAndView mv = new ModelAndView("/study/studyBoardEdit");
        StudyBoardDto studyBoard = boardService.selectStudyBoardCont(studyNum);    //글내용 가져오기

        mv.addObject("studyBoard", studyBoard);

        return mv;
    }

    // 서지훈 스터디게시판 댓글 달기
    @RequestMapping("/studyCmt")
    @ResponseBody
    public String studyComment(StudyBoardReplyDto studyBoardReplyDto) throws Exception {
        System.out.println(studyBoardReplyDto.toString());
        boardService.insertStudyBoardReply(studyBoardReplyDto);
        return "success";
    }

    @RequestMapping("/studyReplyList")
    @ResponseBody
    public ResponseEntity<List<StudyBoardReplyDto>> studyReplyList(@RequestParam("studyNum") int studyNum) throws Exception {

        ResponseEntity<List<StudyBoardReplyDto>> entity = null;
        entity = new ResponseEntity<>(boardService.selectStudyBoardReplyList(studyNum), HttpStatus.OK);
        return entity;
    }
    @RequestMapping(value = "/studyReplyDelete")
    public void studyReplyDelete(@RequestParam("studyReplyNum") String studyReplyNum1, @RequestParam("studyNum") String studyNum1,@RequestParam("studyReplyStep") String studyReplyStep1, HttpServletResponse response) throws Exception {
        int studyNum = Integer.parseInt(studyNum1);
        int studyReplyNum = Integer.parseInt(studyReplyNum1);
        int studyReplyStep = Integer.parseInt(studyReplyStep1);
        System.out.println(studyReplyNum);
        boardService.deleteStudyBoardReply(studyReplyNum);
        if(studyReplyStep==0){
            System.out.println("하위항목 삭제");
            boardService.deleteStudyBoardReReply(studyReplyNum);
        }
        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();
        out.println("<script>");
        out.println("location.href='/studyCont?studyNum=" + studyNum + "'");
        out.println("</script>");
    }
    @RequestMapping(method = RequestMethod.POST, value = "/studyReplyModify")
    @ResponseBody
    public void studyReplyModify(@RequestParam("studyReplyNum") int studyReplyNum, @RequestParam("studyReplyCont") String studyReplyCont) throws Exception {
        boardService.updateStudyBoardReply(studyReplyNum,studyReplyCont);
    }
    @RequestMapping("/studyReCmt")
    @ResponseBody
    public String studyReComment(StudyBoardReplyDto studyBoardReplyDto) throws Exception{
        System.out.println(studyBoardReplyDto.toString());
        boardService.insertStudyBoardReReply(studyBoardReplyDto);
        return "success";
    }
}

