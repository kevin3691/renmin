
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
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta charset="utf-8" />


<meta name="description" content="overview &amp; stats" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />
<script type="text/javascript" charset="utf-8"
		src="jslib/jquery-1.12.4.min.js"></script>
<link href="easyui/css/base.css" rel="stylesheet">
<link href="easyui/css/platform.css" rel="stylesheet">
<link rel="stylesheet" href="easyui/custom/orange/uimaker/easyui.css">
<script type="text/javascript" charset="utf-8" src="<%=basePath%>JavaScriptServlet"></script>
<%--<script type="text/javascript" charset="utf-8">--%>
	<%--// layer.photo 由于该弹出层无法在parent中弹出，所以写入共用JS供调用--%>
    <%--function showAlbum (jdata) {--%>
	    <%--if (!jdata)--%>
		    <%--return;--%>
	    <%--var json = {--%>
	        <%--"title" : jdata.title, //相册标题--%>
	        <%--"id" : jdata.id, //相册id--%>
	        <%--"start" : jdata.start, //初始显示的图片序号，默认0--%>
	        <%--"data" : jdata.data--%>
	    <%--//相册包含的图片，数组格式--%>
	    <%--}--%>
	    <%--layer.photos ({--%>
		    <%--photos : json--%>
	    <%--});--%>
    <%--}--%>
<%--</script>--%>