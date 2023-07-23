package com.myportfolio.web.dao;

import com.myportfolio.web.domain.UserDto;

public interface UserDao {
    int delete(String id, String pwd) throws Exception;

    int insert(UserDto dto) throws Exception;

    UserDto select(String id) throws Exception;

    int update(UserDto dto) throws Exception;

    int count() throws Exception;

    int deleteAll() throws Exception;
}
