package com.project.cotudy.model;
import lombok.Data;

@Data
public class FreeBoardReplyDto {
    private int freeNum;
    private String replyCont;
    private String memId;
    private int replyStep;
    private int replyIndent;
}
