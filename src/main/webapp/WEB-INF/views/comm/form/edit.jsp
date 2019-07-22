<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<jsp:include page="/WEB-INF/views/include/head.jsp" />
<title>表单-编辑</title>
<script type="text/javascript">
	function onSave() {
		//表单验证
		if (!$('#mainForm').validate().form()) {
			return false;
		}
		var para = $("#mainForm").serialize();
		$.post('comm/form/save', $("#mainForm").serialize(), function(result,
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
			<input type="hidden" id="id" name="id" value="${o.id}" /> <input
				type="hidden" id="category" name="category" value="${o.category}" />
			<input type="hidden" id="html" name="html" value="${o.html}" />
			<jsp:include page="/WEB-INF/views/include/recordinfo.jsp" />
			<div class="form-group">
				<label class="col-sm-2 control-label" for="name">标题</label>
				<div class="col-sm-4">
					<input class="form-control" id="name" name="name" value="${o.name}"
						type="text" required />
				</div>
				<label class="col-sm-2 control-label" for="isActive">有效状态</label>
				<div class="col-sm-4">
					<select id="isActive" name="isActive" class="form-control select2">
						<option value=1>启用</option>
						<option value=0>停用</option>
					</select>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="descr">备注</label>
				<div class="col-sm-10">
					<textarea class="form-control" id="descr" name="descr" rows=3>${o.descr}</textarea>
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