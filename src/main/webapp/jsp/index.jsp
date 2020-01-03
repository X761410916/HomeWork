<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/11/29
  Time: 18:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">

    <link rel="stylesheet" href="${path}/boot/css/bootstrap.min.css">
    <script src="${path}/boot/js/jquery-3.3.1.min.js"></script>
    <script src="${path}/boot/js/bootstrap.min.js"></script>

    <link rel="stylesheet" href="${path}/jqGrid/css/trirand/ui.jqgrid-bootstrap.css">
    <script src="${path}/jqGrid/js/i18n/grid.locale-cn.js"></script>
    <script src="${path}/jqGrid/js/trirand/jquery.jqGrid.min.js"></script>


    <title>当当后台管理系统</title>


    <style type="text/css">
        a:hover, a:link, a:visited, a:active {
            text-decoration: none;
        }
    </style>
</head>
<body>
<nav class="navbar navbar-inverse">
    <div class="container-fluid">
        <div class="navbar-header">
            <a href="javascript:void(0)" class="navbar-brand">
                当当网后台管理系统
            </a>
            <button class="navbar-toggle collapsed" data-toggle="collapse">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
        </div>
        <div class="collapse navbar-collapse">
            <ul class="nav navbar-nav navbar-right">
                <li><a href="">欢迎：<strong>XXX${sessionScope.user.name}</strong></a></li>
                <li><a href="">
                    <span class="glyphicon glyphicon-off  glyphicon-hand-right"></span>
                    退出登录
                </a></li>
            </ul>
        </div>
    </div>
</nav>
<%--
    页面主体
