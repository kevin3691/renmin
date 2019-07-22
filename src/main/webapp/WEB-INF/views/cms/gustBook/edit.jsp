<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>

<title>留言板 - 编辑</title>
<jsp:include page="/WEB-INF/views/include/head.jsp" />

<script type="text/javascript">
	//保存
	function onSave() {
		//表单验证
		if (!$('#mainForm').validate().form()) {
			return false;
		}
		var para = $("#mainForm").serialize();
		$.post('cms/gustBook/save', $("#mainForm").serialize(),
				function(result) {
					onCancel();
				});
	}
	//返回
	function onCancel() {
		var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
		parent.layer.close(index); //再执行关闭   
	}
	 //选择回复人
    function onSelPerson () {
	    var title = "选择回复人"
	    layer.open ({
	        type : 2,
	        title : title,
	        shadeClose : true,
	        shade : 0.8,
	        area : [
	                '90%', '90%'
	        ],
	        content : 'base/person/sel'
	    });
    }
    //选择回复人回调方法 
    function onPersonSelOk (row) {
	    $ ("#responseBy").val (row.id)
	    $ ("#responseName").val (row.name)
	    layer.closeAll ();
    }
	//初始化
	$(function() {
		//加载日期控件		
		$('#responseAt').datetimepicker({
			minView : 0,
			format : "yyyy-mm-dd hh:ii"
		});
		//如果执行时间为空则设为当前时间
		$('#responseAt').val(currentDateTime());

	})
</script>
</head>
<body>
	<div class="container-fluid">
		<div>&nbsp;</div>
		<form id="mainForm" class="form-horizontal">
			<input type="hidden" id="id" name="id" value="${o.id}" />
			<input type="hidden" id="display" name="display" value="${o.display}" />
			<input type="hidden" id="stts" name="stts" value="${o.stts}" />
			<jsp:include page="/WEB-INF/views/include/recordinfo.jsp" />
			<div class="form-group">
				<label class="col-sm-2 control-label" for="title">留言标题</label>
				<div class="col-sm-10">
					<input class="form-control" id="title" name="title"
						value="${o.title}" type="text" readonly/>
				</div>

			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="name">留言人名称</label>
				<div class="col-sm-4">
					<input class="form-control" id="name" name="name"
						value="${o.name}" type="text" readonly/>
				</div>
				<label class="col-sm-2 control-label" for="messageAt">留言时间</label>
				<div class="col-sm-4">
					<input class="form-control" id="messageAt" name="messageAt"
						value="${o.messageAt}" type="text" readonly/>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="mobile">手机号码</label>
				<div class="col-sm-4">
					<input class="form-control" id="mobile" name="mobile"
						value="${o.mobile}" type="text" readonly/>
				</div>
				<label class="col-sm-2 control-label" for="phone">联系电话</label>
				<div class="col-sm-4">
					<input class="form-control" id="phone" name="phone"
						value="${o.phone}" type="text" readonly/>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="email">邮箱地址</label>
				<div class="col-sm-4">
					<input class="form-control" id="email" name="email"
						value="${o.email}" type="text" readonly/>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="messageContent">留言内容</label>
				<div class="col-sm-10">
					<textarea class="form-control" id="messageContent"
						name="messageContent" rows=3 readonly>${o.messageContent}</textarea>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="messageName">回复人名称</label>
				<div class="col-md-5 col-sm-4">
					<span class="input-group"> <input class="form-control"
						id="responseName" name="responseName"
						value="${o.responseName}" type="text" readonly  /><span
						class="input-group-btn">
							<button class="btn btn-info btn-flat" type="button"
								onclick="onSelPerson()">选择</button> <input type="hidden"
							id="responseBy" name="responseBy" value="${o.responseBy}" />
					</span>
					</span>
				</div>
				<label class="col-lg-1 col-sm-2 control-label" for="responseAt">回复时间</label>
				<div class="col-lg-5 col-sm-4">
					<div class="input-group">
						<input class="form-control" id="responseAt" name="responseAt"
							value="${o.responseAt}" type="text" />
						<div class="input-group-addon">
							<i id="icon" class="fa fa-calendar"
								onclick="$('#responseAt').datetimepicker('show');"></i>
						</div>
					</div>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="responseContent">回复内容</label>
				<div class="col-sm-10">
					<textarea class="form-control" id="responseContent"
						name="responseContent" rows=3>${o.responseContent}</textarea>
				</div>
			</div>

			<div class="form-group">
				<label class="col-sm-2 control-label" for="descr">备注</label>
				<div class="col-sm-10">
					<textarea class="form-control" id="descr" name="descr" rows=3>${o.descr}</textarea>
				</div>
			</div>

			<div class="form-group controls" style="text-align: center">
				<button type="button" class="btn btn-info" onclick="onSave()">回复</button>
				&nbsp;&nbsp;
				<button type="button" class="btn btn-danger" onclick="onCancel()">返回</button>
			</div>
		</form>
	</div>
</body>
</html>