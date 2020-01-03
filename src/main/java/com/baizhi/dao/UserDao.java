package com.baizhi.dao;


import com.baizhi.entity.User;
import com.baizhi.vo.Fuzzy;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @author 徐三
 * @company com.1999
 * @create 2019-11-28 9:43
 */

public interface UserDao {
    /*查询所有*/
    public List<User> queryAll();

    /*分页查询*/
    public List<User> queryByPage(Fuzzy fuzzy);

    /*总条数*/
    public Integer queryUserCount();

    /*模糊查询*/
    public List<User> fuzzyQuery(User user);

    /*id查询*/
    public User queryUserById(@Param("UserId") String UserId);

    /*添加*/
    public void insertUser(User user);

    /*删除*/
    public void deleteUserById(String UserId);

    /*修改*/
    public void updateUser(User user);

}
