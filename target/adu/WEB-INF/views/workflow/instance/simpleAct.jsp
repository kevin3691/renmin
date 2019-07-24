<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<jsp:include page="/WEB-INF/views/include/head.jsp" />
<title>数据字典-编辑</title>
<script type="text/javascript">
	//保存
	function onSave() {
		//表单验证
		if (!$('#mainForm').validate().form()) {
			return false;
		}
		var para = $("#mainForm").serialize();
		$.post(_BasePath + 'workflow/instance/actCurStep', $("#mainForm")
				.serialize(), function(result, status) {
			if (result.error) {
				layer.msg(result.error);
				return;
			}
			if (parent.onActOk) {
				parent.onActOk(result.entity)
			}
		});
	}

	//取消
	function onCancel() {
		var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
		parent.layer.close(index); //再执行关闭   
	}

	//初始化
	$(function() {
		//如果执行人为空则设为当前登录人
		if ($('#actorName').val() == "") {
			$('#actorId').val("${baseUser.basePersonId}")
			$('#actorName').val("${baseUser.basePersonName}")
		}
		//如果执行时间为空则设为当前时间
		if ($('#actAt').val() == "") {
			$('#actAt').val(currentDateTime())
		}
		$("#spDescr").html("${o.stepName}");
		$("#spActorName").html("${o.stepName}");
	})
</script>
</head>

<body>
	<div class="container-fluid">
		<div>&nbsp;</div>
		<form id="mainForm" class="form-horizontal">
			<input type="hidden" id="id" name="id" value="${o.id}" /> <input
				type="hidden" id="applyTo" name="applyTo" value="${o.applyTo}" /> <input
				type="hidden" id="refNum" name="refNum" value="${o.refNum}" /> <input
				type="hidden" id="nextStepId" name="nextStepId"
				value="${o.nextStepId}" /> <input type="hidden" id="stepId"
				name="stepId" value="${o.stepId}" /> <input type="hidden"
				id="actorId" name="actorId" value="${o.actorId}" /> <input
				type="hidden" id="yesNo" name="yesNo" value="${o.yesNo}" /> <input
				type="hidden" id="actUrl" name="actUrl" value="${o.actUrl}" /> <input
				type="hidden" id="listUrl" name="listUrl" value="${o.listUrl}" /> <input
				type="hidden" id="dtlUrl" name="dtlUrl" value="${o.dtlUrl}" /> <input
				type="hidden" id="okUrl" name="okUrl" value="${o.okUrl}" /> <input
				type="hidden" id="category" name="id" value="${o.category}" />
			<div class="form-group">
				<label class="col-sm-2 control-label" for="title">标题</label>
				<div class="col-sm-10">
					<input class="form-control" id="title" name="title"
						value="${o.title}" type="text" />
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="stepName">当前环节</label>
				<div class="col-sm-4">
					<input class="form-control" id="stepName" name="stepName"
						value="${o.stepName}" type="text" readonly />
				</div>
				<label class="col-sm-2 control-label" for="nextStepName">下一环节</label>
				<div class="col-sm-4">
					<input class="form-control" id="nextStepName" name="nextStepName"
						value="${o.nextStepName}" type="text" readonly />
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="actorName"><span
					id="spActorName"></span>人</label>
				<div class="col-sm-4">
					<input class="form-control" id="actorName" name="actorName"
						value="${o.actorName}" type="text" readonly />
				</div>
				<label class="col-sm-2 control-label" for="actAt">执行时间</label>
				<div class="col-sm-4">
					<input class="form-control" id="actAt" name="actAt" value=""
						type="text" readonly />
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="descr"><span
					id="spDescr"></span>意见</label>
				<div class="col-sm-10">
					<textarea class="form-control" id="descr" name="descr" rows=3
						required>${o.descr}</textarea>
				</div>
			</div>
			<div class="form-group controls" style="text-align:center">
				<button type="button" class="btn btn-info" onclick="onSave()">提交</button>
				&nbsp;&nbsp;
				<button type="button" class="btn btn-danger" onclick="onCancel()">返回</button>
			</div>
		</form>
	</div>
</body>
</html>
