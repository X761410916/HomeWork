package com.baizhi.repository;

import com.baizhi.entity.User;
import org.springframework.data.elasticsearch.repository.ElasticsearchRepository;

/**
 * @author 徐三
 * @company com.1999
 * @create 2019-12-17 15:08
 */
public interface UserRepository extends ElasticsearchRepository<User, String> {

}
