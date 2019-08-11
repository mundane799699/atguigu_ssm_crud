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

<%-- 员工修改的模态框 --%>
<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">员工修改</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="empname_add_input" class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="empname_update_static"></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_update_input"
                                   placeholder="email@atguigu.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_update_input" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_update_input" value="F"> 女
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
                <button type="button" class="btn btn-primary" id="btn_update_emp">更新</button>
            </div>
        </div>
    </div>
</div>

<!-- 员工添加的模态框 -->
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">员工添加</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="empname_add_input" class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <input type="text" name="empName" class="form-control" id="empname_add_input"
                                   placeholder="empName">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_add_input"
                                   placeholder="email@atguigu.com">
                            <span class="help-block"></span>
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
                <button type="button" class="btn btn-primary" id="btn_save_emp">保存</button>
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
    var totalRecord;

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
                .addClass("btn btn-primary btn-sm btn_edit")
                .append($("<span></span>").addClass("glyphicon glyphicon-pencil"))
                .append("编辑");
            // 为编辑按钮添加自定义属性来表示当前员工的id
            btnEdit.attr("edit-id", item.empId);

            var btnDelete = $("<button></button>")
                .addClass("btn btn-danger btn-sm btn_delete")
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
        totalRecord = pageInfo.pages;
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

    function resetForm(ele) {
        $(ele)[0].reset();
        // 清空表单样式
        $(ele).find("*").removeClass("has-error has success");
        $(ele).find(".help-block").text("");
    }

    // 点击新增按钮弹出模态框
    $('#emp_add_modal_btn').click(function () {
        // 清除表单数据以及样式
        resetForm("#empAddModal form");
        // 发送ajax请求,查出部门信息,显示在下拉列表
        getDepts("#empAddModal select");
        // 弹出模态框
        $('#empAddModal').modal({
            backdrop: 'static'
        });
    });

    function getDepts(ele) {
        // 清空之前下拉列表的值
        $(ele).empty();
        $.ajax({
            url: "depts",
            type: "GET",
            success: function (result) {
                // 显示部门信息在下拉列表中
                var depts = result.extend.depts;
                $.each(depts, function () {
                    var optionEle = $("<option></option>").append(this.deptName).attr("value", this.deptId);
                    optionEle.appendTo(ele);
                });

            }
        });
    }

    // 校验表单数据
    function validateAddForm() {
        var empName = $("#empname_add_input").val();
        var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
        if (!regName.test(empName)) {
            // 应该清空这个元素之前的样式
            showValidateMsg("#empname_add_input", "error", "用户名必须是2-5位中文或者6-16位英文和数字的组合");
            return false;
        } else {
            showValidateMsg("#empname_add_input", "success", "");
        }

        var email = $("#email_add_input").val();
        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if (!regEmail.test(email)) {
            showValidateMsg("#email_add_input", "error", "邮箱格式不正确");
            return false;
        } else {
            showValidateMsg("#email_add_input", "success", "");
        }
        return true;
    }

    function showValidateMsg(ele, status, msg) {
        // 清除当前元素的校验状态
        $(ele).parent().removeClass("has-success has-error");
        $(ele).next("span").text("");
        if ("success" === status) {
            $(ele).parent().addClass("has-success");
            $(ele).next("span").text(msg);
        } else if ("error" === status) {
            $(ele).parent().addClass("has-error");
            $(ele).next("span").text(msg);
        }

    }

    $("#empname_add_input").change(function () {
        var empName = this.value;
        $.ajax({
            url: "checkuser",
            data: "empName=" + empName,
            type: "POST",
            success: function (result) {
                if (result.code == 100) {
                    showValidateMsg("#empname_add_input", "success", "用户名可用");
                    $("#btn_save_emp").attr("ajax-va", "success");
                } else {
                    showValidateMsg("#empname_add_input", "error", result.extend.va_msg);
                    $("#btn_save_emp").attr("ajax-va", "error");
                }
            }

        });
    });

    $("#btn_save_emp").click(function () {
        // 数据校验
        if (!validateAddForm()) {
            return;
        }
        // 利用之前保存下来的checkUser的结果进行校验
        if ($(this).attr("ajax-va") === 'error') {
            return;
        }
        // 保存员工
        $.ajax({
            url: "emp",
            type: "POST",
            data: $('#empAddModal form').serialize(),
            success: function (result) {
                // 100是成功
                if ("100" === result.code) {
                    // 员工保存成功后需要关闭模态框, 并跳转到最后一页
                    $('#empAddModal').modal('hide');
                    toPage(totalRecord + 1);
                } else {
                    var errofFields = result.extend.errorFields;
                    // 显示失败信息
                    if (undefined !== errofFields.email) {
                        showValidateMsg("#email_add_input", "error", errofFields.email);
                    }
                    if (undefined !== errofFields.empName) {
                        showValidateMsg("#empname_add_input", "error", errofFields.empName);
                    }

                }
            }
        });
    });

    $(document).on("click", ".btn_edit", function(){
        // 查出员工信息, 显示员工信息
        getDepts("#empUpdateModal select")
        getEmp($(this).attr("edit-id"));
        // 弹出模态框
        $('#empUpdateModal').modal({
            backdrop: 'static'
        });
    });

    function getEmp(id) {
        $.ajax({
            url: "emp/" + id,
            type: "GET",
            success: function(result){
                var emp = result.extend.emp;
                $("#empname_update_static").text(emp.empName);
                $("#email_update_input").val(emp.email);
                $("#empUpdateModal input[name=gender]").val([emp.gender]);
                $("#empUpdateModal select").val([emp.dId]);
            }
        });
    }
</script>

</body>
</html>
