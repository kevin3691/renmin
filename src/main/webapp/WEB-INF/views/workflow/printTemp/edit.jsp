<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<jsp:include page="/WEB-INF/views/include/head4.jsp" />
<script type="text/javascript" charset="utf-8" src="u000e/config.min.js"></script>
<script type="text/javascript" charset="utf-8" src="u000e/all.min.js"></script>
<link rel="stylesheet" type="text/css"
	href="jslib/webuploader/webuploader.min.css">
<script type="text/javascript"
	src="jslib/webuploader/webuploader.min.js"></script>
<script type="text/javascript" src="jslib/webuploader/uploader.min.js"></script>
<title>打印模板 - 编辑</title>
<script type="text/javascript">
	//保存
	function onSave() {
		//表单验证
		if (!$('#mainForm').validate().form()) {
			return false;
		}
		var ue = UE.getEditor('editor');
		$("#content").val(ue.getContent());
		var para = $("#mainForm").serialize();
		$.post('workflow/printTemp/save', $("#mainForm").serialize(), function(
				result, status) {
			if (result.error) {
				layer.msg(result.error);
				$("#sym").focus();
				return;
			}
			document.location.href = 'workflow/printTemp/index';
		});
	}
	//取消
	function onCancel() {
		window.location.href = _BasePath + "workflow/printTemp/index";
	}
	//数据字典回调函数,初始化后为其赋值
	function dictCallBack(container) {
		if (container == "category") {
			$("#category").select2("val", "${o.category}");
		}
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
	//初始化
	$(function() {
	//实例化编辑器
		var ue = UE.getEditor('editor');
		UPLOADER.accept = {
			title : 'Images',
			extensions : 'gif,jpg,jpeg,bmp,png',
			mimeTypes : 'image/*'
		}
		UPLOADER.formData = {
			applyTo : 'WfPrintTemp'
		}
		UPLOADER.init();
		$(".select2").select2();
		bindDictSelect("PRINTTEMP_CATEGORY", "category");
		
		//ue.setContent('hello');
		$("#editor").height(document.body.clientHeight - 320)
		$("#imgPreview").attr('src', $("#background").val());
		if ("${o.id}" > 0) {
			$("#isActive").select2("val", "${o.isActive}");
			$("#type").select2("val", "${o.type}");
		}
	})
</script>
</head>

<body>
	<div class="container-fluid">
		<div class="breadcrumb content-header form-inline"
			style="padding:8px;height:45px;">
			<ol class="breadcrumb">
				<li><a href="home/dashboard"><i class="fa fa-dashboard"></i>
						首页</a></li>
				<li class="active">打印模板</li>
				<li class="active">编辑</li>
			</ol>
		</div>
		<form id="mainForm" class="form-horizontal">
			<input type="hidden" id="id" name="id" value="${o.id}" /> <input
				type="hidden" id="content" name="content" value="" />
			<jsp:include page="/WEB-INF/views/include/recordinfo.jsp" />
			<div class="form-group">
				<div class="col-md-9">
					<div class="form-group">
						<label class="col-md-1 col-sm-2 control-label" for="title">标题</label>
						<div class="col-md-11 col-sm-10">
							<input class="form-control" id="title" name="title"
								value="${o.title}" type="text" />
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-1 col-sm-2 control-label" for="sym">代号</label>
						<div class="col-md-5 col-sm-4">
							<input class="form-control" id="sym" name="sym" value="${o.sym}"
								type="text" />
						</div>
						<label class="col-md-1 col-sm-2 control-label" for="category">类别</label>
						<div class="col-md-5 col-sm-4">
							<select id="category" name="category"
								class="form-control select2">
							</select>
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-1 col-sm-2 control-label" for="sym">状态</label>
						<div class="col-md-2 col-sm-2">
							<select id="isActive" name="isActive"
								class="form-control select2">
								<option value=1>启用</option>
								<option value=0>停用</option>
							</select>
						</div>
						<label class="col-md-1 col-sm-2 control-label" for="type">状态</label>
						<div class="col-md-2 col-sm-2">
							<select id="type" name="type" class="form-control select2">
								<option value="白纸打">白纸打</option>
								<option value="套打">套打</option>
							</select>
						</div>
						<label class="col-md-1 col-sm-2 control-label" for="background">背景图</label>
						<div class="col-md-5 col-sm-4">
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
				</div>
				<div class="col-md-3">
					<img id="imgPreview" src='${o.background}' height='130px' />
				</div>
			</div>
			<div class="form-group">
				<div class="col-md-12 col-sm-12">
					<script id="editor" name="editor" type="text/plain"
						style="width:100%;">
						${o.content}
					</script>
				</div>
			</div>
			<div class="form-group controls" style="text-align:center">
				<button type="button" class="btn btn-info" onclick="onSave()">保存</button>
				&nbsp;&nbsp;
				<button type="button" class="btn btn-danger" onclick="onCancel()">返回</button>
			</div>
		</form>
	</div>
</body>
</html>
