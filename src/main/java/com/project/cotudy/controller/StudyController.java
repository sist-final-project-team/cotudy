package com.project.cotudy.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.project.cotudy.model.FreeBoardDto;
import com.project.cotudy.model.FreeBoardReplyDto;
import com.project.cotudy.model.StudyMemberDto;
import com.project.cotudy.service.BoardService;
import com.project.cotudy.service.Email;
import com.project.cotudy.service.EmailSender;
import com.project.cotudy.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.io.PrintWriter;
import java.util.List;

@Controller
public class StudyController {

    @Autowired
    private BoardService boardService;
    @Autowired
    private MemberService memberService;
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

    @RequestMapping("/notice")
    public String notice() {
        return "/notice";
    }

    /* 자유 게시판 관련 */
    @RequestMapping("/freeList")
    public ModelAndView freeBoardList() throws Exception {
        ModelAndView mv = new ModelAndView("/freeboard/freeBoardList");
        List<FreeBoardDto> list = boardService.selectFreeBoardList();
        mv.addObject("List",list);
        return mv;
    }
    @RequestMapping("/freeCont")
    public ModelAndView freeBoardCont(@RequestParam("no") int freeNum) throws Exception {
        boardService.updateFreeBoardHitCount(freeNum);
        ModelAndView mv = new ModelAndView("/freeboard/freeBoardCont");
        FreeBoardDto dto = boardService.selectFreeBoardCont(freeNum);
        List<FreeBoardReplyDto> replyDto = boardService.selectFreeBoardReplyList(freeNum);
        mv.addObject("freeBoardCont",dto);
        mv.addObject("replyDto",replyDto);
        return mv;
    }
    @RequestMapping("/freeEdit")
    public ModelAndView freeBoardEdit(@RequestParam("no") int freeNum) throws Exception {
        ModelAndView mv = new ModelAndView("/freeboard/freeBoardEdit");
        FreeBoardDto dto = boardService.selectFreeBoardCont(freeNum);
        mv.addObject("freeBoardCont",dto);
        return mv;
    }
    @RequestMapping("/freeEditOk")
    public String  freeBoardEditOk(FreeBoardDto freeDto,HttpServletResponse response) throws Exception {
        boardService.updateFreeBoard(freeDto);
        return "redirect:/freeCont?no="+freeDto.getFreeNum();
    }
    @RequestMapping("/freeWrite")
    public String freeBoardWrite() {
        return "/freeboard/freeBoardWrite";
    }
    @RequestMapping(method = RequestMethod.POST, value = "/freeWriteOk")
    public String writeOk(FreeBoardDto dto) throws Exception {
        boardService.writeFreeBoard(dto);
        return "redirect:/freeList";
    }
    @RequestMapping("/freeDelete")
    public void deleteOk(@RequestParam("no") int freeNum,HttpServletResponse response) throws Exception {
        boardService.deleteFreeBoard(freeNum);
        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();
        out.println("<script>");
        out.println("alert('삭제가 완료되었습니다.')");
        out.println("location.href='/freeList'");
        out.println("</script>");
    }
    /* 자유게시판 댓글 관련*/
    @RequestMapping("/freeReplyWrite")
    public void freeReplyWrite(FreeBoardReplyDto dto,HttpServletResponse response) throws Exception {
        boardService.updateFreeBoardReply(dto);
        boardService.writeFreeBoardReply(dto);
        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();
        out.println("<script>");
        out.println("alert('댓글이 등록되었습니다.')");
        out.println("location.href='/freeCont?no="+dto.getFreeNum()+"'");
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
}