--%>
<div class="container-fluid">
    <div class="row">
        <%--
            导航菜单
        --%>
        <div class="col-sm-2">
            <div class="panel panel-group " id="accordion">
                <%--
                    类别管理开始
                --%>
                <div class="panel panel-default text-center">
                    <div class="panel-heading" id="headingOne">
                        <h6 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseOne">
                                <h4>类别管理</h4>
                            </a>
                        </h6>
                    </div>
                    <div id="collapseOne" class="panel-collapse collapse">
                        <div class="panel-body">
                            <%--
                                javascript:void(0)  阻止页面提交
                            --%>
                            <a href="javascript:void(0)" onclick="$('#myContent').load('')" class="btn btn-primary">
                                类别添加
                            </a>

                            <a href="javascript:void(0)" onclick="$('#myContent').load('')" class="btn btn-success"
                               style="margin-top: 5px">
                                类别修改
                            </a>

                            <a href="javascript:void(0)" onclick="$('#myContent').load('')" class="btn btn-danger"
                               style="margin-top: 5px">
                                类别删除
                            </a>
                        </div>
                    </div>
                </div>
                <%--
                    类别管理结束
                --%>

                <%--
                    图书管理开始
                --%>
                <div class="panel panel-default text-center">
                    <div class="panel-heading" id="headingOne1">
                        <h6 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseOne1">
                                <h4>图书管理</h4>
                            </a>
                        </h6>
                    </div>
                    <div id="collapseOne1" class="panel-collapse collapse">
                        <div class="panel-body">
                            <%--
                                javascript:void(0)  阻止页面提交
                            --%>
                            <a href="javascript:void(0)" onclick="$('#myContent').load('')" class="btn btn-primary">
                                图书添加
                            </a>

                            <a href="javascript:void(0)" onclick="$('#myContent').load('')" class="btn btn-success"
                               style="margin-top: 5px">
                                图书修改
                            </a>

                            <a href="javascript:void(0)" onclick="$('#myContent').load('')" class="btn btn-danger"
                               style="margin-top: 5px">
                                图书删除
                            </a>
                        </div>
                    </div>
                </div>
                <%--
                    图书管理结束
                --%>

                <%--
                    订单管理开始
                --%>
                <div class="panel panel-default text-center">
                    <div class="panel-heading" id="headingOne2">
                        <h6 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseOne2">
                                <h4>订单管理</h4>
                            </a>
                        </h6>
                    </div>
                    <div id="collapseOne2" class="panel-collapse collapse">
                        <div class="panel-body">
                            <%--
                                javascript:void(0)  阻止页面提交
                            --%>
                            <a href="javascript:void(0)" onclick="$('#myContent').load('')" class="btn btn-primary">
                                订单添加
                            </a>
                            <a href="javascript:void(0)" onclick="$('#myContent').load('')" class="btn btn-success"
                               style="margin-top: 5px">
                                订单修改
                            </a>
                            <a href="javascript:void(0)" onclick="$('#myContent').load('')" class="btn btn-danger"
                               style="margin-top: 5px">
                                订单删除
                            </a>
                        </div>
                    </div>
                </div>
                <%--
                    订单管理结束
                --%>

                <%--
                    用户管理开始
                --%>
                <div class="panel panel-default text-center">
                    <div class="panel-heading" id="headingOne3">
                        <h6 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseOne3">
                                <h4> 用户管理</h4>
                            </a>
                        </h6>
                    </div>
                    <div id="collapseOne3" class="panel-collapse collapse">
                        <div class="panel-body">
                            <%--
                                javascript:void(0)  阻止页面提交
                            --%>
                            <a href="javascript:void(0)" onclick="$('#myContent').load('user.jsp')"
                               class="btn btn-primary">
                                用户列表
                            </a>
                            <a href="javascript:void(0)" onclick="$('#myContent').load('')" class="btn btn-success"
                               style="margin-top: 5px">
                                用户展示
                            </a>
                            <a href="javascript:void(0)" onclick="$('#myContent').load('')" class="btn btn-danger"
                               style="margin-top: 5px">
                                用户删除
                            </a>
                        </div>
                    </div>
                </div>
                <%--
                    用户管理结束
                --%>
            </div>
        </div>
        <%--
            导航菜单结束
        --%>

        <%--
            内容展示开始
        --%>
        <div class="col-sm-10" id="myContent">
            <%--
                巨幕开始
            --%>
            <div class="jumbotron">
                <h2>欢迎登陆当当网后台管理系统</h2>
                <p>...</p>
                <p><a href="" class="btn btn-info">Learn more</a></p>
            </div>
            <%--
                巨幕结束
            --%>

            <%--
                警告框开始
            --%>
            <div class="alert alert-danger alert-dismissible fade in">
                <div>
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                        <span>&times;</span>
                    </button>
                </div>
                <div style="margin-top: -2%">
                    <h3>致橡树</h3>
                    <p>We're all little monsters <br>
                        If a righteous ultraman comes to hurt you <br>
                        I'll help you kill ultraman</p>
                </div>
                <div>
                    <button type="button" class="btn btn-danger">Take this action</button>
                    <button type="button" class="btn btn-default">Or do this</button>
                </div>
            </div>
            <%--
                警告框结束
            --%>

            <%--
                进度条开始
            --%>
            <div class="panel panel-default">
                <table class="table">
                    <tr>
                        <td class="active">
                            <strong>系统状态</strong>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <h5 class="h5">内存使用率</h5>
                            <div class="progress">
                                <div class="progress-bar progress-bar-success progress-bar-striped active"
                                     role="progressbar"
                                     aria-valuenow="40" aria-valuemin="0" aria-valuemax="100" style="width: 40%">
                                    <span class="sr-only">40% Complete (success)</span>
                                </div>
                            </div>
                            <h5 class="h5">数据库使用率</h5>
                            <div class="progress">
                                <div class="progress-bar progress-bar-info progress-bar-striped active"
                                     role="progressbar"
                                     aria-valuenow="20" aria-valuemin="0" aria-valuemax="100" style="width: 20%">
                                    <span class="sr-only">20% Complete</span>
                                </div>
                            </div>
                            <h5 class="h5">磁盘使用率</h5>
                            <div class="progress">
                                <div class="progress-bar progress-bar-warning progress-bar-striped active"
                                     role="progressbar"
                                     aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 60%">
                                    <span class="sr-only">60% Complete (warning)</span>
                                </div>
                            </div>
                            <h5 class="h5">CPU使用率</h5>
                            <div class="progress">
                                <div class="progress-bar progress-bar-danger progress-bar-striped active"
                                     role="progressbar"
                                     aria-valuenow="80" aria-valuemin="0" aria-valuemax="100" style="width: 80%">
                                    <span class="sr-only">80% Complete (danger)</span>
                                </div>
                            </div>
                        </td>
                    </tr>
                </table>
            </div>
            <%--
                进度条结束
            --%>

        </div>
        <%--
            内容展示结束
        --%>
    </div>
</div>

<%--
    页面主体结束
--%>
</body>
</html>
