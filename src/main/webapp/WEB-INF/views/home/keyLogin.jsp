<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
<title>${WorkplateTitle}--登录</title>
<jsp:include page="/WEB-INF/views/include/simplehead.jsp" />
<link href="css/login.min.css" rel="stylesheet" />
</head>
<body class="hold-transition skin-blue-light sidebar-mini">
	<script type="text/javascript">
		if (window.location.href != top.location.href){
	        top.location.href = window.location.href;
        }
        // Cloud Float...
        $ (function () {
	        var $main = $cloud = mainwidth = null;
	        var offset1 = 450;
	        var offset2 = 0;
	        var offsetbg = 0;
	        $main = $ ("#mainBody");
	        $body = $ ("body");
	        $cloud1 = $ ("#cloud1");
	        $cloud2 = $ ("#cloud2");
	        mainwidth = $main.outerWidth ();
	        /// 飘动
	        setInterval (function flutter () {
		        if (offset1 >= mainwidth){
			        offset1 = -580;
		        }
		        if (offset2 >= mainwidth){
			        offset2 = -580;
		        }
		        offset1 += 1.1;
		        offset2 += 1;
		        $ ("#cloud1").css ("background-position", offset1 + "px 100px")
		        $ ("#cloud2").css ("background-position", offset2 + "px 460px")
	        }, 70);
	        setInterval (function bg () {
		        if (offsetbg >= mainwidth){
			        offsetbg = -580;
		        }
		        offsetbg += 0.9;
		        $body.css ("background-position", -offsetbg + "px 0")
	        }, 90);
        })
        //登录方法
        function onLogin () {
	        if (!$ (".alert").is (":hidden")){
		        return;
	        }
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
	        $ ("#btnLogin").button ('loading');
	        $.post ('home/keyLogin', $ ("#mainForm").serialize (), function (result, status) {
		        if (result.IsSuccess){
			        document.location.href = _BasePath + "home/workplate";
		        }
		        else{
			        $ ("#btnLogin").button ('reset');
			        $ (".alert").html (result.Message);
			        $ (".alert").show ();
		        }
	        });
        }
        //检测加密锁
        function checkKey () {
	        var keySN = "";
	        var cnt = 0;
	        try{
		        //打开ET199
		        var ret = ETUCtrl.Open ()
		        $ ("#downDriver").html ('');
		        keySN = ETUCtrl.GetSN ();
		        cnt = ETUCtrl.Enum ();
		        $ ("keySN").val (keySN)
		        $ (".alert").hide ();
	        } catch (e){
		        $ (".alert").html (
		                '<a class="text-warning" href="driver/ET199-ActiveX-Setup.exe">系统检测到您未安装加密锁插件,点击下载安装</a>');
		        $ (".alert").show ();
		        $ ('#mainForm')[0].reset ();
		        setTimeout ("checkKey()", 1000);
		        return;
	        }
	        if (cnt == 0){
		        $ (".alert").html ("未检测到加密锁")
		        $ (".alert").show ();
		        $ ('#mainForm')[0].reset ();
		        setTimeout ("checkKey()", 1000);
		        return;
	        }
	        try{
		        //打开ET199
		        var ret = ETUCtrl.Open ();
		        var ret = ETUCtrl.VerifyPIN (1, "123456781234567812345678");
		        var ret = ETUCtrl.VerifyPIN (0, "12345678");
		        var info = ETUCtrl.Read (0, 255);
		        info += ETUCtrl.Read (255, 255);
		        info = ETUCtrl.TDESDecrypt (info);
		        info = eval ("(" + info + ")");
		        $ ("#basePersonName").val (info.basePersonName);
		        $ ("#username").val (info.username);
		        $ ("#keySN").val (keySN);
	        } catch (e){
		        $ (".alert").html ("此加密锁未绑定用户信息,请联系管理员绑定.")
		        $ (".alert").show ();
		        $ ('#mainForm')[0].reset ();
	        }
	        setTimeout ("checkKey()", 1000);
        }
        //页面加载完执行
        $ (function () {
	        //定位登录框位置，以使其居中
	        $ ('.loginbox').css ({
	            'position' : 'absolute',
	            'left' : ($ (window).width () - 692) / 2
	        });
	        $ (window).resize (function () {
		        $ ('.loginbox').css ({
		            'position' : 'absolute',
		            'left' : ($ (window).width () - 692) / 2
		        });
	        })
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
	        checkKey ();
        });
	</script>

	<div id="mainBody">
		<div id="cloud1" class="cloud"></div>
		<div id="cloud2" class="cloud"></div>
	</div>
	<div class="logintop">
		<span>欢迎登录</span>
		<!--
       <ul>
        <li><a href="#">回首页</a></li>
        <li><a href="#">帮助</a></li>
        <li><a href="#">关于</a></li>
    </ul>
    -->
	</div>
	<div class="loginbody">
		<span class="systemlogo"></span>
		<div class="loginbox">
			<form id="mainForm" class="form-horizontal">
				<ul>
					<li class="form-group">
						<div class="alert alert-danger alert-dismissable"
							style="width:338px;display:none;"></div>
						<div class=" input-group col-md-10">
							<span class="input-group-addon"> <span
								class="glyphicon glyphicon-user"></span>
							</span> <input type="text" id="basePersonName" name="basePersonName"
								style="width:299px;" class="form-control" maxlength="20" placeholder="姓名"
								readonly /> <input type="hidden" id="username" name="username" />
							<input type="hidden" id="keySN" name="keySN" />
						</div>
					</li>
					<li class="form-group">
						<div class="input-group col-md-10">
							<span class="input-group-addon"> <span
								class="glyphicon glyphicon-lock"></span>
							</span> <input type="password" id="password" name="password"
								style="width:299px;" maxlength="20" autocomplete="off"  class="form-control" placeholder="密码" />
						</div>
					</li>
					<li>
						<div class="row">
							<div class="col-md-4">
								<button id="btnLogin" type="button"
									class="btn btn-primary btn-block btn-flat" onclick="onLogin()"
									data-loading-text="登录中...">登 录</button>
							</div>
							<div class="col-md-8">
								<label><input name="" type="checkbox" value=""
									checked="checked" />记住密码</label> <label><a href="#">忘记密码？</a></label>
								<span class="text-warning" id="downDriver"></span>
							</div>
						</div>
					</li>
				</ul>
			</form>

		</div>
	</div>
	<div class="loginbm">${Copyright}</div>
	<OBJECT id="ETUCtrl"
		classid="clsid:9222986D-9A56-4324-99E0-FDAC970EE0B0" VIEWASTEXT></OBJECT>
</body>
</html>
