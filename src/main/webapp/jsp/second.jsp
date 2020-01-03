<%@page isELIgnored="false" contentType="text/html; UTF-8" pageEncoding="UTF-8" %>

<style>
    #myH3 {
        margin-top: -39px;
        margin-bottom: 10px;
    }
</style>
<script>
    function init() {
        $("#myBody").empty();
        $.ajax({
            url: "${pageContext.request.contextPath}/user/queryAll",
            datatype: "json",
            success: function (data) {
                /*
                * index：遍历的下标
                * item： 每一条数据
                * */
                $.each(data, function (index, item) {
                    $("#myBody").append("<tr>" +
                        "<td>" + item.id + "</td>" +
                        "<td>" + item.username + "</td>" +
                        "<td>" + item.password + "</td>" +
                        "<td>" + item.bir + "</td>" +
                        "<td>" + item.phoneNumber + "</td>" +
                        "<td>" + item.status + "</td>" +
                        "<td> <button id='" + item.id + "' class='btn btn-primary' onclick='updateUser(this)'>修改</button><button class='btn btn-primary'>删除</button></td>" +
                        "</tr>")
                })
            }
        })
    }


    $(function () {
        /*
        *   获取用户数据
        * */
        init()

        /*
        * 添加用户信息
        * */
        $("#mySave").click(function () {
            var serialize = $("#addUser").serialize();
            console.log(serialize);
            $.ajax({
                url: "${pageContext.request.contextPath}/user/addUser",
                datatype: "json",
                data: serialize,
                success: function () {
                    /*
                    * 1. 关闭页面
                    * 2. 只刷新刷新表格
                    * */
                    $("#addModal").modal("hide");
                    $("#addUser")[0].reset();
                    init();
                }
            })
        })

        /*
        * 模糊查询
        * */
        $("#selectByLike").click(function () {
            $.ajax({
                url: "${pageContext.request.contextPath}/user/queryByLike",
                datatype: "json",
                data: $("#slectByLikeForm").serialize(),
                success: function (data) {
                    $("#myBody").empty();
                    $.each(data, function (index, item) {
                        $("#myBody").append("<tr>" +
                            "<td>" + item.id + "</td>" +
                            "<td>" + item.username + "</td>" +
                            "<td>" + item.password + "</td>" +
                            "<td>" + item.bir + "</td>" +
                            "<td>" + item.phoneNumber + "</td>" +
                            "<td>" + item.status + "</td>" +
                            "<td> <button class='btn btn-primary'>修改</button><button class='btn btn-primary'>删除</button></td>" +
                            "</tr>")
                    })
                }
            })
        })
    })

    function updateUser(item) {
        /*console.log(item);*/
        /*
        * dom 对象转换为jquery对象  item---》dom   $(dom)--->jquery
        * jquery对象 转换为dom 对象   xxx[0]
        * */
        /*
        * $(item).prop("id")
        * $(item).attr("id")
        * 以上两种方式  是通过属性名取值
        * */
        var id = $(item).attr("id");
        $.ajax({
            url: "${pageContext.request.contextPath}/user/queryById",
            datatype: "json",
            data: {"id": id},
            success: function (data) {
                $("#username2").val(data.username)
                $("#password2").val(data.password)
                $("#bir2").val(data.bir)
                $("#phoneNumber2").val(data.phoneNumber)
                var status = data.status;
                if (status == "激活") {
                    $("#status2").val('激活')
                } else {
                    $("#status2").val('未激活')
                }
                /*
                *    弹出修改模态框
                * */
                $("#updateModal").modal("show")
            }
        })
    }
</script>


<%--
    页面主体
--%>

