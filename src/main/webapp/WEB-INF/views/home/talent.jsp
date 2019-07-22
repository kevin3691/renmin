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
			
		})
		
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

    <div class="Talent"><img src="images/tit.gif" width="143" height="41" /><a href="#">人才掠影</a><a href="#">人才风采</a><a href="#">人才视窗</a></div>
  <div class="Talent_box">
  	<div class="Talent_left">
  		<div class="Tshadow">
        	<div class="Tshadow_tit"><span>人才掠影</span></div>
            <ul>
	            <c:forEach items="${rclyList}" var="news">
	    			<li>
						<a href="home/info?id=${news.id }">
							<c:if test="${fn:length(news.title)>15}">
							  	${fn:substring(news.title,0,14)}...
							</c:if> 
							<c:if test="${fn:length(news.title)<=15}">
							  	${news.title }
							</c:if>
						</a>
					</li>
				</c:forEach>
            </ul>
        </div>
        <div class=" TWindows">
        	<div class="Tshadow_tit"><span>人才视窗</span></div>
            <div class="TWindows_img">
            	<c:forEach items="${rcscList}" var="news">
	    			<li>
						<a href="home/info?id=${news.id }">
							<c:if test="${fn:length(news.title)>15}">
							  	${fn:substring(news.title,0,14)}...
							</c:if> 
							<c:if test="${fn:length(news.title)<=15}">
							  	${news.title }
							</c:if>
						</a>
					</li>
				</c:forEach>
            	<div><a href="#"><img src="images/img2.gif" width="325" height="181" /></a><p>人才改革试验区建设试点工作实施方案》获省批复</p></div>
                <div><a href="#"><img src="images/img2.gif" width="325" height="181" /></a><p>人才改革试验区建设试点工作实施方案》获省批复</p></div>
          </div>
        </div>
  	</div>
    <div class=" Talent_right">
   	  <div class="Tgraceful">
       	<div class="Tshadow_tit"><span>人才风采</span></div>
          <ul>
          		<c:forEach items="${rcfcList}" var="person">
	    			<li>
						<a href="base/person/dtl?id=${person.id }" class=" Tgraceful_img">
							<img src="${person.photo }" width="80" height="103" />
						</a>
						<a href="base/person/dtl?id=${person.id }" class="Tgraceful_text">
							<h2>${person.name }</h2>
							${person.descr }
						</a>
					</li>
				</c:forEach>
           	 
          </ul>
        </div>
    </div>
 
  
    
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
