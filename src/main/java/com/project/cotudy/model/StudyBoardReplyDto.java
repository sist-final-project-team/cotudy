package com.project.cotudy.model;

import lombok.Data;

@Data
public class StudyBoardReplyDto {
    private int studyNum;
    private int studyReplyNum;
    private String memId;
    private String studyReplyCont;
    private int studyReplyStep;
    private int studyReplyIndent;
    private String studyReplyCreatedTime;
}
