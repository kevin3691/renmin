<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<jsp:include page="/WEB-INF/views/include/head.jsp" />
<link rel="stylesheet"
	href="jslib/plugins/ionslider/ion.rangeSlider.css">
<link rel="stylesheet"
	href="jslib/plugins/ionslider/ion.rangeSlider.skinNice.css">
<link rel="stylesheet" href="jslib/plugins/bootstrap-slider/slider.css">
<script src="jslib/plugins/ionslider/ion.rangeSlider.min.js"></script>
<script src="jslib/plugins/bootstrap-slider/bootstrap-slider.js"></script>
<title>任务--安排</title>
<script type="text/javascript">
	//提交
	function onSubmit() {
		var arr = new Array();
		arr = $("#range_1").val().split(";");
		$("#progress").val(arr[0])
		//表单验证
		if (!$('#mainForm').validate().form()) {
			return false;
		}
		var para = $("#mainForm").serialize();
		$.post('comm/task/save', para, function(result, status) {
			if (parent.document.getElementById("ifrmAct")) {
				parent.document.getElementById("ifrmAct").contentWindow.onQ();
			}
			var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
			parent.layer.close(index);
		});
	}
	//选择人员
	function onSelPerson() {
		layer.open({
			type : 2,
			title : "选择人员",
			shadeClose : true,
			shade : 0.8,
			area : [ '800', '85%' ],
			content : 'base/person/sel'
		})
	}
	//选择人员回调函数
	function onPersonSelOk(node) {
		$('#primaryPerson').val(node.name);
		$('#primaryOrg').val(node.baseOrgName);
		layer.closeAll();
	}
	//取消
	function onCancel() {
		var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
		parent.layer.close(index);
	}

	//初始化加载
	$(function() {
		//加载select特效
		$(".select2").select2();
		//为日期设置格式输入
		$("#schedStartAt").inputmask("yyyy-mm-dd", {
			"placeholder" : "yyyy-mm-dd"
		});
		//加载日期控件
		$('#schedStartAt').datetimepicker({
			minView : 4
		//时间，默认为日期时间
		});
		//设置掩码
		$('#schedStartAt').inputmask("yyyy-mm-dd");
		//为日期设置格式输入
		$("#schedEndAt").inputmask("yyyy-mm-dd", {
			"placeholder" : "yyyy-mm-dd"
		});
		//加载日期控件
		$('#schedEndAt').datetimepicker({
			minView : 4
		//时间，默认为日期时间
		});
		//设置掩码
		$('#schedEndAt').inputmask("yyyy-mm-dd");

		if ("${mode}" == "RO") {
			$("#btnSubmit").hide()
		}
		//赋值
		if ("${o.id}" > 0) {
			$('#schedStartAt').val("${o.schedStartAt}");
			$('#schedEndAt').val("${o.schedEndAt}");
		}

		if ($("#schedStartAt").val() == "1900-01-01") {
			$("#schedStartAt").val(currentDateTime())
		}
		if ($("#schedEndAt").val() == "1900-01-01") {
			$("#schedEndAt").val(currentDateTime())
		}
		$('.slider').slider();
		$("#range_1").ionRangeSlider({
			min : 0,
			max : 100,
			from : parseFloat($("#progress").val()),
			to : 100,
			type : 'double',
			step : 1,
			prefix : "%",
			prettify : false,
			hasGrid : true
		});
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
				type="hidden" id="category" name="category" value="${o.category}" />
			<input type="hidden" id="status" name="status" value="${o.status}" />
			<input type="hidden" id="progress" name="progress"
				value="${o.progress}" /> <input type="hidden" id="actStartAt"
				name="actStartAt" value="${o.actStartAt}" /> <input type="hidden"
				id="actEndAt" name="actEndAt" value="${o.actEndAt}" /> <input
				type="hidden" id="actDescr" name="actDescr" value="${o.actDescr}" />
			<input type="hidden" id="assignToOrg" name="assignToOrg"
				value="${o.assignToOrg}" /> <input type="hidden"
				id="assignToPerson" name="assignToPerson"
				value="${o.assignToPerson}" />
			<jsp:include page="/WEB-INF/views/include/basetree.jsp" />
			<jsp:include page="/WEB-INF/views/include/recordinfo.jsp" />
			<div class="form-group">
				<label class="col-sm-2 control-label" for="title">任务标题</label>
				<div class="col-sm-10">
					<input class="form-control" id="title" name="title"
						value="${o.title}" type="text" required readonly />
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="primaryOrg">负责部门</label>
				<div class="col-sm-4">
					<input class="form-control" id="primaryOrg" name="primaryOrg"
						value="${o.primaryOrg}" type="text" required readonly />
				</div>
				<label class="col-sm-2 control-label" for="primaryPerson">负责人</label>
				<div class="col-sm-4">
					<span class="input-group"> <input class="form-control"
						id="primaryPerson" name="primaryPerson" value="${o.primaryPerson}"
						type="text" readonly required /> <span class="input-group-addon">
							<i class="fa fa-search-plus" onclick="onSelPerson()"></i>
					</span>
					</span>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="schedStartAt">计划开始时间</label>
				<div class="col-sm-4">
					<div class="input-group">
						<input class="form-control" id="schedStartAt" name="schedStartAt"
							value="" type="text" />
						<div class="input-group-addon">
							<i id="icon" class="fa fa-calendar"
								onclick="$('#schedStartAt').datetimepicker('show');"></i>
						</div>
					</div>
				</div>
				<label class="col-sm-2 control-label" for="schedEndAt">计划结束时间</label>
				<div class="col-sm-4">
					<div class="input-group">
						<input class="form-control" id="schedEndAt" name="schedEndAt"
							value="" type="text" />
						<div class="input-group-addon">
							<i id="icon" class="fa fa-calendar"
								onclick="$('#schedEndAt').datetimepicker('show');"></i>
						</div>
					</div>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="descr">任务内容</label>
				<div class="col-sm-10">
					<textarea class="form-control" id="descr" name="descr" rows=2
						required>${o.descr}</textarea>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="descr">进度</label>
				<div class="col-sm-10">
					<input id="range_1" type="text" name="range_1" value="">
				</div>
			</div>
			<div class="form-group controls" style="text-align:center">
				<button type="button" class="btn btn-info" onclick="onSubmit()"
					id="btnSubmit">提交</button>
				&nbsp;&nbsp;
				<button type="button" class="btn btn-danger" onclick="onCancel()">取消</button>
				&nbsp;&nbsp;
			</div>
		</form>
	</div>
</body>
</html>