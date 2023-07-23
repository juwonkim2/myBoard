package com.myportfolio.web.domain;

import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;


@Data
@NoArgsConstructor
public class UserDto {
    private String id;
    private String pwd;
    private String name;
    private String email;
    private Date birth;
    private Date reg_date;


} // end class