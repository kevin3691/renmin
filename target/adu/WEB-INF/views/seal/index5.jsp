<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/5/20 0020
  Time: 09:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
    <jsp:include page="/WEB-INF/views/include/head4.jsp" />
    <link href="css/master1.css" rel="stylesheet">
</head>
<body>
<%--<div class="bg">--%>
<%--    <div class="index_box">--%>
<%--        <div class="logo"></div>--%>
<%--        <div onclick="javascrtpt:window.location.href='home/logout'"><img style="float: right"  src="images/icon2.jpg"/></div>--%>
<%--        <div class="but_box">--%>
<%--            <button class="but_1" onclick="javascrtpt:window.location.href='seal/sysadmin'"></button>--%>
<%--            <button class="but_2" onclick="javascrtpt:window.location.href='seal/index'"></button></div>--%>
<%--    </div>--%>
<%--</div>--%>

<div class="bg">
    <div class="index_box">
        <div class="logo"></div>
        <div class="but_box">
            <ul>
                <li><a href="seal/index"><img src="images/icon10.png" /><span>公章管理</span></a></li>
                <li><a href="base/org/index"><img src="images/icon11.png" /><span>机构管理</span></a></li>
                <li><a href="base/person/index"><img src="images/icon9.png" /><span>人员管理</span></a></li>
                <li><a href="base/user/index"><img src="images/icon8.png" /><span>用户管理</span></a></li>
                <li><a href="base/role/index"><img src="images/icon7.png" /><span>角色管理</span></a></li>
                <li><a href="base/menu/index"><img src="images/icon6.png" /><span>菜单管理</span></a></li>
                <li><a href="base/power/index"><img src="images/icon5.png" /><span>权限管理</span></a></li>
                <li><a href="base/dict/index"><img src="images/icon4.png" /><span>数据字典</span></a></li>
            </ul>
        </div>
        <div onclick="javascrtpt:window.location.href='home/logout'"><img style="float: right"  src="images/icon2.jpg"/></div>--%>
    </div>
</div>
</body>
</html>
