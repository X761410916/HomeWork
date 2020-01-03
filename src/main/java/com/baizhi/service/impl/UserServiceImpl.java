package com.baizhi.service.impl;

import com.baizhi.dao.UserDao;
import com.baizhi.entity.User;
import com.baizhi.repository.UserRepository;
import com.baizhi.service.UserService;
import com.baizhi.vo.Fuzzy;
import org.elasticsearch.action.search.SearchResponse;
import org.elasticsearch.index.query.QueryBuilders;
import org.elasticsearch.search.SearchHit;
import org.elasticsearch.search.fetch.subphase.highlight.HighlightBuilder;
import org.elasticsearch.search.fetch.subphase.highlight.HighlightField;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.elasticsearch.core.ElasticsearchTemplate;
import org.springframework.data.elasticsearch.core.SearchResultMapper;
import org.springframework.data.elasticsearch.core.aggregation.AggregatedPage;
import org.springframework.data.elasticsearch.core.aggregation.impl.AggregatedPageImpl;
import org.springframework.data.elasticsearch.core.query.NativeSearchQuery;
import org.springframework.data.elasticsearch.core.query.NativeSearchQueryBuilder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * @author 徐三
 * @company com.1999
 * @create 2019-11-28 10:17
 */
@Service
@Transactional(propagation = Propagation.SUPPORTS)
public class UserServiceImpl implements UserService {
    @Autowired
    private UserDao ud;

    //Redis
    @Autowired
    private UserRepository userRepository;

    //es
    @Autowired
    private ElasticsearchTemplate elasticsearchTemplate;

    @Override
    public List<User> keyWordQuery(String keyword, Integer page) {
        /*
         * 高亮相关
         * */
        HighlightBuilder.Field field = new HighlightBuilder
                .Field("*")   //字段
                .preTags("<span style='color:red'>") //前缀
                .postTags("</span>")            //后缀
                .requireFieldMatch(false);      //关闭字段匹配
        int status = 1;
        if ("冻结" == keyword) {
            status = 2;
        }
        //开始查询数据
        NativeSearchQuery build = new NativeSearchQueryBuilder()
                //对激活进行判断

                //关键词查询
                .withQuery(QueryBuilders.boolQuery()
                        //模糊查询
                        .should(QueryBuilders.termQuery("nick_name", keyword))
                        .should(QueryBuilders.termQuery("email", keyword))
                        //.should(QueryBuilders.boolQuery().must(QueryBuilders.termQuery("status", status)))
                        /* .should(QueryBuilders.termQuery("regist_time", new Date(Long.valueOf(keyword))))
                         .should(QueryBuilders.termQuery("birthday", new Date(Long.valueOf(keyword))))*/
                        .should(QueryBuilders.termQuery("phone", keyword)))
                //指定字段
                .withFields("id", "nick_name", "email", "status", "regist_time", "birthday", "phone")
                //排序
                .withPageable(PageRequest.of(page, 5))
                //高亮
                .withHighlightFields(field)
                .build();

        //进行数据处理
        AggregatedPage<User> users = elasticsearchTemplate.queryForPage(build, User.class, new SearchResultMapper() {
            @Override
            public <T> AggregatedPage<T> mapResults(SearchResponse response, Class<T> clazz, Pageable pageable) {
                //准备集合存储修改数据
                ArrayList<User> list = new ArrayList<>();
                //判断是否有数据 否则直接返回 避免空指针
                //获取查询数据
                SearchHit[] hits = response.getHits().getHits();
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

                //判断是否有高亮数据
                for (SearchHit hit : hits) {
                    //判断是否有正确数据
                    User user = new User();
                    //进行源数据判断

                    //判断元数据
                    Map<String, Object> sourceAsMap = hit.getSourceAsMap();
                    //高亮字段修改
                    Map<String, HighlightField> highlightFields = hit.getHighlightFields();
                    if (sourceAsMap.get("nick_name") != null) {
                        if (highlightFields.get("nick_name") != null) {
                            user.setNick_name(highlightFields.get("nick_name").getFragments()[0].toString());
                        } else {
                            user.setNick_name(sourceAsMap.get("nick_name").toString());
                        }
                    }
                    if (sourceAsMap.get("email") != null) {
                        if (highlightFields.get("email") != null) {
                            user.setEmail(highlightFields.get("email").getFragments()[0].toString());
                        } else {
                            user.setEmail(sourceAsMap.get("email").toString());
                        }
                    }
                    if (sourceAsMap.get("status") != null) {
                        user.setStatus(Integer.valueOf(sourceAsMap.get("status").toString()));
                    }
                    if (sourceAsMap.get("regist_time") != null) {
                        Date regist_time = null;
                        try {
                            regist_time = sdf.parse(sourceAsMap.get("regist_time").toString());
                        } catch (ParseException e) {
                            e.printStackTrace();
                        }
                        user.setRegist_time(regist_time);
                    }
                    if (sourceAsMap.get("birthday") != null) {
                        Date birthday = null;
                        try {
                            birthday = sdf.parse(sourceAsMap.get("birthday").toString());
                        } catch (ParseException e) {
                            e.printStackTrace();
                        }
                        user.setBirthday(birthday);
                    }
                    if (sourceAsMap.get("phone") != null) {
                        if (highlightFields.get("phone") != null) {
                            user.setPhone(highlightFields.get("phone").getFragments()[0].toString());
                        } else {
                            user.setPhone(sourceAsMap.get("phone").toString());
                        }
                    }
                    //添加到集合
                    list.add(user);
                }
                return new AggregatedPageImpl<>((List<T>) list);
            }
        });
        //将数据转化
        List<User> content = users.getContent();
        return content;
    }

