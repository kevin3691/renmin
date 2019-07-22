<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>附件上传</title>
<jsp:include page="/WEB-INF/views/include/head.jsp" />

<link rel="stylesheet" type="text/css"
	href="jslib/webuploader/webuploader.min.css">
<link rel="stylesheet" type="text/css"
	href="jslib/webuploader/cropper/cropper.min.css">
<link rel="stylesheet" type="text/css"
	href="jslib/webuploader/cropper/style.min.css">
<script>
	$ (function () {
    })
</script>
</head>

<body>
	<div class="container-fluid">
		<div id="wrapper">
			<div class="uploader-container">
				<div id="filePicker">选择文件</div>
			</div>
			<!-- Croper container -->
			<div class="cropper-wraper webuploader-element-invisible">
				<div class="img-container">
					<img src="" alt="" />
				</div>

				<div class="upload-btn">上传所选区域</div>

				<div class="img-preview"></div>
			</div>
		</div>
	</div>
	<script type="text/javascript"
		src="jslib/webuploader/webuploader.min.js"></script>
	<script type="text/javascript"
		src="jslib/webuploader/cropper/cropper.min.js"></script>
	<script type="text/javascript"
		src="jslib/webuploader/cropper/uploader.min.js"></script>
</body>
</html>
