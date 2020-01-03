package com.baizhi.service;

import com.baizhi.entity.User;
import com.baizhi.vo.Fuzzy;

import java.util.List;

/**
 * @author 徐三
 * @company com.1999
 * @create 2019-11-28 10:14
 */
public interface UserService {

    /*ES查询*/
    public List<User> keyWordQuery(String keyword, Integer page);

    /*模糊查询*/
    public List<User> fuzzyQuery(User user);

    /*分页查询*/
    public Fuzzy queryPager(Fuzzy fuzzy);

    /*查询所有*/
    public List<User> queryAll();

    /*id查询*/
    public User queryUserById(String UserId);

    /*添加*/
    public void insertUser(User user);

    /*删除*/
    public void deleteUserById(String UserId);

    /*修改*/
    public void updateUser(User user);
}
