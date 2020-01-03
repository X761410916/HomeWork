<%@page isELIgnored="false" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>

<link rel="stylesheet" href="${path}/boot/css/bootstrap.min.css">
<script src="${path}/boot/js/jquery-3.3.1.min.js"></script>
<script src="${path}/boot/js/bootstrap.min.js"></script>

<link rel="stylesheet" href="${path}/jqGrid/css/trirand/ui.jqgrid-bootstrap.css">
<script src="${path}/jqGrid/js/i18n/grid.locale-cn.js"></script>
<script src="${path}/jqGrid/js/trirand/jquery.jqGrid.min.js"></script>
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
            url: "${path}/user/queryAll",
            datatype: "json",
            success: function (data) {
                /*
                * index：遍历的下标
                * item： 每一条数据
                * */
                $.each(data, function (index, item) {
                    var dd;
                    if (item.status == 1) {
                        dd = "激活"
                    } else {
                        dd = "冻结"
                    }
                    var id = item.id;
                    $("#myBody").append("<tr>" +
                        "<td>" + id + "</td>" +
                        "<td>" + item.nick_name + "</td>" +
                        "<td>" + item.email + "</td>" +
                        "<td>" + item.password + "</td>" +
                        "<td>" + dd + "</td>" +
                        "<td>" + item.birthday + "</td>" +
                        "<td>" + item.phone + "</td>" +
                        "<td> <button id='" + item.id + "' class='btn btn-primary' onclick='updateUser(this)'>修改</button> &nbsp;&nbsp;<button class='btn btn-danger' onclick='dele(this)' id=" + item.id + ">删除</button></td>" +
                        "</tr>")
                })
            }
        })
    }

    $(function () {
        /*
        *   获取用户数据
        * */
        init();

        /*
        * 添加用户信息
        * */
        $("#mySave").click(function () {
            /*$("#addModal").modal("hide");*/
            var serialize = $("#addUser").serialize();
            console.log(serialize);
            $.ajax({
                url: "${path}/user/insertUser",
                type: "POST",
                datatype: "json",
                data: serialize,
                success: function () {
                    /*
                    * 1. 关闭页面
                    * 2. 只刷新刷新表格
                    * */

                    $("#addUser")[0].reset();
                    init();
                }
            })
        });

        /*
        * 模糊查询
        * */
        $("#selectByLike").click(function () {
            $("#MyES").empty();
            // $("#MyESNot").empty();
            $.ajax({
                url: "${path}/user/fuzzyQuery",
                datatype: "json",
                data: $("#selectByLikeForm").serialize(),
                success: function (data) {
                    if (data == "") {
                        $("#MyES").append("<h2>该条数据不存在</h2>");
                    } else {
                        $("#MyES").append(
                            "<thead>\n" +
                            "<tr>\n" +
                            "<td>姓名</td>\n" +
                            "<td>邮箱</td>\n" +
                            "<td>注册时间</td>\n" +
                            "<td>生日</td>\n" +
                            "<td>用户状态</td>\n" +
                            "<td>电话</td>\n" +
                            "</tr>\n" +
                            "</thead>");
                        $.each(data, function (index, item) {
                            var dd;
                            if (item.status == 1) {
                                dd = "激活"
                            } else {
                                dd = "冻结"
                            }
                            $("#MyES").append(
                                "<tr>" +
                                "<td class=\"success\">" + item.nick_name + "</td>" +
                                "<td class=\"danger\">" + item.email + "</td>" +
                                "<td class=\"success\">" + item.regist_time + "</td>" +
                                "<td class=\"danger\">" + item.birthday + "</td>" +
                                "<td class=\"success\">" + dd + "</td>" +
                                "<td class=\"danger\">" + item.phone + "</td>" +
                                "</tr>")
                        });
                    }
                }
            });
        });
    });

    function dele(result) {
        console.log(result);
        var id = $(result).prop("id");
        $.ajax({
            url: "${path}/user/deleteUser",
            type: "POST",
            datatype: "json",
            data: {"id": id},
            success: function () {
                init();
            }
        })
    }


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
            url: "${path}/user/queryByUserId",
            datatype: "json",
            data: {"id": id},
            success: function (data) {
                $("#username2").val(data.username);
                $("#password2").val(data.password);
                $("#bir2").val(data.bir);
                $("#phoneNumber2").val(data.phoneNumber);
                var dd;
                if (item.status == 1) {
                    dd = "激活"
                } else {
                    dd = "冻结"
                }
                $("#status2").val(dd)
                /*
                *    弹出修改模态框
                * */
                $("#updateModal").modal("show");
            }
        });
    }
</script>


<%--
    页面主体
--%>

