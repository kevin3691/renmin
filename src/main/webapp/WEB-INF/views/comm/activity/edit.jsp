<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<jsp:include page="/WEB-INF/views/include/head.jsp" />
<title>操作</title>
<script type="text/javascript">
	var _STTS = "${stts}";
	var _APPLYTO = "${applyto}";
	var _REFNUM = "${refnum}";
	//提交
	function onSubmit() {
		//表单验证
		var vali = $('#mainForm').validate({
			rules : {
				contactPerson : {
					required : true
				},
				contactPhone : {
					required : true
				},
				actorName : {
					required : true
				},
				actAt : {
					required : true
				}
			}
		});
		$('#applyTo').val(_APPLYTO);
		$('#refNum').val(_REFNUM);
		$('#category').val(_STTS);
		if (!vali.form()) {
			return false;
		}
		var para = $("#mainForm").serialize();
		$.post('comm/activity/save', para, function(result, status) {
			if (parent.onSaveOk) {
				parent.onSaveOk();
			}
		});
	}
	//选择人员
	function onSelPerson() {
		layer.open({
			type : 2,
			title : "选择人员",
			shadeClose : true,
			shade : 0.8,
			area : [ '80%', '80%' ],
			content : 'base/person/sel'
		})
	}
	//选择人员回调函数
	function onPersonSelOk(node) {
		$('#actorName').val(node.name);
		$('#actorId').val(node.id);
		layer.closeAll();
	}
	//取消
	function onCancel() {
		if (parent.onSaveOk) {
			parent.onSaveOk();
		}
	}

	//初始化加载
	$(function() {
		//为日期设置格式输入
		$("#actAt").inputmask("yyyy-mm-dd", {
			"placeholder" : "yyyy-mm-dd"
		});
		//加载日期控件
		$('#actAt').datetimepicker({
			minView : 4
		//时间，默认为日期时间
		});
		//设置掩码
		$('#actAt').inputmask("yyyy-mm-dd");
		//赋值
		if ("${o.id}" > 0) {
			$('#actAt').val("${o.actAt}");
		}
		if ("${o.id}" <= 0) {
			$('#actorName').val("${baseUser.basePersonName}")
			$('#actorId').val("${baseUser.basePersonId}")
		}
		$("#yesNo").val("否");
	})
</script>
</head>

<body>
	<form id="mainForm" class="form-horizontal">
		<div class="container-fluid">
			<div>&nbsp;</div>
			<input type="hidden" id="id" name="id" value="${o.id}" /> <input
				type="hidden" id="applyTo" name="applyTo" value="${o.applyTo}" /> <input
				type="hidden" id="refNum" name="refNum" value="${o.refNum}" /> <input
				type="hidden" id="category" name="category" value="${o.category}" />
			<input type="hidden" id="yesNo" name="yesNo" value="${o.yesNo}" />
			<div class="form-group">
				<label class="col-sm-2 control-label" for="descr">活动标题</label>
				<div class="col-sm-10">
					<input class="form-control" id="descr" name="descr" type="text" />
				</div>

			</div>

			<div class="form-group">
				<label class="col-sm-2 control-label" for="descr">活动内容</label>
				<div class="col-sm-10">

					<textarea class="form-control" id="descr" name="descr" rows=6>${o.descr}</textarea>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="title">联系人</label>
				<div class="col-sm-4">
					<input class="form-control" id="contactPerson" name="contactPerson"
						value="${o.contactPerson}" type="text" />
				</div>
				<label class="col-sm-2 control-label" for="contactPhone">联系电话</label>
				<div class="col-sm-4">
					<input class="form-control" id="contactPhone" name="contactPhone"
						value="${o.contactPhone}" type="text" />
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="actorName">执行人</label>
				<div class="col-sm-4">
					<input class="form-control" id="actorName" name="actorName"
						value="${o.actorName}" type="text" onclick="onSelPerson()" />
				</div>
				<label class="col-sm-2 control-label" for="actAt">活动时间</label>
				<div class="col-sm-4">
					<div class="input-group">
						<input class="form-control" id="actAt" name="actAt"
							value="1900-01-01" type="text" />
						<div class="input-group-addon">
							<i id="icon" class="fa fa-calendar"
								onclick="$('#actAt').datetimepicker('show');"></i>
						</div>
					</div>
				</div>
			</div>

			<div class="form-group controls" style="text-align:center">
				<button type="button" class="btn btn-info" onclick="onSubmit()">提交</button>
				&nbsp;&nbsp;
				<button type="button" class="btn btn-info" onclick="onCancel()">取消</button>
				&nbsp;&nbsp;
			</div>
		</div>
	</form>
</body>
</html>
