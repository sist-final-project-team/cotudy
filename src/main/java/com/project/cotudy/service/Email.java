package com.project.cotudy.service;

import lombok.Data;
import org.springframework.stereotype.Component;

@Component
@Data
public class Email {
    private String subject;
    private String content;
    private String receiver;

}
