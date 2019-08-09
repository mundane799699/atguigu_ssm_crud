<%--
  Created by IntelliJ IDEA.
  User: mundane
  Date: 2019/8/9
  Time: 上午10:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>员工列表</title>
    <script src="js/jquery.min.js"></script>
    <link href="static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>


<!-- 员工添加的模态框 -->
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">员工添加</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="empname_add_input" class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <input type="text" name="empName" class="form-control" id="empname_add_input" placeholder="empName">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_add_input" placeholder="email@atguigu.com">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_add_input" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_add_input" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <%-- 部门提交部门id即可 --%>
                            <select class="form-control" name="dId" id="select_add_dept"></select>
                        </div>
                    </div>

                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary">保存</button>
            </div>
        </div>
    </div>
</div>

<div class="container">
    <%--标题--%>
    <div class="row">
        <div class="col-md-12">
            <h1>SSM-CRUD</h1>
        </div>
    </div>
    <%--按钮--%>
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button class="btn btn-primary" id="emp_add_modal_btn">新增</button>
            <button class="btn btn-danger">删除</button>
        </div>
    </div>
    <%--显示表格数据--%>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emps_table">
                <thead>
                <tr>
                    <th>#</th>
                    <th>empName</th>
                    <th>gender</th>
                    <th>email</th>
                    <th>deptName</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
        </div>
    </div>
    <%--显示分页信息--%>
    <div class="row">
        <%--分页文字信息--%>
        <div class="col-md-6" id="page_info_area">

        </div>
        <%--分页条信息--%>
        <div class="col-md-6" id="page_nav_area">

        </div>

    </div>
</div>
<script>
    $(function () {
        toPage(1);
    });

    function toPage(pn) {
        $.ajax({
            url: "emps",
            data: "pn=" + pn,
            type: "get",
            success: function (result) {
                // 解析并显示员工数据
                buildEmpsTable(result);
                // 解析并显示分页信息
                buildPageInfo(result);
                // 解析显示分页条信息
                buildPageNav(result);
            }
        });
    }

    function buildEmpsTable(result) {
        $('#emps_table tbody').empty();
        var emps = result.extend.pageInfo.list;
        $.each(emps, function (index, item) {
            var idTd = $("<td></td>").append(item.empId);
            var nameTd = $("<td></td>").append(item.empName);
            var gender = item.gender === 'M' ? '男' : '女';
            var genderTd = $("<td></td>").append(gender);
            var emailTd = $("<td></td>").append(item.email);
            var deptNameTd = $("<td></td>").append(item.department.deptName);

            var btnEdit = $("<button></button>")
                .addClass("btn btn-primary btn-sm")
                .append($("<span></span>").addClass("glyphicon glyphicon-pencil"))
                .append("编辑");

            var btnDelete = $("<button></button>")
                .addClass("btn btn-danger btn-sm")
                .append($("<span></span>").addClass("glyphicon glyphicon-trash"))
                .append("删除");

            var tdBtn = $("<td></td>").append(btnEdit).append(" ").append(btnDelete);
            $("<tr></tr>").append(idTd)
                .append(nameTd)
                .append(genderTd)
                .append(emailTd)
                .append(deptNameTd)
                .append(tdBtn)
                .appendTo('#emps_table tbody');
        })
    }

    // 解析显示分页信息
    function buildPageInfo(result) {
        var pageInfo = result.extend.pageInfo;
        var pageInfoArea = $("#page_info_area");
        pageInfoArea.empty();
        pageInfoArea.append("当前" + pageInfo.pageNum + "页, 总" + pageInfo.pages + "页, 总" + pageInfo.total + "条记录");
    }

    function buildPageNav(result) {
        $("#page_nav_area").empty();
        var pageInfo = result.extend.pageInfo;

        var ul = $("<ul></ul>").addClass("pagination");
        var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href", "#"));
        var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
        if (!pageInfo.hasPreviousPage) {
            firstPageLi.addClass("disabled");
            prePageLi.addClass("disabled")
        } else {
            prePageLi.click(function () {
                toPage(pageInfo.pageNum - 1);
            });
            firstPageLi.click(function () {
                toPage(1);
            });
        }

        var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
        var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href", "#"));
        if (!pageInfo.hasNextPage) {
            nextPageLi.addClass("disabled");
            lastPageLi.addClass("disabled");
        } else {
            nextPageLi.click(function () {
                toPage(pageInfo.pageNum + 1);
            });
            lastPageLi.click(function () {
                toPage(pageInfo.pages);
            });
        }

        ul.append(firstPageLi).append(prePageLi);
        $.each(pageInfo.navigatepageNums, function (index, item) {
            var numLi = $("<li></li>").append($("<a></a>").append(item));
            if (pageInfo.pageNum === item) {
                numLi.addClass("active");
            }
            numLi.click(function () {
                toPage(item);
            });
            ul.append(numLi);
        });
        // 添加下一页和末页 的提示
        ul.append(nextPageLi).append(lastPageLi);
        // 把ul加入到nav
        var navEle = $("<nav></nav>").append(ul);
        navEle.appendTo("#page_nav_area");
    }

    // 点击新增按钮弹出模态框
    $('#emp_add_modal_btn').click(function(){
        // 发送ajax请求,查出部门信息,显示在下拉列表
        getDepts();
        // 弹出模态框
        $('#empAddModal').modal({
            backdrop: 'static'
        });
    });

    function getDepts(){
        $.ajax({
            url: "depts",
            type: "GET",
            success: function(result) {
                // 显示部门信息在下拉列表中
                var depts = result.extend.depts;
                $.each(depts, function(){
                    var optionEle = $("<option></option>").append(this.deptName).attr("value", this.deptId);
                    optionEle.appendTo($("#select_add_dept"));
                });

            }
        });
    }
</script>

</body>
</html>
