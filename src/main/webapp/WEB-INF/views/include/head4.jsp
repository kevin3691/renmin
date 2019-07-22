
<%
	String path = request.getContextPath();
//	String basePath = request.getScheme() + "://"
//			+ request.getServerName() + ":" + request.getServerPort()
//			+ path + "/";
	String basePath = path + "/";


		String bp = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";

%>
<base id="basePath" href="<%=basePath%>">
<script type="text/javascript">
    var _BasePath = "<%=basePath%>";
    var _BP = "<%=bp%>";
</script>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="shortcut icon" href="<%=basePath%>images/favicon.ico">
<link href="jslib/bootstrap/css/bootstrap.min.css" rel="stylesheet" />
<link href="jslib/jqgrid/css/ui.jqgrid-bootstrap.min.css"
	rel="stylesheet" />
<link href="jslib/bootstrap/css/font-awesome.min.css" rel="stylesheet" />
<link href="jslib/adminlte/css/AdminLTE.min.css" rel="stylesheet" />
<script type="text/javascript" charset="utf-8"
src="jslib/jquery-1.12.4.min.js"></script>
<script type="text/javascript" charset="utf-8"
	src="jslib/jquery.validate.min.js"></script>
<!--[if lt IE 9]>
      <script src="//cdn.bootcss.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="//cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
<script type="text/javascript" charset="utf-8"
	src="jslib/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" charset="utf-8"
	src="jslib/jqgrid/js/jquery.jqGrid.min.js"></script>
<script type="text/javascript" charset="utf-8"
	src="jslib/jqgrid/js/grid.locale-cn.min.js"></script>
<script type="text/javascript" charset="utf-8"
	src="jslib/layer/layer.min.js"></script>
<script type="text/javascript" charset="utf-8"
	src="jslib/layer/extend/layer.ext.min.js"></script>
<script type="text/javascript" charset="utf-8" src="jslib/form.min.js"></script>

<!-- 日期时间选择插件 -->
<link
	href="jslib/plugins/datetimepicker/bootstrap-datetimepicker.min.css"
	rel="stylesheet" />
<script type="text/javascript" charset="utf-8"
	src="jslib/plugins/datetimepicker/bootstrap-datetimepicker.min.js"></script>
<script type="text/javascript" charset="utf-8"
	src="jslib/plugins/datetimepicker/bootstrap-datetimepicker.zh-CN.min.js"></script>

<!-- inputmask -->
<script type="text/javascript" charset="utf-8"
	src="jslib/plugins/input-mask/jquery.inputmask.min.js"></script>
<script type="text/javascript" charset="utf-8"
	src="jslib/plugins/input-mask/jquery.inputmask.date.extensions.min.js"></script>
<script type="text/javascript" charset="utf-8"
	src="jslib/plugins/input-mask/jquery.inputmask.extensions.min.js"></script>

<!-- Select2 -->
<link rel="stylesheet" href="jslib/plugins/select2/select2.min.css">
<script type="text/javascript" charset="utf-8"
	src="jslib/plugins/select2/select2.full.min.js"></script>
<link rel="stylesheet" href="css/jquery-ui-1.9.2.custom.css">
<script type="text/javascript" charset="utf-8"
		src="jslib/jquery-ui.custom.js"></script>
<script type="text/javascript" charset="utf-8"
	src="<%=basePath%>JavaScriptServlet"></script>
