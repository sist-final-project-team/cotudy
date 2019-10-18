package com.project.cotudy.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class StudyController {

    @RequestMapping("/")
    public String main() {
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

    @RequestMapping("/join")
    public String join() {
        return "/join";
    }

    @RequestMapping("/notice")
    public String notice() {
        return "/notice";
    }

    @RequestMapping("/freeCont")
    public String freeBoardCont() {
        return "/freeBoardCont";
    }

    @RequestMapping("/freeEdit")
    public String freeBoardEdit() {
        return "/freeBoardEdit";
    }

    @RequestMapping("/freeList")
    public String freeBoardList() {
        return "/freeBoardList";
    }

    @RequestMapping("/freeWrite")
    public String freeBoardWrite() {
        return "/freeBoardWrite";
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
