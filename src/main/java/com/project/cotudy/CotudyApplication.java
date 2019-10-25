package com.project.cotudy;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.web.servlet.MultipartAutoConfiguration;

						//첨부파일 관련 자동구성 미사용
@SpringBootApplication(exclude = {MultipartAutoConfiguration.class})
public class CotudyApplication {

    public static void main(String[] args) {

        SpringApplication.run(CotudyApplication.class, args);
    }

}
