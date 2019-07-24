
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
<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
<meta http-equiv="X-FRAME-OPTIONS" content="DENY">
<meta http-equiv="X-Content-Type-Options" content="nosniff">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="shortcut icon" href="<%=basePath%>images/favicon.ico">
<%--<link href="jslib/bootstrap/css/bootstrap.min.css" rel="stylesheet" />--%>
<script type="text/javascript" charset="utf-8"
	src="jslib/jquery-1.12.4.min.js"></script>
<script type="text/javascript" charset="utf-8"
	src="jslib/jquery.validate.min.js"></script>
<%--<script type="text/javascript" charset="utf-8"--%>
	<%--src="jslib/bootstrap/js/bootstrap.min.js"></script>--%>
<script type="text/javascript" charset="utf-8" src="jslib/form.min.js"></script>
<script type="text/javascript" charset="utf-8" src="<%=basePath%>JavaScriptServlet"></script>
<!--[if lt IE 9]>
      <script src="//cdn.bootcss.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="//cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->