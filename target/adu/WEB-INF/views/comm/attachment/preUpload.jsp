<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>附件上传</title>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<base href="<%=basePath%>">
<link rel="shortcut icon" href="<%=basePath%>images/favicon.ico">
<link rel="stylesheet" type="text/css"
	href="jslib/webuploader/webuploader.min.css">
<link rel="stylesheet" type="text/css"
	href="jslib/webuploader/image-upload/style.min.css">
<script src="jslib/jquery-1.12.4.min.js"></script>
<script>
	$ (function () {
    })
</script>
</head>

<body>
	<div id="wrapper">
		<div id="container">
			<!--头部，相册选择和格式选择-->

			<div id="uploader">
				<div class="queueList">
					<div id="dndArea" class="placeholder">
						<div id="filePicker"></div>
						<p>或将照片拖到这里，单次最多可选300张</p>
					</div>
				</div>
				<div class="statusBar" style="display:none;">
					<div class="progress">
						<span class="text">0%</span> <span class="percentage"></span>
					</div>
					<div class="info"></div>
					<div class="btns">
						<div id="filePicker2"></div>
						<div class="uploadBtn">开始上传</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<script type="text/javascript"
		src="jslib/webuploader/webuploader.min.js"></script>
	<script type="text/javascript"
		src="jslib/webuploader/image-upload/upload.min.js"></script>
</body>
</html>
