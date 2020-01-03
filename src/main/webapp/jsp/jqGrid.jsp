<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page isELIgnored="false" contentType="text/html; UTF-8" pageEncoding="UTF-8" %>
<c:set var="app" value="${pageContext.request.contextPath}"/>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>首页</title>
    <%-- bootstarp核心 css --%>
    <link rel="stylesheet" href="${app}/boot/css/bootstrap.min.css">
    <%-- 引入jqGrid主题样式 --%>
    <link rel="stylesheet" href="${app}/jqGrid/css/css/cupertino/jquery-ui-1.8.16.custom.css">
    <%-- 引入jqGrid核心css --%>
    <link rel="stylesheet" href="${app}/jqGrid/css/ui.jqgrid.css">
    <%-- 引入jquery。js --%>
    <script src="${app}/boot/js/jquery-3.3.1.min.js"></script>
    <%-- 引入bootstarp核心js --%>
    <script src="${app}/boot/js/bootstrap.min.js"></script>
    <%-- 引入国际化js --%>
    <script src="${app}/jqGrid/js/i18n/grid.locale-cn.js"></script>
    <%-- 引入jqGrid核心js --%>
    <script src="${app}/jqGrid/js/jquery.jqGrid.src.js"></script>
    <style>

    </style>
    <script>
        $(function () {
            $("#list").jqGrid({
                url: "test.json",    //获取数据的请求路径
                editurl: "aaaa",     //增 oper=add  删 oper=del  改oper=edit    根据传递的oper进行判断
                datatype: "json",    //返回数据json形式
                /* cellEdit:true, */    //启用或者禁用单元格编辑功能   必须配合editable:true 使用
                autowidth: true,    //自适应父容器
                pager: "#pager",    //分页工具栏
                rowNum: 3,          //每页显示的条数
                rowList: [3, 10, 15], //自定义每页显示的条数
                sortname: "id",     //根据那个列排序
                viewrecords: true,  //是否显示总条数
                caption: "我的表格",//表格名称
                height: 500,        //高度  像素  百分比 数字
                multiselect: true, //是否多选
                /* hiddengrid:true, */ //是否隐藏表格
                toolbar: [true, 'top'], //工具栏  top上边显示   both上下显示  bottom下边显示
                colNames: ["编号", "姓名", "年龄", "生日", "操作"],  //表头
                colModel: [                               //表中数据
                    {name: "id", align: "center"},
                    {
                        name: "name", editable: true/*, edittype:"select", editoptions:{
                            value:"1:男;2:女"
                       }*/
                    },
                    {
                        name: "age", editable: true, align: "center"/*,formatter:function(cellvalue, options, rowObject){
                           /!*
                           * cellvalue: 单元格的值
                           * options: jqGrid({...}) ...的对象
                           * rowObject: 当前行对象
                           * *!/
                           if(cellvalue <= 20){
                               return "青年"
                           }else{
                               return "老年"
                           }
                       }*/
                    },
                    {name: "bir", resizable: false, editable: true},
                    {
                        name: "option", formatter: function (cellvalue, options, rowObject) {
                            return "<button class='btn btn-primary'>删除</button>";
                        }
                    }

                ]
                /*
                * navGrid : 规定写死
                * #pager  : 分页工具栏的id
                * {}:
                * */
            }).jqGrid("navGrid", "#pager", {
                /* edit:false,
                 add:false*/
            })
        });
    </script>
</head>
<body>

<table id="list"></table>
<div id="pager"></div>
</body>
</html>