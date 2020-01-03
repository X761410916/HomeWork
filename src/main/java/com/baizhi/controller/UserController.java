package com.baizhi.controller;

import com.baizhi.entity.User;
import com.baizhi.service.UserService;
import com.baizhi.vo.Fuzzy;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.UUID;

/**
 * @author 徐三
 * @company com.1999
 * @create 2019-11-27 22:54
 */

@RestController
@RequestMapping("/user")

public class UserController {
    @Autowired
    private UserService us;

    /*模糊查询*/
    @ResponseBody
    @RequestMapping("/fuzzyQuery")
    public List<User> fuzzyQuery(String keyword, Model model) {
        if ("".equals(keyword)) {
            return null;
        }
        return us.keyWordQuery(keyword, 0);
    }

    /*查询所有*/
    @ResponseBody
    @RequestMapping("/queryAll")
    public List<User> queryAll(Model model) {
        List<User> users = us.queryAll();
        model.addAttribute("users", users);
        return users;
    }

    /*分页查询*/
    @ResponseBody
    @RequestMapping("pageQuery")
    public Map<String, Object> pageQuery(Fuzzy fuzzy) {
        return us.queryPager(fuzzy).getMap();
    }

    /*曾删改*/
    @RequestMapping("edit")
    public void edit(String oper, User user, String id) {
        //增加
        if ("add".equals(oper)) {
            user.setId(UUID.randomUUID().toString().substring(0, 8));
            user.setRegist_time(new Date());
            us.insertUser(user);
        }
        //删除
        if ("del".equals(oper)) {
            us.deleteUserById(id);
        }
        //修改
        if ("edit".equals(oper)) {
            us.updateUser(user);
        }
    }

    /*id查询*/
    @ResponseBody
    @RequestMapping("queryByUserId")
    public User queryByUserId(String id) {
        return us.queryUserById(id);
    }

    /*    *//*添加*//*
    @ResponseBody
    @RequestMapping("/insertUser")
    public String insertUser(User user){
        user.setRegist_time(new Date());
        us.insertUser(user);
        return null;
    }

    *//*删除*//*
    @ResponseBody
    @RequestMapping("/deleteUser")
    public String deleteUser(Integer id){
        us.deleteUserById(id);
        return null;
    }

    *//*修改*//*
    @ResponseBody
    @RequestMapping("/updateUser")
    public String updateUser(User user, HttpServletRequest request){
        us.updateUser(user);
        return null;
    }*/
}
