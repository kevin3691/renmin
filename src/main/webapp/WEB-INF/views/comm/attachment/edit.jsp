<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<jsp:include page="/WEB-INF/views/include/head4.jsp" />
<title>附件添加</title>
<script type="text/javascript">
	function onSave () {
	    //表单验证
	    var vali = $ ('#mainForm').validate ({
		    rules : {
			    title : {
				    required : true
			    }
		    }
	    });
	    if (!vali.form ()){
		    return false;
	    }
	    var para = $ ("#mainForm").serialize ();
	    $.post (_BasePath + 'comm/attachment/save', $ ("#mainForm").serialize (), function (result, status) {
		    if (parent.onSaveOk){
			    parent.onSaveOk (result.entity)
		    }
	    });
    }
    function onCancel () {
	    var index = parent.layer.getFrameIndex (window.name); //先得到当前iframe层的索引
	    parent.layer.close (index); //再执行关闭   
    }
    $ (function () {
	    if ("${o.id}" > 0){
	    	//$("#fileSize").val(commafy ($("#fileSize").val() / 1024));
	    	$("#fileSize").val(commafy ($("#fileSize").val()));
	    }
    })
</script>
</head>

<body>
	<div class="container-fluid">
		<div>&nbsp;</div>
		<form id="mainForm" class="form-horizontal">
			<input type="hidden" id="id" name="id" value="${o.id}" />
			<input type="hidden" id="icon" name="icon" value="${o.icon}" />
			<jsp:include page="/WEB-INF/views/include/recordinfo.jsp" />
			<div class="form-group">
				<label class="col-sm-2 control-label" for="title">标题</label>
				<div class="col-sm-10">
					<input class="form-control" id="title" name="title"
						value="${o.title}" type="text" />
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="category">分类</label>
				<div class="col-sm-4">
					<input class="form-control" id="category" name="category"
						value="${o.category}" type="text" />
				</div>
				<label class="col-sm-2 control-label" for="share">共享</label>
				<div class="col-sm-4">
					<input class="form-control" id="share" name="share"
						value="${o.share}" type="text" />
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="fileUrl">地址</label>
				<div class="col-sm-4">
					<input class="form-control" id="fileUrl" name="fileUrl"
						value="${o.fileUrl}" type="text" />
				</div>
				<label class="col-sm-2 control-label" for="filePath">路径</label>
				<div class="col-sm-4">
					<input class="form-control" id="filePath" name="filePath"
						value="${o.filePath}" type="text" />
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="applyTo">依附</label>
				<div class="col-sm-4">
					<input class="form-control" id="applyTo" name="applyTo"
						value="${o.applyTo}" type="text" />
				</div>
				<label class="col-sm-2 control-label" for="refNum">ID</label>
				<div class="col-sm-4">
					<input class="form-control" id="refNum" name="refNum"
						value="${o.refNum}" type="text" />
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="fileExt">扩展名</label>
				<div class="col-sm-4">
					<div class="input-group">
						<input class="form-control" id="fileExt" name="fileExt"
							value="${o.fileExt}" type="text" />
						<div class="input-group-addon">
							<i class="${o.icon}"></i>
						</div>
					</div>
				</div>
				<label class="col-sm-2 control-label" for="fileSize">大小</label>
				<div class="col-sm-4">
					<div class="input-group">
						<input class="form-control" id="fileSize" name="fileSize"
							value="${o.fileSize}" type="text" />
						<div class="input-group-addon">byte</div>
					</div>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="createdAt">上传时间</label>
				<div class="col-sm-4">
					<input class="form-control" id="createdAt" name="createdAt"
						value="${o.recordInfo.createdAt}" readOnly type="text" />
				</div>
				<label class="col-sm-2 control-label" for="createdByName">上传人</label>
				<div class="col-sm-4">
					<input class="form-control" id="createdByName" name="createdByName"
						value="${o.recordInfo.createdByName}" readOnly type="text" />
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="descr">备注</label>
				<div class="col-sm-10">
					<textarea class="form-control" id="descr" name="descr" rows=2>${o.descr}</textarea>
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
