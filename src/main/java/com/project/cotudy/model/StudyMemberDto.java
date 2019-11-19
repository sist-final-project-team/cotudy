package com.project.cotudy.model;
import lombok.Data;

@Data
public class StudyMemberDto {
    private String memId;
    private String memPwd;
    private String memName;
    private String memEmail;
    private String memArea;
    private String memStatus;
    private String memSalt;

}
