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
    <link href="css/master1.css" rel="stylesheet">
    <style>
        .li_h{height: 32px;}
    </style>
</head>
<body class="bg1" onload="getMedia()" oncontextmenu=self.event.returnValue=false>
<script type="text/javascript">
    if (window.location.href != top.location.href){
        top.location.href = window.location.href;
    }

    function ajax (method, uri, body) {
    }
    //登录方法
    function onLogin () {

        if(check.checked){
            console.log(check.checked);

            // alert("选中");
            // 勾选框勾选的时候设置本地的用户名和密码的val为输入的值
            localStorage.setItem('user',u.value);
            localStorage.setItem('pass',p.value);

        }else{
            // alert('未勾选');
            // 勾选框未勾选的时候设置本地的用户名和密码为空
            localStorage.setItem("user","");
            localStorage.setItem("pass","");
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

        //$ ("#btnLogin").button ('loading');
        $.post ('home/login', $ ("#mainForm").serialize (), function (result, status) {
            if (result.IsSuccess){
                document.location.href = _BasePath + 'seal/index5';
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

<script>
    function getMedia() {
        var user = document.getElementById('u');
        var password = document.getElementById('p');
        var check = document.getElementById('check');
        var btn = document.getElementById('btn');
        // 获取设置的本地存储的用户名的值
        var loUser = localStorage.getItem('user');
        // 获取设置的本地存储的密码的值
        var loPass = localStorage.getItem('pass');
        // 将本地存储的值设置给用户名和密码
        user.value= loUser;
        password.value = loPass;
    }






    // 判断本地存储值不为空的时候将勾选的checked设置为空
    // if(loUser!==''&&loPass!=='') {
    //     check.setAttribute('checked',true);
    // }

    // btn.onclick=function(){
    //
    // }


</script>


<form id="mainForm" class="form-horizontal">
<%--    <div class="login_box">--%>
<%--        <ul>--%>
<%--            <li><input type="text" class="user" id="u" name="u" maxlength="20" placeholder="用户名" /></li>--%>
<%--            <li style="height: 35px"><input type="text" class="key" id="p" name="p"--%>
<%--                                            maxlength="20" autocomplete="on"--%>
<%--                                            placeholder="密码 "/></li><br>--%>
<%--            <li style=" width:288px; height: 35px;" ><span style="font-size: 14px; color: #717171; display: block; float: right; margin-right: 12px; margin-left: 6px;">记住密码</span> <input type="checkbox" id="check" checked="checked" style="float: right; margin-top: 4px;"></li>--%>

<%--            <li>--%>
<%--                <input type="button" class="login_button" onclick="onLogin()" id="btn" value="登&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;录"></input>--%>
<%--            </li>--%>
<%--            <div class="alert alert-error"--%>
<%--                 style="width:338px;display:none;">你输入的密码和账户名不匹配</div>--%>
<%--        </ul>--%>
<%--    </div>--%>
    <div class="bg" style="background: red">
        <div class="login">
            <div class="login_box">
                <div  class="logintit">用户登录</div>
                <div class="user"><input id="u" name="u" type="text" placeholder="请输入您的用户名" /></div>
                <div class="key"><input id="p" name="p" type="password" placeholder="请输入您的用密码" /></div>
                <div class="jzmm"><span>记住密码</span><input name="" type="checkbox" id="check" checked="checked"/></div>
<%--                <div class="but" onclick="onLogin()" ><button class="login_button" id="btn1"></button></div>--%>
                <input style="font-size: 30px" type="button" class="but" class="login_button" onclick="onLogin()" id="btn" value="登&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;录"></input>
                <div class="alert alert-error" style="width:338px;display:none;">你输入的密码和账户名不匹配</div>
            </div>
        </div>
    </div>

</form>


</body>
</html>
