<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<jsp:include page="/WEB-INF/views/include/head.jsp" />

<title>修改密码</title>

<script type="text/javascript">
	
	//保存
	function onSave() {

		if($("#newpass").val() == "" || $("#confirmpass").val() == "")
		{
			$ (".alert").show ();
			return false;
		}
		if($("#newpass").val() != $("#confirmpass").val())
		{
			$ (".alert").show ();
			return false;
		}
		
		$("#password").val($("#newpass").val())

		$.post ('home/modifyPwdAct', $ ("#mainForm").serialize (), function (result, status) {
	        if (result.IsSuccess){
	        	//var index = parent.layer.getFrameIndex (window.name); //先得到当前iframe层的索引
	    	    //parent.layer.close (index); //再执行关闭
				top.closeWin();
	        }
	        else{
		       
		        $ (".alert").show ();
	        }
        });
		
	}
	//返回
	function onCancel() {
		document.location = 'ocs/paper/index'
	}
	
	
	

	$(function() {
		
	})
</script>
</head>

<body style="background: #eee;height:300px;width:300px;overflow-y:hidden;">
		<div>&nbsp;</div>
		<form id="mainForm">
			<input type="hidden" id="password" name="password" value="" />
			<div>
				<span class="userinfo">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;新密码:</span>
				<input type="password" id="newpass" value="">
				<br/>
				<br/>
				<span class="userinfo">&nbsp;&nbsp;&nbsp;&nbsp;确认密码:</span>
						<input type="password" id="confirmpass" value="">
					<br/>	
					<br/>
						<div style="text-align:center">
							<button type="button" onclick="onSave()" >保存</button>
						</div>
						<br/>
						<div class="alert alert-danger alert-dismissable" style="width:260px;display:none;color:red">两次密码输入不一致</div>
						<br/>
			</div>
			
		</form>
</body>
</html>
