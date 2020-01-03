package com.baizhi.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.Id;
import org.springframework.data.elasticsearch.annotations.Document;
import org.springframework.data.elasticsearch.annotations.Field;
import org.springframework.data.elasticsearch.annotations.FieldType;
import org.springframework.format.annotation.DateTimeFormat;

import java.io.Serializable;
import java.util.Date;

/**
 * @author 徐三
 * @company com.1999
 * @create 2019-11-28 9:45
 */

@Data
@NoArgsConstructor
@AllArgsConstructor
@Document(indexName = "homework", type = "user")
public class User implements Serializable {
    @Id
    private String id;
    @Field(type = FieldType.Text, analyzer = "ik_max_word", searchAnalyzer = "ik_max_word")
    private String nick_name;
    @Field(type = FieldType.Text, analyzer = "ik_max_word", searchAnalyzer = "ik_max_word")
    private String email;
    private String password;
    @Field(type = FieldType.Integer)
    private Integer status;
    @JsonFormat(pattern = "yyyy-MM-dd") //反序列化
    @DateTimeFormat(pattern = "yyyy-MM-dd") //序列化
    @Field(type = FieldType.Date)
    private Date regist_time;
    @JsonFormat(pattern = "yyyy-MM-dd")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @Field(type = FieldType.Date)
    private Date birthday;

    //手机号分词
    @Field(type = FieldType.Text, analyzer = "ik_max_word", searchAnalyzer = "ik_max_word")
    private String phone;
    private String salt;

}
