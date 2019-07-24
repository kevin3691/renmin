<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>附件--测试引用</title>
<jsp:include page="/WEB-INF/views/include/head4.jsp" />
<script>
	$ (function () {
	    var para = "applyTo=testApplyTo&refNum=1&mode=RW&category=" + encodeURI ("测试类别")
	            + "&allowExt=*&allowSize=1000000"
	    $ ("#ifrmAtt").attr ("src", "comm/attachment/index4?" + para);
    })
</script>
</head>

<body>
	<div class="container-fluid">
		<ul class="nav nav-tabs">
			<li><a href="comm/attachment/index">附件列表</a></li>
			<li><a href="comm/attachment/preIndex">预览列表</a></li>
			<li class="active"><a href="comm/attachment/testIndex">测试引用附件</a></li>
		</ul>
		<div class="breadcrumb content-header form-inline">
			<button style="visibility:hidden;">点位用，无意义</button>
			<ol class="breadcrumb">
				<li><a href="home/dashboard"><i class="fa fa-dashboard"></i>
						首页</a></li>
				<li class="active">预览列表</li>
			</ol>
		</div>
		<iframe id="ifrmAtt" class="container-wrapper"
			style="width:100%;height:500px;border-style: none" frameborder="0"
			src=""></iframe>
	</div>
</body>
</html>
