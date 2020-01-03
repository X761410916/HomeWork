package com.baizhi.cache;

import com.baizhi.config.GetBeanUtil;
import com.baizhi.util.SerializeUtils;
import org.apache.ibatis.cache.Cache;
import org.springframework.data.redis.core.HashOperations;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.util.ObjectUtils;
import org.springframework.util.StringUtils;

import java.util.concurrent.TimeUnit;
import java.util.concurrent.locks.ReadWriteLock;

/**
 * @author 徐三
 * @company com.1999
 * @create 2019-12-17 14:39
 */
public class RedisCache implements Cache {
    private String id;

    //必须提供的有参构造
    public RedisCache(String id) {
        this.id = id;
    }

    @Override
    public String getId() {
        return id;
    }

    /**
     * 添加缓存方法
     *
     * @param key   ：键
     * @param value ：查出的数据
     */
    @Override
    public void putObject(Object key, Object value) {
        System.out.println("我开始添加缓存了！！");

        //获取Redis操作对象
        StringRedisTemplate redisTemplate = (StringRedisTemplate) GetBeanUtil.getBean(StringRedisTemplate.class);
        //如果用户查询出数据即将他进行缓存
        HashOperations<String, Object, Object> stringObjectObjectHashOperations = redisTemplate.opsForHash();
        if (!ObjectUtils.isEmpty(value)) {
            String serialize = SerializeUtils.serialize(value);
            stringObjectObjectHashOperations.put(id.toString(), key.toString(), serialize);
        } else {
            //给空查询设置过期时间
            redisTemplate.opsForValue().set(id, null, 30, TimeUnit.SECONDS);
        }
        System.out.println("缓存存储成功！！！！");
    }

    /**
     * 获取缓存
     *
     * @param key 方法
     * @return 返回数据
     */
    @Override
    public Object getObject(Object key) {
        System.out.println("获取缓存开始 ！！！！");
        StringRedisTemplate stringRedisTemplate = (org.springframework.data.redis.core.StringRedisTemplate) GetBeanUtil.getBean(StringRedisTemplate.class);
        HashOperations<String, Object, Object> stringObjectObjectHashOperations = stringRedisTemplate.opsForHash();

        //通过键在数据库查询值
        String value = (String) stringObjectObjectHashOperations.get(id.toString(), key.toString());
        //判断是否有值
        if (!StringUtils.isEmpty(value)) {
            Object cache = SerializeUtils.serializeToObject(value);
            return cache;
        }
        System.out.println("获取缓存结束 ！！！！");
        return null;
    }

    @Override
    public Object removeObject(Object key) {
        return null;
    }

    /**
     * 当对数据库进行写操作时 清除缓存
     */
    @Override
    public void clear() {
        System.out.println("我操作数据库了");
        StringRedisTemplate stringRedisTemplate = (StringRedisTemplate) GetBeanUtil.getBean(StringRedisTemplate.class);
        stringRedisTemplate.delete(id);
    }

    @Override
    public int getSize() {
        return 0;
    }

    @Override
    public ReadWriteLock getReadWriteLock() {
        return null;
    }
}