    //判断是否是个数字
   /* public static boolean isInteger(String str) {
        Pattern pattern = Pattern.compile("^[-\\+]?[\\d]*$");
        return pattern.matcher(str).matches();
    }*/

    @Override
    @Transactional(propagation = Propagation.SUPPORTS)
    public List<User> fuzzyQuery(User user) {
        return ud.fuzzyQuery(user);
    }

    @Override
    @Transactional(propagation = Propagation.SUPPORTS)
    public Fuzzy queryPager(Fuzzy fuzzy) {
        /*
         * jqGrid： 要求返回数据为
         * page:当前页
         * rows:数据
         * total:总页数
         * records:总条数
         * */
        //总条数
        //第一次访问数据库
        System.out.println("第一次要去访问数据库");
        Integer count = ud.queryUserCount();
        fuzzy.setTotal(count);
        fuzzy.setStart(fuzzy.getPage());
        HashMap<String, Object> map = new HashMap<>();
        List<User> users = ud.queryByPage(fuzzy);
        map.put("page", fuzzy.getPage());
        map.put("rows", users);
        map.put("total", fuzzy.getTotal());
        map.put("records", count);
        fuzzy.setMap(map);
        //添加索引
        for (User user : users) {
            //避免id为空 缓存报错
            if (StringUtils.isEmpty(user.getId())) {
                continue;
            }
            userRepository.save(user);
        }
        return fuzzy;
    }

    @Override
    @Transactional(propagation = Propagation.SUPPORTS)
    public List<User> queryAll() {
        return ud.queryAll();
    }

    @Override
    @Transactional(propagation = Propagation.SUPPORTS)
    public User queryUserById(String userId) {
        return ud.queryUserById(userId);
    }

    @Override
    @Transactional
    public void insertUser(User user) {
        //数据库添加
        System.out.println(user);
        ud.insertUser(user);
        //添加成功添加索引
        userRepository.save(user);
    }

    @Override
    @Transactional
    public void deleteUserById(String userId) {
        ud.deleteUserById(userId);
        //通过键删除索引
        userRepository.deleteById(userId);
    }

    @Override
    @Transactional
    public void updateUser(User user) {
        ud.updateUser(user);
        //更新索引
        userRepository.save(user);
    }
}
