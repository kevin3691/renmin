<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<jsp:include page="/WEB-INF/views/include/head.jsp" />
<title>申请材料--编辑</title>
<script type="text/javascript">
	//保存
	function onSave() {
		//表单验证
		if (!$('#mainForm').validate().form()) {
			return false;
		}
		var para = $("#mainForm").serialize();
		$.post('workflow/workDay/save', $("#mainForm").serialize(), function(
				result, status) {
			if (parent.onSaveOk) {
				parent.onSaveOk()
			}
		});
	}

	//返回
	function onCancel() {
		var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
		parent.layer.close(index); //再执行关闭   
	}

	//初始化
	$(function() {
		//加载select特效
		$(".select2").select2();
		//为日期设置格式输入
		$('#wfDate').datetimepicker({
			minView : 2,
			format : 'yyyy-mm-dd'
		});
		//设置掩码
		$('#wfDate').inputmask("yyyy-mm-dd");
		//如果登记时间为空则设为当前时间
		if ($('#wfDate').val() == "") {
			$('#wfDate').val(currentDateTime())
		}
		if ("${o.id}" > 0) {
			$("#ifClass").select2("val", "${o.ifClass}");
			$('#wfDate').val("${o.wfDate}");
		}
	});
</script>
</head>

<body>
	<div class="container-fluid">
		<form id="mainForm" class="form-horizontal">
			<div>&nbsp;</div>
			<input type="hidden" id="id" name="id" value="${o.id}" /> <input
				type="hidden" id="weekDay" name="weekDay" value="${o.weekDay}" />
			<jsp:include page="/WEB-INF/views/include/recordinfo.jsp" />
			<div class="form-group">
				<label class="col-sm-2 control-label" for="wfDate">日期</label>
				<div class="col-sm-4">
					<div class="input-group">
						<input class="form-control" id="wfDate" name="wfDate" value=""
							type="text" />
						<div class="input-group-addon">
							<i id="receiveAt" class="fa fa-calendar"
								onclick="$('#wfDate').datetimepicker('show');"></i>
						</div>
					</div>
				</div>
				<label class="col-sm-2 control-label" for="ifClass">是否班</label>
				<div class="col-sm-4">
					<select id="ifClass" name="ifClass" class="form-control select2">
						<option value=0>否</option>
						<option value=1>是</option>
					</select>
				</div>
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