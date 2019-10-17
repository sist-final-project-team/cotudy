package com.project.cotudy.model;

import lombok.Data;

@Data
public class StudyBoardReplyDto {
    private int studyNum;
    private String memId;
    private String studyReplyCont;
    private int studyReplyStep;
    private int studyReplyIndent;
}
