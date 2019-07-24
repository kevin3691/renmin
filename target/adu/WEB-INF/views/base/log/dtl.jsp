<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<jsp:include page="/WEB-INF/views/include/head.jsp" />
<title>角色添加</title>
<script type="text/javascript">
	function onSave() {
		var para = $("#mainForm").serialize();
		$.post('base/log/save', $("#mainForm").serialize(), function(result,
				status) {
			if (parent.onSaveOk) {
				parent.onSaveOk(result.entity)
			}
		});
	}

	function onCancel() {
		var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
		parent.layer.close(index); //再执行关闭   
	}
	
	$(function() {
		if ("${o.id}" > 0) {
			var v = ${o.isActive}
			$("#isActive").val(v);
		}
	})
</script>
</head>
<body>
	<div class="container-fluid">
		<div>&nbsp;</div>
		<form id="mainForm" class="form-horizontal">
			<input type="hidden" id="id" name="id" value="${o.id}" />

			<div class="form-group">
				<label class="col-sm-1 control-label" for="title">标题</label>
				<div class="col-sm-11">
					<input readOnly class="form-control" id="title" name="title"
						value="${o.title}" type="text" />
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-1 control-label" for="category">类别</label>
				<div class="col-sm-5">
					<input readOnly class="form-control" id="category" name="category"
						value="${o.category}" type="text" />
				</div>
				<label class="col-sm-2 control-label" for="createdByName">操作人</label>
				<div class="col-sm-4">
					<input readOnly class="form-control" id="createdByName"
						name="createdByName" value="${o.recordInfo.createdByName}"
						type="text" />
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-1 control-label" for="applyTo">依附</label>
				<div class="col-sm-5">
					<input readOnly class="form-control" id="applyTo" name="applyTo"
						value="${o.applyTo}" type="text" />
				</div>
				<label class="col-sm-2 control-label" for="refNum">关联ID</label>
				<div class="col-sm-4">
					<input readOnly class="form-control" id="refNum" name="refNum"
						value="${o.refNum}" type="text" />
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-1 control-label" for="createdAt">时间</label>
				<div class="col-sm-5">
					<input readOnly class="form-control" id="createdAt"
						name="createdAt" value="${o.recordInfo.createdAt}" type="text" />
				</div>
				<label class="col-sm-2 control-label" for="clientIP">IP</label>
				<div class="col-sm-4">
					<input readOnly class="form-control" id="clientIP" name="clientIP"
						value="${o.recordInfo.clientIP}" type="text" />
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-1 control-label" for="descr">备注</label>
				<div class="col-sm-11">
					<textarea readOnly class="form-control" id="descr" name="descr"
						rows=3>${o.descr}</textarea>
				</div>
			</div>
			<div class="form-group controls" style="text-align:center">
				<button type="button" class="btn btn-danger" onclick="onCancel()">返回</button>
			</div>
		</form>

	</div>
</body>
</html>
