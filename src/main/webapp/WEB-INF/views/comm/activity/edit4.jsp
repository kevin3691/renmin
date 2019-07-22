<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<jsp:include page="/WEB-INF/views/include/head.jsp" />
<title>活动--编辑</title>
<script type="text/javascript">
	//提交
	function onSubmit() {
		//表单验证
		if (!$('#mainForm').validate().form()) {
			return false;
		}
		var para = $("#mainForm").serialize();
		$.post('comm/activity/save', para, function(result, status) {
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
			area : [ '800', '80%' ],
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
		var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
		parent.layer.close(index);
	}
	//数据字典回调函数,初始化后为其赋值
    function dictCallBack (container) {
	    if (container == "subCategory"){
		    $ ("#subCategory").select2 ("val", "${o.subCategory}");
	    }
    }
    
	//初始化加载
	$(function() {
		//加载日期控件
		$('#actAt').datetimepicker({
			minView : 0,
			format : "yyyy-mm-dd hh:ii"
		//时间，默认为日期时间
		});
		if("${mode}" == "RO")
		{
			$("#btnSubmit").hide()
		}
		//赋值
		if ("${o.id}" > 0) {
			$('#actAt').val("${o.actAt}");
		} else {
			$('#actAt').val(currentDateTime());
			$('#actorName').val("${baseUser.basePersonName}")
			$('#actorId').val("${baseUser.basePersonId}")
		}
		$("#yesNo").val("否");		
		//加载数据字典--性别
	    bindDictSelect ("subCategory", "${actSym}");

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
			<input type="hidden" id="actorId" name="actorId" value="${o.actorId}" />
			<input type="hidden" id="yesNo" name="yesNo" value="${o.yesNo}" />
			<div class="form-group">
				<label class="col-sm-2 control-label" for="subCategory">活动分类</label>
				<div class="col-sm-4">
					<select id="subCategory" name="subCategory" class="form-control select2">
					</select>
				</div>
				<label class="col-sm-2 control-label" for="title">活动标题</label>
				<div class="col-sm-4">
					<input class="form-control" id="title" name="title"
						value="${o.title}" type="text" required />
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="descr">活动内容</label>
				<div class="col-sm-10">
					<textarea class="form-control" id="descr" name="descr" rows=3
						required>${o.descr}</textarea>
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
				<button type="button" class="btn btn-info" onclick="onSubmit()"
					id="btnSubmit">提交</button>
				&nbsp;&nbsp;
				<button type="button" class="btn btn-info" onclick="onCancel()">取消</button>
				&nbsp;&nbsp;
			</div>
		</form>
	</div>
</body>
</html>
