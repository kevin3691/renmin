?<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@ page contentType="text/html;charset=GBK" language="java" %>
<%
    String path = request.getContextPath();
    //String basePath = request.getScheme() + "://"
    //		+ request.getServerName() + ":" + request.getServerPort()
    //		+ path + "/";
    String basePath = path + "/";
%>
<base id="basePath" href="<%=basePath%>">
<script type="text/javascript">
    var _BasePath = "<%=basePath%>";
</script>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html lang="zh-CN">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=GBK" />
    <title></title>
</head>

<body>
<iframe id="ifrmDoc" style="width: 100%; height: 100%; border: 0;" frameborder="0" src="${url}">

</iframe>
</body>
</html>

