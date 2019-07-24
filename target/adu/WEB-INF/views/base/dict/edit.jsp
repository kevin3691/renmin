<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<jsp:include page="/WEB-INF/views/include/head4.jsp" />
<title>数据字典-编辑</title>
<script type="text/javascript">
	function onSave () {
	    //表单验证
	    if (!$ ('#mainForm').validate ().form ()){
		    return false;
	    }
	    var para = $ ("#mainForm").serialize ();
	    $.post (_BasePath + 'base/dict/save', $ ("#mainForm").serialize (), function (result, status) {
		    if (result.error){
			    layer.msg (result.error);
			    $ ("#sym").focus ();
			    return;
		    }
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
	    $ (".select2").select2 ();
	    if ("${o.id}" > 0){
		    $ ("#isActive").select2 ("val", "${o.isActive}");
	    }
	    var pathName = "${o.baseTree.pathName}"
	    while (pathName.indexOf(".")>=0){
		    pathName = pathName.replace (".", " / ");
		    $ ("#lblPathName").html (pathName)
	    }
    })
</script>
</head>

<body>
	<div class="container-fluid">
		<div>&nbsp;</div>
		<form id="mainForm" class="form-horizontal">
			<input type="hidden" id="id" name="id" value="${o.id}" /> <input
				type="hidden" id="lineNo" name="lineNo" value="${o.lineNo}" />
			<jsp:include page="/WEB-INF/views/include/basetree.jsp" />
			<jsp:include page="/WEB-INF/views/include/recordinfo.jsp" />
			<div class="form-group">
				<label class="col-sm-1 control-label">上级 </label> <label
					id="lblPathName" class="col-sm-11 control-label"
					style="text-align:left;"> </label>
			</div>
			<div class="form-group">
				<label class="col-sm-1 control-label" for="title">标题</label>
				<div class="col-sm-5">
					<input class="form-control" id="title" name="title"
						value="${o.title}" type="text" required />
				</div>
				<label class="col-sm-1 control-label" for="sym">代码</label>
				<div class="col-sm-5">
					<input class="form-control" id="sym" name="sym" value="${o.sym}"
						type="text" required />
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-1 control-label" for="title">取值</label>
				<div class="col-sm-5">
					<input class="form-control" id="value" name="value"
						value="${o.value}" type="text" />
				</div>
				<label class="col-sm-1 control-label" for="isActive">状态</label>
				<div class="col-sm-5">
					<select id="isActive" name="isActive" class="form-control select2">
						<option value=1>启用</option>
						<option value=0>停用</option>
					</select>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-1 control-label" for="descr">备注</label>
				<div class="col-sm-11">
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
