package com.baizhi.config;

/**
 * @author 徐三
 * @company com.1999
 * @create 2019-12-17 14:19
 */

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.filter.CharacterEncodingFilter;

/**
 * 中文乱码解决
 */
@Configuration
public class CharcaterEncodingConf {
    @Bean
    public CharacterEncodingFilter getCharacterEncodingFilter() {
        CharacterEncodingFilter characterEncodingFilter = new CharacterEncodingFilter();
        /*设置SpringBoot编码过滤器*/
        characterEncodingFilter.setEncoding("UTF-8");
        /*强制执行编码*/
        characterEncodingFilter.setForceEncoding(true);
        /*请求执行强制编码*/
        characterEncodingFilter.setForceRequestEncoding(true);
        /*响应执行强制编码*/
        characterEncodingFilter.setForceResponseEncoding(true);
        System.out.println(characterEncodingFilter + "我是编码过滤配置文件 ");
        return characterEncodingFilter;
    }
}