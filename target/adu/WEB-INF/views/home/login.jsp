<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib
	uri="http://www.owasp.org/index.php/Category:OWASP_CSRFGuard_Project/Owasp.CsrfGuard.tld"
	prefix="csrf"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<title>${WorkplateTitle}--登录</title>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
<jsp:include page="/WEB-INF/views/include/simplehead.jsp" />
	<link href="css/login.css" rel="stylesheet">
</head>
<body class="bg">
	<script type="text/javascript">
		if (window.location.href != top.location.href){
	        top.location.href = window.location.href;
        }
       
        function ajax (method, uri, body) {
        }
        //登录方法
        function onLogin () {
	        //表单验证
	        var vali = $ ('#mainForm').validate ({
	            rules : {
	                username : {
		                required : true
	                },
	                password : {
		                required : true
	                }
	            },
	            messages : {
	                username : {
		                required : "用户名不能为空."
	                },
	                password : {
		                required : "请输入密码."
	                }
	            }
	        });
	        if (!vali.form ()){
		        return false;
	        }
	        //$ ("#btnLogin").button ('loading');
	        $.post ('home/login', $ ("#mainForm").serialize (), function (result, status) {
		        if (result.IsSuccess){
			        document.location.href = _BasePath + 'home/workplate';
		        }
		        else{
			        //$ ("#btnLogin").button ('reset');
			        $ (".alert").show ();
		        }
	        });
        }
        $ (function () {
            $("#p").attr("type","password");
	        //回车提交
	        document.onkeydown = function (e) {
		        $ (".alert").hide ();
	        }
	        jQuery.extend (jQuery.validator.defaults, {
	            errorElement : 'span',
	            errorClass : 'help-block',
	            focusInvalid : true,
	            highlight : function (element) {
		            $ (element).closest ('.form-group').addClass ('has-error');
	            },
	            success : function (label) {
		            label.closest ('.form-group').removeClass ('has-error');
		            label.remove ();
	            },
	            errorPlacement : function (error, element) {
		            $ (element).closest ('.form-group').append (error);
	            }
	        });
        });
        function go () {
	        document.location.href = "workplate?<csrf:token uri="workplate"/>"
	        return;
        }
        function hidePass (v) {
	        var p = $ ("#p").val ();
	        var pn = v.replace (new RegExp(/(\*)/g), '');
	        if (p.length > v.length - pn.length){
		        p = p.substring (0, v.length - pn.length);
	        }
	        $ ("#p").val (p + pn);
	        $ ("#pd").val ($ ("#pd").val ().replace (/./g, '*'));
        }
	</script>
	

<form id="mainForm" class="form-horizontal">
	<div class="login_box">
		<ul>
			<li><input type="text" class="user" id="u" name="u" maxlength="20" placeholder="用户名" /></li>
			<li><input type="text" class="key" id="p" name="p"
					   maxlength="20" autocomplete="off"
					   placeholder="密码 "/></li>
			<div>
				  <input style="position: absolute;left: 10px;width: 20px;height: 20px;"  type="checkbox" name="jizhu" title="发呆" lay-skin="primary">
				  <span style="position: absolute;left: 40px;">记录密码</span>
			</div>

			<li>
				<input type="button" class="login_button" onclick="onLogin()" value="登&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;录"></input>
			</li>
			<div class="alert alert-error"
				 style="width:338px;display:none;">你输入的密码和账户名不匹配</div>
		</ul>
	</div>

</form>


</body>
</html>