<div class="col-sm-12">
    <div class="page-header">
        <h3 id="myH3">用户管理</h3>
    </div>
    <ul class="nav nav-tabs">
        <li class="active">
            <a href="#showUser" data-toggle="tab">用户列表</a>
        </li>
        <%-- <li>
             <a href="#" data-toggle="modal" data-target="#addModal">用户添加</a>
         </li>--%>
    </ul>
    <div class="tab-content">
        <div class="tab-pane active" id="showUser">
            <div class="panel panel-default">
                <%--
                    heading搜索
                --%>
                <div class="panel-heading text-center">
                    <form id="selectByLikeForm" class="form-inline">
                        <div class="form-group">
                            <label for="keyword1">关键字查询</label>
                            <input type="text" name="keyword" placeholder="请输入你要查询的关键字" class="form-control"
                                   id="keyword1">
                        </div>
                        <%-- <div class="form-group">
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
                                 <option value="1">激活</option>
                                 <option value="2">未激活</option>
                             </select>
                         </div>--%>
                        <button id="selectByLike" type="button" class="btn btn-primary" data-toggle="modal"
                                data-target="#queryModal">
                            查询
                        </button>
                    </form>
                </div>
                <%--
                    body
                --%>
                <div class="panel-body" id="grid_selector">
                    <%--
                        表格数据
                    --%>
                    <script>
                        $(function () {
                            $("#list").jqGrid({
                                url: "${path}/user/pageQuery",
                                editurl: "${path}/user/edit",    //表单请求路径
                                styleUI: "Bootstrap",        //设置引入样式必须设置的属性
                                datatype: "json",            //数据交互类型
                                autowidth: true,             //设置表单适应父容器
                                pager: "#pager",             //分页显示的位置
                                viewrecords: true,           //是否显示总条数
                                caption: "USERTABLE",           //设置表单名称
                                toolbar: [true, "top"],       //显示工具栏
                                rowNum: 5,                   //每页显示的数量
                                rowList: [5, 10, 20],           //显示总条数设置的每页展示的数量
                                height: '40%',
                                sortname: 'id',
                                /* colNames:[
                                    "Id","用户名","邮箱","密码","状态","生日","电话","操作"
                                ],   */                       //必须与colModel配合使用
                                colModel: [
                                    {label: "Id", name: "id", align: 'center'},
                                    {
                                        label: "用户名",
                                        name: "nick_name",
                                        align: 'center',
                                        editable: true,
                                        editrules: {required: true}
                                    },
                                    {
                                        label: "邮箱",
                                        name: "email",
                                        align: 'center',
                                        edittype: "email",
                                        email: true,
                                        editable: true
                                    },
                                    {
                                        label: "密码",
                                        name: "password",
                                        align: 'center',
                                        editable: true,
                                        editrules: {required: true}
                                    },
                                    {
                                        label: "状态",
                                        name: "status",
                                        align: 'center',
                                        edittype: "select",
                                        editoptions: {value: '1 :激活;2 :冻结'},
                                        editable: true
                                    },
                                    {
                                        label: "生日",
                                        name: "birthday",
                                        align: 'center',
                                        edittype: "date",
                                        time: true,
                                        editable: true
                                    },
                                    {label: "电话", name: "phone", align: 'center', number: true, editable: true},
                                    /*{label:"操作"}*/
                                ]
                            });

                            $('#list').navGrid('#pager',
                                // the buttons to appear on the toolbar of the grid
                                {
                                    edit: true,
                                    add: true,
                                    del: true,
                                    search: true,
                                    refresh: true,
                                    view: false,
                                    position: "left",
                                    cloneToTop: false
                                },
                                // options for the Edit Dialog
                                {
                                    editCaption: "The Edit Dialog",
                                    recreateForm: true,
                                    checkOnUpdate: true,
                                    checkOnSubmit: true,
                                    closeAfterEdit: true,
                                    errorTextFormat: function (data) {
                                        return 'Error: ' + data.responseText
                                    }
                                },
                                // options for the Add Dialog
                                {
                                    closeAfterAdd: true,
                                    recreateForm: true,
                                    errorTextFormat: function (data) {
                                        return 'Error: ' + data.responseText
                                    }
                                },
                                // options for the Delete Dailog
                                {
                                    errorTextFormat: function (data) {
                                        return 'Error: ' + data.responseText
                                    }
                                });


                            $("#bedata").click(function () {
                                var gr = $("#list").jqGrid('getGridParam', 'selrow');
                                if (gr != null)
                                    $("#list").jqGrid('delGridRow', gr, {
                                        reloadAfterSubmit: false
                                    });
                                else
                                    alert("Please Select Row to delete!");
                            });

                            $("#del").click(function () {
                                $("#list").jqGrid('delRowData', 1);
                            });

                        });

                        /*
                            表格长宽自适应
                        */
                        /*   $(window).resize(function(){
                               // 宽度自动适应
                               $("#list").setGridWidth($(window).width() - 30);
                               // 高度自动适应
                               $(window).unbind("onresize");
                               $("#list").setGridHeight($(window).height() - 370); // grid_selector 是 DIV 的 ID
                               $(window).bind("onresize", this);
                           });*/
                    </script>
                    <table class="table table-striped table-bordered table-hover" id="list">
                        <%--                        <thead>
                                                <tr>
                                                    <td>Id</td>
                                                    <td>名称</td>
                                                    <td>邮箱</td>
                                                    <td>密码</td>
                                                    <td>状态</td>
                                                    <td>生日</td>
                                                    <td>电话</td>
                                                    <td>操作</td>
                                                </tr>
                                                </thead>
                                                <tbody id="myBody">

                                                </tbody>--%>
                    </table>

                    <%--分页框--%>
                    <div id="pager" style="height: 40px"></div>
                    <%--
                        分页
                    --%>
                    <%--   <nav>
                           <ul class="pager">
                               <li><a href="#">上一页</a></li>
                               <li><a href="#">下一页</a></li>
                           </ul>
                       </nav>--%>
                </div>
            </div>
        </div>
    </div>
