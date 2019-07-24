<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<jsp:include page="/WEB-INF/views/include/head.jsp" />
<title>分类-编辑</title>
<script type="text/javascript">
	function onSave() {
		//表单验证
	    if (!$ ('#mainForm').validate ().form ()){
		    return false;
	    }

		var para = $("#mainForm").serialize();
		$.post(_BasePath + 'sealtype/save', $("#mainForm").serialize(),
				function(result, status) {
					if (result.error){
					    layer.msg (result.error);
					    $ ("#name").focus ();
					    return;
				    }
					if (parent.onSaveOk) {
						parent.onSaveOk(result.entity)
					}
				});
	}

	function onCancel() {
        var index = parent.layer.getFrameIndex (window.name); //先得到当前iframe层的索引
        parent.layer.close (index); //再执行关闭
	}

	$(function() {
        $ (".select2").select2 ();
		
		if ("${o.id}" > 0) {
			$("#isActive").select2("val", "${o.isActive}");
		}
	})
</script>
	<style type="text/css">
		.messager-body{line-height:50px}.messager-window .messager-icon{margin-left:35px}.messager-window .messager-button{border-top:0;background:#fff}.jq-form{margin:10px;padding:0 9px;background:#f1f1f1;font-size:14px}.jq-form .jq-form-row{padding:0 165px;min-height:45px;line-height:45px}.jq-form .jq-form-row.jq-form-submit{height:80px;line-height:80px}.jq-form .jq-form-row.even{background:#fff}.jq-form .jq-form-row>label{float:left;margin-left:-165px;padding-left:30px;width:135px}.jq-form .jq-form-row .jq-form-control{float:left;width:100%}.jq-form .jq-form-row .jq-form-control .jq-form-input{width:100%;height:31px;padding:0 10px;box-sizing:border-box}.jq-form .jq-form-row .jq-form-control .jq-form-textarea{margin-top:10px;width:100%;height:110px;padding:5px;box-sizing:border-box}.jq-form .jq-form-row .jq-form-tip{float:right;margin-right:-165px;padding-left:20px;width:145px;color:#7f7f7f}.jq-form .jq-form-row .jq-form-tip .important{color:#df0000}.jq-form .jq-form-row.jq-form-time .textbox{width:auto!important;height:30px!important;line-height:30px!important}.jq-form .jq-form-row.jq-form-time .textbox-text{width:314px!important;height:30px!important;line-height:30px!important}
	</style>
</head>

<body>
<form id="mainForm" class="form-horizontal">
	<input type="hidden" id="id" name="id" value="${o.id}" />
	<input type="hidden" id="lineNo" name="lineNo" value="${o.lineNo}" />

	<input type="hidden" id="descr" name="descr" value="${o.descr}" />
	<jsp:include page="/WEB-INF/views/include/recordinfo.jsp" />

	<div class="jq-form">
		<br>
		<div class="jq-form-row clearfix">
			<label>类型名称：</label>
			<div class="jq-form-control">
				<input class="jq-form-input"  id="name" name="name" value="${o.name}" type="text" />
			</div>
			<span class="jq-form-tip">
              <span class="important">&nbsp;*&nbsp;</span>
            </span>
		</div>


		<div class="jq-form-row clearfix" style="display:none">
			<label>状态：</label>
			<div class="jq-form-control">
				<select id="isActive" name="isActive" class="select2">
					<option value=1>启用</option>
					<option value=0>停用</option>
				</select>
			</div>
			<span class="jq-form-tip">
              <span class="important">&nbsp;*&nbsp;</span>
            </span>
		</div>
		<div class="jq-form-row clearfix jq-form-submit">
			<div class="jq-form-control">
				<a href="javascript:;" onclick="onSave()" class="easyui-linkbutton" data-options="selected:true">保存</a>
				<a href="javascript:;" onclick="onCancel()" class="easyui-linkbutton">关闭</a>
			</div>
		</div>
	</div>
		</form>

</body>
</html>
