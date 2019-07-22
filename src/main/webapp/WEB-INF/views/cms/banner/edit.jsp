<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>

<title>新闻 - 编辑</title>
<jsp:include page="/WEB-INF/views/include/head.jsp" />
<script type="text/javascript" charset="utf-8" src="u000e/config.min.js"></script>
<script type="text/javascript" charset="utf-8" src="u000e/all.min.js"></script>
<link rel="stylesheet" type="text/css"
	href="jslib/webuploader/webuploader.min.css">
<script type="text/javascript"
	src="jslib/webuploader/webuploader.min.js"></script>
<script type="text/javascript" src="jslib/webuploader/uploader.min.js"></script>
<script type="text/javascript">
	//保存
    function onSave () {
	    //表单验证
	    if (!$ ('#mainForm').validate ().form ()){
		    return false;
	    }
	    var para = $ ("#mainForm").serialize ();
	    $.post ('cms/news/save', $ ("#mainForm").serialize (), function (result) {
		    onCancel ()
	    });
    }
    //上传图片
    function onUploadImg () {
	    $ ("input[name='file']").click ();
    }
    //清除图片
    function onClearBg () {
	    $ ("#img").val ("");
	    $ ("#imgPreview").attr ('src', "");
    }
    function onUploadSucess (file, res) {
	    $ ("#img").val (res.entity.fileUrl);
	    $ ("#imgPreview").width (document.body.clientWidth-30)
	    $ ("#imgPreview").attr ('src', res.entity.fileUrl);
    }
    //返回
    function onCancel () {
	    if ("${returnUrl}" != ""){
		    window.location = _BasePath + "${returnUrl}?colSym=${colSym}&colTitle=" + encodeURI ("${colTitle}");
	    }
	    else{
		    window.location = _BasePath + "cms/banner/index?colSym=${colSym}&colTitle=" + encodeURI ("${colTitle}");
	    }
    }
    //初始化
    $ (function () {
	    UPLOADER.accept = {
	        title : 'Images',
	        extensions : 'gif,jpg,jpeg,bmp,png',
	        mimeTypes : 'image/*'
	    }
	    UPLOADER.formData = {
		    applyTo : 'CmsNews'
	    }
	    UPLOADER.init ();
	    if ($ ("#id").val () != "0"){
		    $ ("#imgPreview").width (document.body.clientWidth-30)
	    }
    })
</script>
</head>
<body>
	<div class="container-fluid">
		<div class="breadcrumb content-header form-inline"
			style="padding:8px;">
			<div class="form-group">
				<button type="button" class="btn btn-info" onclick="onSave()">保存</button>
				&nbsp;
				<button type="button" class="btn btn-danger" onclick="onCancel()">返回</button>
			</div>
			<ol class="pull-right breadcrumb">
				<li><a href="home/dashboard"><i class="fa fa-dashboard"></i>
						首页</a></li>
				<li class="active">${colTitle}</li>
			</ol>
		</div>
		<form id="mainForm" class="form-horizontal">
			<input type="hidden" id="id" name="id" value="${o.id}" /> <input
				type="hidden" id="template" name="template" value="横幅广告" /><input
				type="hidden" id="colSym" name="colSym" value="${o.colSym}" /> <input
				type="hidden" id="colTitle" name="colTitle" value="${o.colTitle}" />
			<input type="hidden" id="stts" name="stts" value="${o.stts}" /> <input
				type="hidden" id="hits" name="hits" value="${o.hits}" /> <input
				type="hidden" id="lineNo" name="lineNo" value="${o.lineNo}" />
			<jsp:include page="/WEB-INF/views/include/recordinfo.jsp" />
			<div class="form-group">
				<label class="col-md-1  col-sm-2 control-label" for="title">标题</label>
				<div class="col-md-5 col-sm-4">
					<input class="form-control" id="title" name="title"
						value="${o.title}" type="text" required maxlength=200 />
				</div>
				<label class="col-md-1  col-sm-2 control-label" for="url">链接</label>
				<div class="col-md-5 col-sm-4">
					<input class="form-control url" id="url" name="url" value="${o.url}"
						type="text" maxlength=200 />
				</div>
			</div>
			<div class="form-group">
				<label class="col-md-1 col-sm-2 control-label" for="img">图片</label>
				<div class="col-md-5 col-sm-4">
					<div class="input-group">
						<input class="form-control" id="img" name="img" value="${o.img}"
							type="text" readOnly maxlength=255 />
						<div class="input-group-addon">
							<i id="icon" class="fa fa-image" onclick="onUploadImg()"></i>
						</div>
						<div class="input-group-addon">
							<i id="icon" class="fa fa-trash-o" onclick="onClearImg()"></i>
						</div>
					</div>
				</div>
				<label class="col-md-1 col-sm-1 control-label" for="width">宽度</label>
				<div class="col-md-2 col-sm-2">
					<input class="form-control" id="width" name="width"
						value="${o.width}" type="text" onkeyup="clearNoNum(this)" />
				</div>
				<label class="col-md-1 col-sm-1 control-label" for="height">高度</label>
				<div class="col-md-2 col-sm-2">
					<input class="form-control" id="height" name="height"
						value="${o.height}" type="text" onkeyup="clearNoNum(this)" />
				</div>
			</div>
			<div class="form-group">
				<label class="col-md-1 col-sm-2 control-label" for="content">说明</label>
				<div class="col-md-11 col-sm-10">
					<textarea class="form-control" id="content" name="content"
						value="${o.content}" rows="2" cols=""></textarea>
				</div>
			</div>
		</form>
		<img id="imgPreview" src='${o.img}' />
	</div>
</body>
</html>