</div>

<!--
查询用户模态框开始
-->
<div class="modal fade" id="queryModal" tabindex="-1">
    <div class="modal-dialog" style="align-content: center;width:1200px;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title" id="myModalLabel">欢迎来到查询页面</h4>
            </div>
            <div class="modal-body">
                <table class="table table-striped table-bordered table-hover" id="MyES">
                </table>
                <%-- <form id="addUser" class="form-horizontal" method="POST">
                        <div class="row">
                            <div class="col-sm-2 col-sm-offset-2" style="margin-top: 8px">
                                <label for="name" class="control-label">昵称:</label>
                            </div>
                            <div class="input-group col-sm-5">
                                <input id="name" name="nick_name" type="text" class="form-control"/>
                                <span class="input-group-btn">
                            <a href="javascript:void(0)" onclick="clean(this)" class="btn btn-default">&times;</a>
                        </span>
                            </div>
                        </div>

                        <div class="row" style="margin-top: 10px">
                            <div class="col-sm-2 col-sm-offset-2" style="margin-top: 8px">
                                <label for="email" class="control-label">邮箱:</label>
                            </div>
                            <div class="input-group col-sm-5">
                                <input id="email" name="email" type="text" class="form-control"/>
                                <span class="input-group-btn">
                            <a href="javascript:void (0)" onclick="clean(this)" class="btn btn-default">&times;</a>
                        </span>
                            </div>
                        </div>
                        <div class="row" style="margin-top: 10px">
                            <div class="col-sm-2 col-sm-offset-2" style="margin-top: 8px">
                                <label for="password" class="control-label">密码:</label>
                            </div>
                            <div class="input-group col-sm-5">
                                <input id="password" name="password" type="password" class="form-control"/>
                                <span class="input-group-btn">
                            <a href="javascript:void (0)" onclick="clean(this)" class="btn btn-default">&times;</a>
                        </span>
                            </div>
                        </div>

                        <div class="row" style="margin-top: 10px">
                            <div class="col-sm-2 col-sm-offset-2" style="margin-top: 8px">
                                <label for="birthday" class="control-label">生日:</label>
                            </div>
                            <div class="input-group col-sm-5">
                                <input id="birthday" type="date" value="" name="birthday" class="form-control"/>
                            </div>
                        </div>

                        <div class="row" style="margin-top: 10px">
                            <div class="col-sm-2 col-sm-offset-2" style="margin-top: 8px">
                                <label for="phone" class="control-label">电话:</label>
                            </div>
                            <div class="input-group col-sm-5">
                                <input id="phone" name="phone" type="text" class="form-control"/>
                                <span class="input-group-btn">
                            <a href="javascript:void (0)" onclick="clean(this)" class="btn btn-default">&times;</a>
                        </span>
                            </div>
                        </div>

                        <div class="row" style="margin-top: 10px">
                            <div class="col-sm-2 col-sm-offset-2" style="margin-top: 8px">
                                <label for="activate" class="control-label">激活状态:</label>
                            </div>
                            <div class="input-group col-sm-5">
                                <select class="form-control" id="activate" name="status">
                                    <option value="">--请选择--</option>
                                    <option value="2" selected>冻结</option>
                                    <option value="1">激活</option>
                                </select>
                            </div>
                        </div>
                    </form>--%>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger" data-dismiss="modal">点击关闭</button>
            </div>
        </div>
    </div>
</div>
<%--
    查询用户模态框结束
--%>

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
                        <label for="username2" class="col-sm-2 control-label col-sm-offset-2">昵称</label>
                        <div class="col-sm-5">
                            <input type="text" class="form-control" id="username2" name="username">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email2" class="col-sm-2 control-label col-sm-offset-2">邮箱</label>
                        <div class="col-sm-5">
                            <input type="text" class="form-control" id="email2" name="email">
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
                                <option value="1">激活</option>
                                <option value="2">冻结</option>
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" onclick="$('#change').submit();">确认修改</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">点击关闭</button>
            </div>
        </div>
    </div>
</div>
<%--
    修改用户模态框结束
--%>
