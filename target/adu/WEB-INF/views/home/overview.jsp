<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<title>${WorkplateTitle}</title>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8">

<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	//String basePath = path + "/";
	
%>
<base id="basePath" href="<%=basePath%>">
<script type="text/javascript">
    var _BasePath = "<%=basePath%>";
</script>
<script type="text/javascript" charset="utf-8"
	src="jslib/jquery-1.12.4.min.js"></script>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
<meta http-equiv="X-FRAME-OPTIONS" content="DENY">
<meta http-equiv="X-Content-Type-Options" content="nosniff">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="shortcut icon" href="<%=basePath%>images/favicon.ico">
<!--[if lt IE 9]>
      <script src="//cdn.bootcss.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="//cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
<link href="css/master.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="jslib/jquery.min.js"></script>
	<script type="text/javascript" src="jslib/koala.min.1.5.js"></script>
	<script type="text/javascript">
		function printme() 
		{ 
			document.body.innerHTML=document.getElementById('print1').innerHTML+'<br/>'+document.getElementById('print2').innerHTML;
			window.print(); 
		} 
		$(function(){
			var ncs = $(".over_text_test");
			var i = 0;
			ncs.each(function(){
				if(i == 0){
					$(this).css("display","block");
					
				}
				i++;
			});
		})
		function show(id){
			var ncs = $(".over_text_test");
			
			ncs.each(function(){
				if(id == $(this).attr("id")){
					$(this).css("display","block");
				}else{
					$(this).css("display","none");
				}
			});
		}
	</script>
  </head>
</head>
<body>

	<div class="topbox">
		<div class="top_up">
			<div class="top_up_mid">
				<ul class="top_um_left">
					<li>欢迎进入${PortalTitle }！</li>
					<li><fmt:formatDate
								value="${NowTime }" type="date" dateStyle="full" /></li>
				</ul>
				<ul class="top_um_right">
					<li><a href="home/login">用户登陆</a></li>
					<li>丨</li>
					<li><a href="home/register">用户注册</a></li>
				</ul>
			</div>
		</div>
		<div class="top_up_mid">
			<div class="top_mid_mid">
				<div class="toplogobox">
					<div class="top_logo"></div>
					<div class="top_serbox">
						<input type="text" class="top_ser" /> <input type="button"
							class="top_ser_but" />
					</div>
				</div>
				<div class="navbox">
					<ul>
						<li><a href="/" class="nav_icon">首页</a></li>
						<li><a href="home/overview" class="nav_icon1">邯郸概况</a></li>
						<li><a href="home/talent" class="nav_icon2">人才资源</a></li>
						<li><a href="home/zwgk" class="nav_icon3">政务公开</a></li>
						<li><a href="home/hall" class="nav_icon4">办事大厅</a></li>
						<li><a href="home/job" class="nav_icon5">求职招聘</a></li>
					</ul>
				</div>
			</div>
		</div>
	</div>
	
<!--内容-->
<div class="textbox1"> 
 	<div class="overview_tit">
    	<div class="over_tit_left"><img src="images/icon7.gif" width="5" height="22" /><span>邯郸概况</span></div>
        <div class=" over_tit_right">当前位置：<a href="/">首页</a>-<a href="home/overview">邯郸概况</a></div>
    </div>
    <div class="over_img"></div>
    <div class="over_text">
    	<ul class="over_text_tit">
    		<c:forEach items="${NewsList}" var="news">
    			<li>
					<a href="javascript:show(${news.id})">
						${news.title }
					</a>
				</li>
			</c:forEach>
        </ul>
        <c:forEach items="${NewsList}" var="news">
    		<div style="display:none;" id="${news.id}" class="over_text_test">
				${news.content }
			</div>
		</c:forEach>
    </div>

</div>

<div class="bot">
  <div class="bot_mid"> 
  <div class="bot_test">
  </div>
    <div class="bot_test1">${Copyright } 版权所有Copyright 2013-2016 rcsd.cn All rights reserved<br /> 
冀 ICP 证 00000000 号 </div>
  </div>
  
</div>

</body>
</html>
