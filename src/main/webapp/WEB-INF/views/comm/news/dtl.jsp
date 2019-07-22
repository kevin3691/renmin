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
	//上传背景图
	function onUploadBg() {
		$("input[name='file']").click();
	}

	//清除背景图
	function onClearBg() {
		$("#url").val("");
		$("#imgPreview").attr('src', "");
	}

	function onUploadSucess(file, res) {
		$("#url").val(res.entity.fileUrl);
		$("#imgPreview").attr('src', res.entity.fileUrl);
	}

	//返回
	function onCancel() {
		if ("${returnUrl}" != "") {
			window.location = _BasePath
					+ "${returnUrl}?colSym=${colSym}&colTitle="
					+ encodeURI("${colTitle}");
		} else {
			window.location = _BasePath
					+ "comm/news/index?colSym=${colSym}&colTitle="
					+ encodeURI("${colTitle}");
		}
		/* var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
			parent.layer.close(index); //再执行关闭 */
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
		//实例化编辑器
		var ue = UE.getEditor('editor');
		$("#editor").height(document.body.clientHeight - 320);
		//加载日期控件		
		$('#publishAt').datetimepicker({
			minView : 0,
			format : "yyyy-mm-dd hh:ii"
		});
		//如果执行时间为空则设为当前时间
		$('#publishAt').val(currentDateTime())
		if ("${o.id}" == "0" || "${o.id}" == "") {
			$("#colSym").val("${colSym}");
			$("#colTitle").val("${colTitle}");
		} else {
			$("#isActive").select2("val", "${o.isActive}");
		}
	})
</script>
</head>
<body>
	<div class="container-fluid">
		<form id="mainForm" class="form-horizontal">
			<input type="hidden" id="id" name="id" value="${o.id}" /> 
			<jsp:include page="/WEB-INF/views/include/recordinfo.jsp" />
			<div class="row">
				<div class="col-md-9 col-sm-9">
					<div class="form-group">
						<label class="col-md-2 col-sm-2 control-label" for="title">标题</label>
						<div class="col-md-10 col-sm-10">
							<input class="form-control" id="title" name="title"
								value="${o.title}" type="text" readonly />
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-2 col-sm-2 control-label" for="summary">摘要</label>
						<div class="col-md-10 col-sm-10">
							<input class="form-control" id="digest" name="summary"
								value="${o.summary}" type="text" readonly />
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-2 col-sm-2 control-label" for="source">来源</label>
						<div class="col-md-4 col-sm-4">
							<input class="form-control" id="source" name="source"
								value="${o.source}" type="text" readonly />
						</div>
						<label class="col-md-2 col-sm-2 control-label" for="publishAt">时间</label>
						<div class="col-md-4 col-sm-4">
							<input class="form-control" id="publishAt" name="publishAt"
								value="${o.publishAt}" type="text" readonly />
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-2 col-sm-2 control-label" for="keyword">关键字</label>
						<div class="col-md-4 col-sm-4">
							<input class="form-control" id="keyword" name="keyword"
								value="${o.keyword}" type="text" readonly />
						</div>
						<label class="col-md-2 col-sm-2 control-label" for="isActive">状态</label>
						<div class="col-md-4 col-sm-4">
							<input class="form-control" id="isActive" name="isActive"
								value="${o.isActive}" type="text" readonly />
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-2 col-sm-2 control-label" for="actors">审核人</label>
						<div class="col-md-4 col-sm-4">
							
						</div>
						<label class="col-md-2 col-sm-2 control-label" for="url">背景图</label>
						<div class="col-md-4 col-sm-4">
							<input class="form-control" id="img" name="img" value="${o.img}"
								type="text" readonly />
						</div>
					</div>
				</div>
				<div class="col-md-3 col-sm-3">
					<img id="imgPreview" src='${o.url}' style="width:95%;height:200px;" />
				</div>
			</div>
			<script id="editor" name="editor" type="text/plain"
				style="width:100%;">
						${o.content}
					</script>
		</form>
	</div>
</body>
</html>