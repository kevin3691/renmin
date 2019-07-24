<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>

<title>新闻 - 编辑</title>
<jsp:include page="/WEB-INF/views/include/head.jsp" />

<link rel="stylesheet" type="text/css"
	href="jslib/webuploader/webuploader.min.css">
<script type="text/javascript"
	src="jslib/webuploader/webuploader.min.js"></script>
<script type="text/javascript" src="jslib/webuploader/uploader.min.js"></script>
<script type="text/javascript">
	//保存
	function onSave() {
		//表单验证
		if (!$('#mainForm').validate().form()) {
			return false;
		}
		var para = $("#mainForm").serialize();
		$.post('cms/link/save', $("#mainForm").serialize(), function(result) {
			onCancel()
		});
	}

	//上传背景图
	function onUploadBg() {
		$("input[name='file']").click();
	}

	//清除背景图
	function onClearBg() {
		$("#background").val("");
		$("#imgPreview").attr('src', "");
	}

	function onUploadSucess(file, res) {
		$("#background").val(res.entity.fileUrl);
		$("#imgPreview").attr('src', res.entity.fileUrl);
	}

	//返回
	function onCancel() {
		window.location = _BasePath
				+ "cms/link/index?colSym=${colSym}&colTitle="
				+ encodeURI("${colTitle}");
	}

	//初始化
	$(function() {	
		UPLOADER.accept = {
			title : 'Images',
			extensions : 'gif,jpg,jpeg,bmp,png',
			mimeTypes : 'image/*'
		}
		UPLOADER.formData = {
			applyTo : 'WfPrintTemp'
		}
		UPLOADER.init();
		//加载select特效
		$(".select2").select2();
		if ("${o.id}" == "0" || "${o.id}" == "") {
			$("#colSym").val("${colSym}");
			$("#colTitle").val("${colTitle}");
		}
		if ("${o.id}" > 0) {
			$("#status").select2("val", "${o.status}");
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
				type="hidden" id="colSym" name="colSym" value="${o.colSym}" /> <input
				type="hidden" id="colTitle" name="colTitle" value="${o.colTitle}" />
			<input type="hidden" id="lineNo" name="lineNo" value="${o.lineNo}" />
			<input type="hidden" id="descr" name="descr" value="${o.descr}" />
			<jsp:include page="/WEB-INF/views/include/recordinfo.jsp" />
			<div class="row">
				<div class="col-md-9 col-sm-8">
					<div class="form-group">
						<label class="col-md-2 col-sm-2 control-label" for="title">标题</label>
						<div class="col-md-4 col-sm-4">
							<input class="form-control" id="title" name="title"
								value="${o.title}" type="text" required />
						</div>
						<label class="col-md-2 col-sm-2 control-label" for="category">分类</label>
						<div class="col-md-4 col-sm-4">
							<input class="form-control" id="category" name="category"
								value="${o.category}" type="text" />
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-2 col-sm-2 control-label" for="url">网址</label>
						<div class="col-md-4 col-sm-4">
							<input class="form-control" id="url" name="url" value="${o.url}"
								type="text" required />
						</div>
						<label class="col-md-2 col-sm-2 control-label" for="background">背景图</label>
						<div class="col-md-4 col-sm-4">
							<div class="input-group">
								<input class="form-control" id="background" name="background"
									value="${o.background}" type="text" readOnly />
								<div class="input-group-addon">
									<i id="icon" class="fa fa-image" onclick="onUploadBg()"></i>
								</div>
								<div class="input-group-addon">
									<i id="icon" class="fa fa-trash-o" onclick="onClearBg()"></i>
								</div>
							</div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-2 col-sm-2 control-label" for="status">状态</label>
						<div class="col-md-4 col-sm-4">
							<select id="status" name="status" class="form-control select2">
								<option>启用</option>
								<option>停用</option>
							</select>
						</div>
					</div>
				</div>
				<div class="col-md-3 col-sm-4">
					<img id="imgPreview" src='${o.background}'
						style="width:95%;height:130px;" />
				</div>
			</div>
		</form>
	</div>
</body>
</html>