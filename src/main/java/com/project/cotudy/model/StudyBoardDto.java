package com.project.cotudy.model;
import lombok.Data;

import java.time.LocalDateTime;

@Data
public class StudyBoardDto {
    private String memId;
    private String studyTitle;
    private String studyCont;
    private String studyStartDate;
    private int studyNum;
    private String studyEndDate;
    private String studyArea;
    private String studyKeyword;
    private String studyStatus;
    private String studyOpenchat;
    private String studyCreated;

}
