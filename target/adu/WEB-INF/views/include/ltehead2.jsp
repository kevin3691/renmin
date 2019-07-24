<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	//String basePath = path + "/";
	
%>
<base id="basePath" href="<%=basePath%>">
<script type="text/javascript">
    var _BasePath = "<%=basePath%>";
</script>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="shortcut icon" href="<%=basePath%>images/favicon.ico">
<link href="jslib/bootstrap/css/bootstrap.min.css" rel="stylesheet" />
<script type="text/javascript" charset="utf-8"
	src="jslib/jquery-1.12.4.min.js"></script>
<link href="jslib/bootstrap/css/font-awesome.min.css" rel="stylesheet" />
<link href="jslib/adminlte/css/AdminLTE.min.css" rel="stylesheet" />
<link href="jslib/adminlte/css/skins/_all-skins.min.css"
	rel="stylesheet" />
<link href="css/style.css"
	rel="stylesheet" />
<script type="text/javascript" charset="utf-8"
	src="jslib/jquery-ui.min.js"></script>
<script type="text/javascript" charset="utf-8"
	src="jslib/adminlte/js/app.min.js"></script>
<script type="text/javascript" charset="utf-8"
	src="jslib/adminlte/js/demo.min.js"></script>
<script type="text/javascript" charset="utf-8"
	src="jslib/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" charset="utf-8"
	src="jslib/layer/layer.min.js"></script>
<script type="text/javascript" charset="utf-8"
	src="jslib/layer/extend/layer.ext.min.js"></script>
<script type="text/javascript" charset="utf-8" src="<%=basePath%>JavaScriptServlet"></script>
<script type="text/javascript" charset="utf-8">
	// layer.photo 由于该弹出层无法在parent中弹出，所以写入共用JS供调用
    function showAlbum (jdata) {
	    if (!jdata)
		    return;
	    var json = {
	        "title" : jdata.title, //相册标题
	        "id" : jdata.id, //相册id
	        "start" : jdata.start, //初始显示的图片序号，默认0
	        "data" : jdata.data
	    //相册包含的图片，数组格式
	    }
	    layer.photos ({
		    photos : json
	    });
    }
</script>
<!--[if lt IE 9]>
      <script src="//cdn.bootcss.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="//cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->