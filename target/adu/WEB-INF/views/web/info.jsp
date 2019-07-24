<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	//String basePath = path + "/";
	
%>

<!DOCTYPE html>
<html lang="zh-CN">
  <head>
    <base href="<%=basePath%>">
    
    <title>${WorkplateTitle}</title>
    
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
<meta http-equiv="X-FRAME-OPTIONS" content="DENY">
<meta http-equiv="X-Content-Type-Options" content="nosniff">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="shortcut icon" href="<%=basePath%>images/favicon.ico">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<link href="css/master.css" rel="stylesheet" type="text/css">
	<link href="css/public.css" rel="stylesheet" type="text/css">
	<link href="css/index2.css" rel="stylesheet" type="text/css">
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
  
  <body>
 
<!--网站头部-->
<div class="top">
  <div class="logo"></div>
</div>

<div class="clear"></div>
<!--网站头部结束-->
<!--网站中部开始-->
<div class="w1226">
<div class="main">
<!--新闻列表开始-->
<div class="newBox">
    <div class="news_currA">
        <a class="On">当前位置&nbsp;>>&nbsp;</a>
        <a href="home/index">首页&nbsp;>>&nbsp;</a>
        <a href="web/listPage?colSym=${info.colSym }">${info.colTitle }&nbsp;>>&nbsp;</a>
        <a>详细信息</a>
     </div>
     <div class="news_ct01">
     	<!--详情页-->
	<div class="info_title" id="print1">
		<h1>${info.title }</h1>
		<ul>
			<li><%-- 【信息来源：${info.source }】 --%>【信息时间：<fmt:formatDate value="${info.recordInfo.createdAt }" pattern="yyyy-MM-dd"/>】<!-- 【字号&nbsp;<a>大</a>&nbsp;<a>中</a>&nbsp;<a>小</a>】 -->【<a onclick="javascrīpt:printme();">我要打印</a>】【<a style="color:#FF0000;" href="javascript:window.opener=null;window.open('','_self');window.close();">关闭</a>】</li>
		</ul>
	</div>
	<div class="info_cont01" id="print2">
		${info.content }
	</div>
     </div>
</div>

<!--新闻列表结束-->


<div class="clear"></div>
</div>
</div>
<!--网站中部结束-->
<!--网站底部开始-->
<!--网页底部开始-->
<div class="bot">中国人民银行</div>
<!--网站底部结束-->
</body>
</html>
