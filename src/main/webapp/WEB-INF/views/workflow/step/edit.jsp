<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<jsp:include page="/WEB-INF/views/include/head4.jsp" />
<title>流程环节 - 编辑</title>
<script type="text/javascript">
	function onSave () {
	    //表单验证
	    if (!$ ('#mainForm').validate ().form ()){
		    return false;
	    }
	    var para = $ ("#mainForm").serialize ();
	    $.post ('workflow/step/save', $ ("#mainForm").serialize (), function (result, status) {
		    if (result.error){
			    layer.msg (result.error);
			    return;
		    }
		    if (parent.onSaveOk){
			    parent.onSaveOk (result.entity)
		    }
		     if (parent.onStepSaveOk){
			    parent.onStepSaveOk (result.entity)
		    }
	    });
    }
    function onCancel () {
	    var index = parent.layer.getFrameIndex (window.name); //先得到当前iframe层的索引
	    parent.layer.close (index); //再执行关闭   
    }
    //初始化
    $ (function () {
    	
    })
</script>
</head>

<body>
	<div class="container-fluid">
		<div class="breadcrumb content-header form-inline"
			style="padding:6px;height:35px;"></div>
		<form id="mainForm" class="form-horizontal">
			<input type="hidden" id="id" name="id" value="${o.id}" /> <input
				type="hidden" id="wfWorkflowId" name="wfWorkflowId" value="${o.wfWorkflowId}" />
			<jsp:include page="/WEB-INF/views/include/recordinfo.jsp" />
			<div class="form-group">
				<label class="col-sm-2 control-label" for="title">流程标题</label>
				<div class="col-sm-10">
					<input class="form-control" id="wfWorkflowTitle" name="wfWorkflowTitle"
						value="${o.wfWorkflowTitle}" type="text" readOnly />
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="title">标题</label>
				<div class="col-sm-4">
					<input class="form-control" id="title" name="title"
						value="${o.title}" type="text" Required />
				</div>
				<label class="col-sm-2 control-label" for="sym">代号</label>
				<div class="col-sm-4">
					<input class="form-control" id="title" name="sym" value="${o.sym}"
						type="text" />
				</div>
			</div>

			<div class="form-group">
			<label class="col-sm-2 control-label" for="preSteps">上一环节</label>
			<div class="col-sm-4">
					<input class="form-control" id="preSteps" name="preSteps" value="${o.preSteps}"
						type="text" />
				</div>
				<label class="col-sm-2 control-label" for="nextSteps">下一环节</label>
			<div class="col-sm-4">
					<input class="form-control" id="nextSteps" name="nextSteps" value="${o.nextSteps}"
						type="text" />
			</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="actUrl">操作地址</label>
				<div class="col-sm-4">
					<input class="form-control" id="actUrl" name="actUrl" value="${o.actUrl}"
						type="text" />
				</div>
				<label class="col-sm-2 control-label" for="dtlUrl">详细提示</label>
				<div class="col-sm-4">
					<input class="form-control" id="dtlUrl" name="dtlUrl" value="${o.dtlUrl}"
						type="text" />
				</div>
				</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="okUrl">返回地址</label>
				<div class="col-sm-4">
					<input class="form-control" id="okUrl" name="okUrl" value="${o.okUrl}"
						type="text" />
				</div>
				<label class="col-sm-2 control-label" for="okMsg">返回提示</label>
				<div class="col-sm-4">
					<input class="form-control" id="okMsg" name="okMsg" value="${o.okMsg}"
						type="text" />
				</div>
				</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="actUrl">备注</label>
				<div class="col-sm-10">
					<textarea class="form-control" id="actUrl" name="actUrl" rows=3>${o.actUrl}</textarea>
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