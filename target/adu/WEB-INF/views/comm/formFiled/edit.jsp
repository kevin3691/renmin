<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<jsp:include page="/WEB-INF/views/include/head.jsp" />
<title>表单属性-编辑</title>
<script type="text/javascript">
	function onSave() {
		//表单验证
		if (!$('#mainForm').validate().form()) {
			return false;
		}
		var para = $("#mainForm").serialize();
		$.post('comm/formFiled/save', $("#mainForm").serialize(), function(result,
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
	//加载select特效
	    $ (".select2").select2 ();
		if ("${o.id}" > 0) {
		$ ("#dataType").select2 ("val", "${o.dataType}");
		$ ("#eleType").select2 ("val", "${o.eleType}");			
		}
	})
</script>
</head>

<body>
	<div class="container-fluid">
		<div>&nbsp;</div>
		<form id="mainForm" class="form-horizontal">
			<input type="hidden" id="id" name="id" value="${o.id}" /> <input
				type="hidden" id="commFormName" name="commFormName"
				value="${o.commFormName}" /><input type="hidden" id="commFormId"
				name="commFormId" value="${o.commFormId}" /> <input type="hidden"
				id="lineNo" name="lineNo" value="${o.lineNo}" />
			<jsp:include page="/WEB-INF/views/include/recordinfo.jsp" />
			<div class="form-group">
				<label class="col-sm-2 control-label" for="title">显示标题</label>
				<div class="col-sm-4">
					<input class="form-control" id="title" name="title"
						value="${o.title}" type="text" required />
				</div>
				<label class="col-sm-2 control-label" for="name">属性名称</label>
				<div class="col-sm-4">
					<input class="form-control" id="name" name="name" value="${o.name}"
						type="text" required />
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="dataType">类型</label>
				<div class="col-sm-4">
					<select id="dataType" class="form-control select2" name="dataType">
						<option selected>String</option>
						<option>int</option>
						<option>Date</option>
						<option>double</option>
					</select>
				</div>
				<label class="col-sm-2 control-label" for="dataLength">长度</label>
				<div class="col-sm-4">
					<input class="form-control" id="dataLength" name="dataLength"
						value="${o.dataLength}" type="text" />
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="eleType">元素类型</label>
				<div class="col-sm-4">
					<select id="eleType" class="form-control select2" name="eleType">
						<option selected>单行文本</option>
						<option>多行文本</option>
						<option>下拉</option>
					</select>
				</div>
				<label class="col-sm-2 control-label" for="name"></label>
				<div class="col-sm-4"></div>
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