<div class="col-sm-10">
    <div class="page-header">
        <h3 id="myH3">用户管理</h3>
    </div>
    <ul class="nav nav-tabs">
        <li class="active">
            <a href="#showUser" data-toggle="tab">用户列表</a>
        </li>
        <li>
            <a href="#" data-toggle="modal" data-target="#addModal">用户添加</a>
        </li>
    </ul>
    <div class="tab-content">
        <div class="tab-pane active" id="showUser">
            <div class="panel panel-default">
                <%--
                    heading搜索
                --%>
                <div class="panel-heading text-center">
                    <form id="slectByLikeForm" class="form-inline">
                        <div class="form-group">
                            <label for="username1">姓名</label>
                            <input type="text" name="username" placeholder="输入姓名" class="form-control" id="username1">
                        </div>
                        <div class="form-group">
                            <label for="phoneNumber1">手机号</label>
                            <input type="text" placeholder="输入手机号" class="form-control" id="phoneNumber1">
                        </div>
                        <div class="form-group">
                            <label>激活状态</label>
                            <select class="form-control" name="status">
                                <option value="激活">激活</option>
                                <option value="未激活">未激活</option>
                            </select>
                        </div>
                        <button id="selectByLike" type="button" class="btn btn-primary">
                            查询
                        </button>
                    </form>
                </div>
                <%--
                    body
                --%>
                <div class="panel-body">
                    <%--
                        表格数据
                    --%>
                    <table class="table table-striped table-bordered table-hover">
                        <thead>
                        <tr>
                            <th>Id</th>
                            <th>姓名</th>
                            <th>密码</th>
                            <th>生日</th>
                            <th>手机号</th>
                            <th>状态</th>
                            <th>操作</th>
                        </tr>
                        </thead>
                        <tbody id="myBody">

                        </tbody>
                    </table>

                    <%--
                        分页
                    --%>
                    <nav>
                        <ul class="pager">
                            <li><a href="#">上一页</a></li>
                            <li><a href="#">下一页</a></li>
                        </ul>
                    </nav>
                </div>
            </div>
        </div>
    </div>
</div>

<!--
添加用户模态框
-->
<div class="modal fade" id="addModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title" id="myModalLabel">添加用户</h4>
            </div>
            <div class="modal-body">
                <form id="addUser" class="form-horizontal" method="post">
                    <div class="form-group">
                        <label for="name" class="col-sm-2 control-label col-sm-offset-2">姓名</label>
                        <div class="col-sm-5">
                            <input type="text" class="form-control" id="name" name="username">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="password" class="col-sm-2 control-label col-sm-offset-2">密码</label>
                        <div class="col-sm-5">
                            <input type="text" class="form-control" id="password" name="password">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="birthday" class="col-sm-2 control-label col-sm-offset-2">生日</label>
                        <div class="col-sm-5">
                            <input type="date" class="form-control" id="birthday" placeholder="年-月-日" name="bir">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="phone" class="col-sm-2 control-label col-sm-offset-2">手机号</label>
                        <div class="col-sm-5">
                            <input type="text" class="form-control" id="phone" name="phoneNumber">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="statu" class="col-sm-2 control-label col-sm-offset-2">激活状态</label>
                        <div class="col-sm-5">
                            <select class="form-control" id="statu" name="status">
                                <option value="激活">激活</option>
                                <option value="未激活">不激活</option>
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" id="mySave">保存</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            </div>
        </div>
    </div>
</div>

<%--
    修改用户模态框
--%>
<!-- 修改用户弹出框 -->
<div class="modal fade" id="updateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel1">修改用户信息</h4>
            </div>
            <div class="modal-body">
                <form id="change" class="form-horizontal"
                      action="${pageContext.request.contextPath}/customer/changeCusInfo" method="get">
                    <input id="id1" name="id" style="visibility: hidden">
                    <div class="form-group">
                        <label for="username2" class="col-sm-2 control-label col-sm-offset-2">姓名</label>
                        <div class="col-sm-5">
                            <input type="text" class="form-control" id="username2" name="username">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="password2" class="col-sm-2 control-label col-sm-offset-2">密码</label>
                        <div class="col-sm-5">
                            <input type="text" class="form-control" id="password2" name="password">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="bir2" class="col-sm-2 control-label col-sm-offset-2">生日</label>
                        <div class="col-sm-5">
                            <input type="text" class="form-control" name="bir" id="bir2" placeholder="年-月-日">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="phoneNumber2" class="col-sm-2 control-label col-sm-offset-2">手机号</label>
                        <div class="col-sm-5">
                            <input type="text" class="form-control" id="phoneNumber2" name="phone">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="status2" class="col-sm-2 control-label col-sm-offset-2">激活状态</label>
                        <div class="col-sm-5">
                            <select class="form-control" id="status2" name="status">
                                <option value="激活">激活</option>
                                <option value="未激活">未激活</option>
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" onclick="$('#change').submit();">保存</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            </div>
        </div>
    </div>
</div>

