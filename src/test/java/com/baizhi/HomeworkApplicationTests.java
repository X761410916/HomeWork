package com.baizhi;

import com.baizhi.entity.User;
import com.baizhi.service.UserService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.test.context.junit4.SpringRunner;

import java.util.List;

//指定Spring入口类
@SpringBootTest(classes = HomeworkApplication.class)
//指定Spring运行类
@RunWith(SpringRunner.class)
public class HomeworkApplicationTests {

    @Autowired
    private StringRedisTemplate redisTemplate;


    @Autowired
    private UserService userService;

    public HomeworkApplicationTests() {
        System.setProperty("es.set.netty.runtime.available.processors", "false");
    }

    /*
     * 获取字符串的编码格式
     * */
    @Test
    public void getString() {
        User user = userService.queryUserById("9060fff8");
        String nick_name = user.getNick_name();
    }

    /*
     * Redis的测试
     * */
    @Test
    public void testRedis() {
        redisTemplate.opsForValue().set("test", "testvalue");
        System.out.println(redisTemplate.opsForValue().get("test"));
    }

    /*
     * MyCat测试
     * */
    @Test
    public void testMyCat() {
        List<User> users = userService.queryAll();
        for (User user : users) {
            System.out.println(user);
        }
    }

    /*   @Autowired
       private BookRepository bookRepository;*/
    /*
     * ES测试
     * */
    @Test
    public void testEs() {


    }
}
