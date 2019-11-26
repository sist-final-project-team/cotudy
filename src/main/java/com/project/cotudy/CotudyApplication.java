package com.project.cotudy;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.web.servlet.MultipartAutoConfiguration;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;

//첨부파일 관련 자동구성 미사용
@SpringBootApplication(exclude = {MultipartAutoConfiguration.class})
// Spring Boot 내장 Tomcat이 아닌 외부 Tomcat을 사용하도록 설정
public class CotudyApplication extends SpringBootServletInitializer {

    public static void main(String[] args) {
        SpringApplication.run(CotudyApplication.class, args);
    }

    @Override
    protected SpringApplicationBuilder configure(SpringApplicationBuilder builder) {
        return builder.sources(CotudyApplication.class);
    }
}
