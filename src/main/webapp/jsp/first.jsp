<%@page isELIgnored="false" contentType="text/html; UTF-8" pageEncoding="UTF-8" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <%--
        引入bootstrap。css
    --%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/boot/css/bootstrap.min.css">
    <%--
        jquery.js
        bootstrap.js
    --%>
    <script src="${pageContext.request.contextPath}/boot/js/jquery-3.3.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/boot/js/bootstrap.min.js"></script>
    <title>首页</title>
</head>
<body>
<%--
    导航条
--%>
<nav class="navbar navbar-inverse">
    <div class="container-fluid">
        <div class="navbar-header">
            <a href="" class="navbar-brand">
                后台管理系统
            </a>
            <button class="navbar-toggle collapsed" data-toggle="collapse">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
        </div>
        <div class="collapse navbar-collapse">
            <ul class="nav navbar-nav navbar-right">
                <li><a href="">欢迎：<strong>小黑</strong></a></li>
                <li><a href="">
                    <span class="glyphicon glyphicon-hand-right"></span>
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
            <div class="panel-group" id="accordion">
                <%--
                    用户列表
                --%>
                <div class="panel panel-default text-center">
                    <div class="panel-heading" id="headingOne">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseOne">
                                <h3>用户管理</h3>
                            </a>
                        </h4>
                    </div>
                    <div id="collapseOne" class="panel-collapse collapse">
                        <div class="panel-body">
                            <%--
                                javascript:void(0)  阻止页面提交
                            --%>
                            <a href="javascript:void(0)" onclick="$('#myContent').load('second.jsp')"
                               class="btn btn-primary">
                                用户列表
                            </a>
                        </div>
                    </div>
                </div>

                <%--
                    类别管理
                --%>
                <div class="panel panel-default text-center">
                    <div class="panel-heading" id="headingOne1">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseOne1">
                                <h3>类别管理</h3>
                            </a>
                        </h4>
                    </div>
                    <div id="collapseOne1" class="panel-collapse collapse">
                        <div class="panel-body">
                            <button class="btn btn-primary">
                                类别列表
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <%--
            内容展示
        --%>
        <div class="col-sm-10" id="myContent">
            <%--
                巨幕
            --%>
            <div class="jumbotron">
                <h1>Hello, world!</h1>
                <p>...</p>
                <p><a class="btn btn-primary btn-lg" href="#" role="button">Learn more</a></p>
            </div>
            <%--
                警告框
            --%>
            <div class="alert alert-danger alert-dismissible fade in" role="alert">
                <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span
                        aria-hidden="true">×</span></button>
                <h4>Oh snap! You got an error!</h4>
                <p>Change this and that and try again. Duis mollis, est non commodo luctus, nisi erat porttitor ligula,
                    eget lacinia odio sem nec elit. Cras mattis consectetur purus sit amet fermentum.</p>
                <p>
                    <button type="button" class="btn btn-danger">Take this action</button>
                    <button type="button" class="btn btn-default">Or do this</button>
                </p>
            </div>
            <%--
                进度条
            --%>
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3>
                        系统状态
                    </h3>
                </div>
                <div class="panel-body">
                    <p>
                        系统使用率
                    </p>
                    <div class="progress">
                        <div class="progress-bar progress-bar-success progress-bar-striped" role="progressbar"
                             aria-valuenow="40" aria-valuemin="0" aria-valuemax="100" style="width: 40%">
                            <span class="sr-only">40% Complete (success)</span>
                        </div>
                    </div>
                    <p>
                        cpu使用率
                    </p>
                    <div class="progress">
                        <div class="progress-bar progress-bar-info progress-bar-striped" role="progressbar"
                             aria-valuenow="20" aria-valuemin="0" aria-valuemax="100" style="width: 20%">
                            <span class="sr-only">20% Complete</span>
                        </div>
                    </div>
                    <div class="progress">
                        <div class="progress-bar progress-bar-warning progress-bar-striped" role="progressbar"
                             aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 60%">
                            <span class="sr-only">60% Complete (warning)</span>
                        </div>
                    </div>
                    <div class="progress">
                        <div class="progress-bar progress-bar-danger progress-bar-striped" role="progressbar"
                             aria-valuenow="80" aria-valuemin="0" aria-valuemax="100" style="width: 80%">
                            <span class="sr-only">80% Complete (danger)</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>