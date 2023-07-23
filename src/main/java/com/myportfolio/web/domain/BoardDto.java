package com.myportfolio.web.domain;

import lombok.Data;

import java.util.Date;

@Data
public class BoardDto {
    private Integer bno;
    private String title;
    private String content;
    private String writer;
    private int view_cnt;
    private int comment_cnt;
    private Date reg_date;

    public BoardDto() { this("","",""); }
    public BoardDto(String title, String content, String writer){
        this.title = title;
        this.content = content;
        this.writer = writer;
    }

} // end class
