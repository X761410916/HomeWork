package com.baizhi.vo;

import java.io.Serializable;
import java.util.Map;

/**
 * @author 徐三
 * @company com.1999
 * @create 2019-12-01 16:49
 * jqGrid 模糊查询工具类
 */

public class Fuzzy implements Serializable {
    /*
     * 当前页
     * 当前页数
     * 起始页
     * 查询条件
     * 查询符号
     * 查询数据
     * 返回数据map
     * */
    private Integer page;
    private Integer rows;
    private Integer start;
    private Integer total;

    public Integer getTotal() {
        return total;
    }

    public void setTotal(Integer count) {
        this.total = count % rows == 0 ? count / rows : count / rows + 1;
    }

    private String searchField;
    /*不确认接收数据是什么类型*/
    private Object searchString;
    private String searchOper;
    private Map<String, Object> map;

    public Fuzzy() {
    }

    public Integer getStart() {
        return start;
    }

    public void setStart(Integer start) {
        this.start = (start - 1) * rows;
    }

    public Integer getPage() {
        return page;
    }

    public void setPage(Integer page) {
        this.page = page;
    }

    public Integer getRows() {
        return rows;
    }

    public void setRows(Integer rows) {
        this.rows = rows;
    }

    public String getSearchField() {
        return searchField;
    }

    public void setSearchField(String searchField) {
        this.searchField = searchField;
    }

    public Object getSearchString() {
        return searchString;
    }

    public void setSearchString(Object searchString) {
        this.searchString = searchString;
    }

    public String getSearchOper() {
        return searchOper;
    }

    @Override
    public String toString() {
        return "Fuzzy{" +
                "page=" + page +
                ", rows=" + rows +
                ", start=" + start +
                ", total=" + total +
                ", searchField='" + searchField + '\'' +
                ", searchString=" + searchString +
                ", searchOper='" + searchOper + '\'' +
                ", map=" + map +
                '}';
    }

    public void setSearchOper(String searchOper) {
        //当查询条件为数字时
        if ("eq".equals(searchOper)) this.searchOper = "=";
        if ("ne".equals(searchOper)) this.searchOper = "!=";
        if ("bw".equals(searchOper)) this.searchOper = ">=";
        if ("bn".equals(searchOper)) this.searchOper = ">";
        if ("ew".equals(searchOper)) this.searchOper = "<=";
        if ("en".equals(searchOper)) this.searchOper = "<";
        if ("cn".equals(searchOper)) this.searchOper = ">=";
        if ("nc".equals(searchOper)) this.searchOper = ">";
        if ("nu".equals(searchOper)) {
            this.searchOper = "=";
            this.searchString = null;
        }
        if ("nn".equals(searchOper)) {
            this.searchOper = "!=";
            this.searchString = null;
        }
        if ("in".equals(searchOper)) this.searchOper = ">=";
        if ("ni".equals(searchOper)) this.searchOper = ">";
    }

    public Map<String, Object> getMap() {
        return map;
    }

    public void setMap(Map<String, Object> map) {
        this.map = map;
    }
}
