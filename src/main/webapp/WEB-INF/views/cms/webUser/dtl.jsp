<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>

<title>新闻 - 编辑</title>
<jsp:include page="/WEB-INF/views/include/head.jsp" />

<link rel="stylesheet" type="text/css"
	href="jslib/webuploader/webuploader.min.css">
<script type="text/javascript"
	src="jslib/webuploader/webuploader.min.js"></script>
<script type="text/javascript" src="jslib/webuploader/uploader.min.js"></script>
<script type="text/javascript">
	//保存
	function onSave() {
		//表单验证
		if (!$('#mainForm').validate().form()) {
			return false;
		}
		var para = $("#mainForm").serialize();
		$.post('cms/webUser/save', $("#mainForm").serialize(),
				function(result) {
					onCancel();
				});
	}

	//返回
	function onCancel() {
		var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
		parent.layer.close(index); //再执行关闭   
	}
	//数据字典回调函数,初始化后为其赋值
	function dictCallBack(container) {
		if (container == "gender") {
			$("#gender").select2("val", "${o.gender}");
		}
	}
	//初始化
	$(function() {
		//加载select特效
		$(".select2").select2();
		//加载数据字典--性别
		bindDictSelect("GENDER", "gender");
		$("#isVerfiy").select2("val", "${o.isVerfiy}");
		$("#isActive").select2("val", "${o.isActive}");
	})
</script>
</head>
<body>
	<div class="container-fluid">
		<div>&nbsp;</div>
		<form id="mainForm" class="form-horizontal">
			<input type="hidden" id="id" name="id" value="${o.id}" />
			<jsp:include page="/WEB-INF/views/include/recordinfo.jsp" />
			<div class="form-group">
				<label class="col-sm-2 control-label" for="name">用户名</label>
				<div class="col-sm-4">
					<input class="form-control" id="userName" name="userName"
						value="${o.userName}" type="text" readonly />
				</div>
				<label class="col-sm-2 control-label" for="name">真实姓名</label>
				<div class="col-sm-4">
					<input class="form-control" id="realName" name="realName"
						value="${o.realName}" type="text" readonly/>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="gender">性别</label>
				<div class="col-sm-4">
					<select id="gender" name="gender" class="form-control select2">
					</select>
				</div>

			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="title">身份类型</label>
				<div class="col-sm-4">
					<input class="form-control" id="idtype" name="idtype"
						value="${o.idtype}" type="text" readonly/>
				</div>
				<label class="col-sm-2 control-label" for="education">身份证号码</label>
				<div class="col-sm-4">
					<input class="form-control" id="idCardNo" name="idCardNo"
						value="${o.idCardNo}" type="text" readonly/>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="phone">联系电话</label>
				<div class="col-sm-4">
					<input class="form-control" id="phone" name="phone"
						value="${o.phone}" type="text" phone=true readonly/>
				</div>
				<label class="col-sm-2 control-label" for="mobile">手机号码</label>
				<div class="col-sm-4">
					<input class="form-control" id="mobile" name="mobile"
						value="${o.mobile}" type="text" mobile=true readonly/>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="email">邮箱</label>
				<div class="col-sm-4">
					<input class="form-control" id="email" name="email"
						value="${o.email}" type="text" email=true readonly/>
				</div>
				<label class="col-sm-2 control-label" for="fax">传真</label>
				<div class="col-sm-4">
					<input class="form-control" id="fax" name="fax" value="${o.fax}"
						type="text" readonly/>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="isVerfiy">是否核实</label>
				<div class="col-sm-4">
					<select id="isVerfiy" name="isVerfiy" class="form-control select2">
						<option value="">请选择</option>
						<option value="1">是</option>
						<option value="0">否</option>
					</select>
				</div>
				<label class="col-sm-2 control-label" for="isActive">是否启用</label>
				<div class="col-sm-4">
					<select id="isActive" name="isActive" class="form-control select2">
						<option value="">请选择</option>
						<option value="1">启用</option>
						<option value="0">停用</option>
					</select>
				</div>
			</div>

			<div class="form-group">
				<label class="col-sm-2 control-label" for="descr">备注</label>
				<div class="col-sm-10">
					<textarea class="form-control" id="descr" name="descr" rows=3 readonly>${o.descr}</textarea>
				</div>
			</div>
			<div class="form-group controls" style="text-align: center">
				<button type="button" class="btn btn-danger" onclick="onCancel()">返回</button>
			</div>
		</form>
	</div>
</body>
</html>