<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>生成静态页</title>
<jsp:include page="/WEB-INF/views/include/head.jsp" />
<script>
	function genStatic (flag) {
	    var para = {
	        colSym : "",
	        colTitle : "",
	        template : "",
	        flag : flag
	    }
	    var index = layer.load (1, {
		    shade : [
		            0.1, '#fff'
		    ]
	    //0.1透明度的白色背景
	    });
	    $.post ("cms/static/handler", para, function () {
		    layer.close (index);
	    });
    }
    //初始化
    $ (function () {
    });
</script>

</head>

<body>
	<div class="container-fluid">
		<div class="breadcrumb content-header form-inline"
			style="height:45px;">
			<ol class="pull-right breadcrumb">
				<li><a href="home/dashboard"><i class="fa fa-dashboard"></i>
						首页</a></li>
				<li class="active">${colTitle}</li>
			</ol>
		</div>
		<div class="row">
			<div class="col-md-3">
				<button class="btn btn-info btn-block" type="button"
					onclick="genStatic('所有')">生成所有</button>
			</div>
			<div class="col-md-3">
				<button class="btn btn-info btn-block" type="button"
					onclick="genStatic('首页')">生成首页</button>
			</div>
			<div class="col-md-3">
				<button class="btn btn-info btn-block" type="button"
					onclick="genStatic('新闻列表')">生成所有新闻列表</button>
			</div>
			<div class="col-md-3">
				<button class="btn btn-info btn-block" type="button"
					onclick="genStatic('单篇文章')">生成所有单篇文章</button>
			</div>
		</div>
	</div>
</body>
</html>
