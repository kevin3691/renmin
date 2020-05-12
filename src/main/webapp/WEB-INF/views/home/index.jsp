<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib
	uri="http://www.owasp.org/index.php/Category:OWASP_CSRFGuard_Project/Owasp.CsrfGuard.tld"
	prefix="csrf"%>
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
</head>
<body oncontextmenu=self.event.returnValue=false>
	<script type="text/javascript">
		if (window.location.href != top.location.href){
	        top.location.href = window.location.href;
        }
        
        $ (function () {
	        
        });
        function refreshWin(){
        	window.location.reload(); 
        }
	</script>

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
	<div class="textbox">
		<!--头条-->
		<div class="headline">
			<h1>
				<c:if test="${fn:length(TopNews.title)>32}">
				  	${fn:substring(TopNews.title,0,32)}...
				 </c:if> 
				 <c:if test="${fn:length(TopNews.title)<=32}">
				  	 ${TopNews.title }
				 </c:if>
			</h1>
			<div class="headline_text">
				<c:if test="${fn:length(TopNews.content)>67}">
				  	${fn:substring(TopNews.content,0,66)}...
				 </c:if> 
				 <c:if test="${fn:length(TopNews.content)<=67}">
				  	 ${TopNews.content }
				 </c:if>
			</div>
		</div>
		<!--图片轮播-->
		<div id="picbox">
			<div style="width:1117px; position:absolute; margin-top:468px; z-index:10000;">
				<ul class="page">
					<c:forEach items="${PicNews}" var="news">
					<li>
						<a class="picbottom" href="home/info?id=${news.id }" target="_blank">
							<c:if test="${fn:length(news.title)>32}">
							  	${fn:substring(news.title,0,32)}...
							</c:if> 
							<c:if test="${fn:length(news.title)<=32}">
							  	${news.title }
							</c:if>
						</a>
					</li>
					</c:forEach>
					
				</ul>
				<!-- <ul class="page">
					<li></li>
					<li></li>
					<li></li>
					<li></li>
					<li></li>
				</ul>
				 -->
				
				
			</div>
			<ul class="pic">
					<c:forEach items="${PicNews}" var="news">
						<li>
							<img src="${news.img }" width="1117" height="373" />
						</li>
					</c:forEach>
				</ul>
		</div>
		<script type="text/javascript" src="jslib/pictureswitch.js"></script>
		<!--通知-->
		<div class="inform">
			<ul>
				<c:forEach var="i" begin="0" end="2" step="1">
					<c:choose>
						<c:when test="${NewsList.size() > i }">
							<li>
								<a href="/home/info?id=${NewsList.get(i).id }" target="_blank">
									<c:if test="${fn:length(NewsList.get(i).title)>12}">
									  	${fn:substring(NewsList.get(i).title,0,11)}...
									</c:if> 
									<c:if test="${fn:length(NewsList.get(i).title)<=12}">
									  	${NewsList.get(i).title }
									</c:if>
								</a>
							</li>
						</c:when>
						<c:otherwise>
							
						</c:otherwise>
					</c:choose>
				</c:forEach>
			</ul>
			<ul>
				<c:forEach var="i" begin="3" end="5" step="1">
					<c:choose>
						<c:when test="${NewsList.size() > i }">
							<li>
								<a href="/home/info?id=${NewsList.get(i).id }" target="_blank">
									<c:if test="${fn:length(NewsList.get(i).title)>12}">
									  	${fn:substring(NewsList.get(i).title,0,11)}...
									</c:if> 
									<c:if test="${fn:length(NewsList.get(i).title)<=12}">
									  	${NewsList.get(i).title }
									</c:if>
								</a>
							</li>
						</c:when>
						<c:otherwise>
							
						</c:otherwise>
					</c:choose>
				</c:forEach>
			</ul>
			<ul>
				<c:forEach var="i" begin="6" end="8" step="1">
					<c:choose>
						<c:when test="${NewsList.size() > i }">
							<li>
								<a href="/home/info?id=${news.id }" target="_blank">
									<c:if test="${fn:length(NewsList.get(i).title)>12}">
									  	${fn:substring(NewsList.get(i).title,0,11)}...
									</c:if> 
									<c:if test="${fn:length(NewsList.get(i).title)<=12}">
									  	${NewsList.get(i).title }
									</c:if>
								</a>
							</li>
						</c:when>
						<c:otherwise>
							
						</c:otherwise>
					</c:choose>
				</c:forEach>
			</ul>
			<ul style="background: none">
				<c:forEach var="i" begin="9" end="11" step="1">
					<c:choose>
						<c:when test="${NewsList.size() > i }">
							<li>
								<a href="/home/info?id=${NewsList.get(i).id }" target="_blank">
									<c:if test="${fn:length(NewsList.get(i).title)>12}">
									  	${fn:substring(NewsList.get(i).title,0,11)}...
									</c:if> 
									<c:if test="${fn:length(NewsList.get(i).title)<=12}">
									  	${NewsList.get(i).title }
									</c:if>
								</a>
							</li>
						</c:when>
						<c:otherwise>
							
						</c:otherwise>
					</c:choose>
				</c:forEach>
			</ul>
			
			<div class="inform_tit">更多通知</div>
		</div>
	</div>
	<!--征务大厅-->
	<div class="affairs">
		<div class="affairs_mid">
			<div class="affairs_tit">政务大厅</div>
			<div class="affairs_up">
				<h3>
					<c:if test="${fn:length(TopZwgk.title)>60}">
					  	${fn:substring(TopZwgk.title,0,59)}...
					 </c:if> 
					 <c:if test="${fn:length(TopZwgk.title)<=60}">
					  	 ${TopZwgk.title }
					 </c:if>
				</h3>
				<div class="affairs_up_test">
					<c:if test="${fn:length(TopZwgk.content)>240}">
					  	${fn:substring(TopZwgk.content,0,239)}...
					 </c:if> 
					 <c:if test="${fn:length(TopZwgk.content)<=240}">
					  	 ${TopZwgk.content }
					 </c:if>
				</div>
			</div>
			<div class="affairs_textbox">
				<div class="message">
					<div class="message_tit">
						<span>信息速递</span>
					</div>
					<div class="message_text">
						<ul>
							<c:forEach items="${XxsdList}" var="news">
								<li>
									<a href="home/info?id=${news.id }"  target="_blank">
										<c:if test="${fn:length(news.title)>22}">
										  	${fn:substring(news.title,0,21)}...
										</c:if> 
										<c:if test="${fn:length(news.title)<=22}">
										  	${news.title }
										</c:if>
									</a>
									<span>
										<fmt:formatDate value="${news.publishAt }" pattern="MM-dd" />
									</span>
								</li>
								
							</c:forEach>
							
						</ul>
					</div>
				</div>
				<div class="message" style="margin-left: 20px;">
					<div class="message_tit">
						<span>人才政策</span>
					</div>
					<div class="message_text">
						<ul>
							<c:forEach items="${RczcList}" var="news">
								<li>
									<a href="home/info?id=${news.id }"  target="_blank">
										<c:if test="${fn:length(news.title)>22}">
										  	${fn:substring(news.title,0,21)}...
										</c:if> 
										<c:if test="${fn:length(news.title)<=22}">
										  	${news.title }
										</c:if>
									</a>
									<span>
										<fmt:formatDate value="${news.publishAt }" pattern="MM-dd" />
									</span>
								</li>
								
							</c:forEach>
							
						</ul>
					</div>
				</div>
			</div>
			<div class="affairs_textbox">
				<div class="message">
					<div class="message_tit">
						<span>文件下载</span>
					</div>
					<div class="message_text">
						<ul>
							<c:forEach items="${WjxzList}" var="news">
								<li>
									<a href="home/info?id=${news.id }"  target="_blank">
										<c:if test="${fn:length(news.title)>22}">
										  	${fn:substring(news.title,0,21)}...
										</c:if> 
										<c:if test="${fn:length(news.title)<=22}">
										  	${news.title }
										</c:if>
									</a>
									<span>
										<fmt:formatDate value="${news.publishAt }" pattern="MM-dd" />
									</span>
								</li>
								
							</c:forEach>
							
						</ul>
					</div>
				</div>
				<div class="message" style="margin-left: 20px;">
					<div class="message_tit">
						<span>人才载体</span>
					</div>
					<div class="message_text">
						<ul>
							<c:forEach items="${RcztList}" var="news">
								<li>
									<a href="home/info?id=${news.id }"  target="_blank">
										<c:if test="${fn:length(news.title)>22}">
										  	${fn:substring(news.title,0,21)}...
										</c:if> 
										<c:if test="${fn:length(news.title)<=22}">
										  	${news.title }
										</c:if>
									</a>
									<span>
										<fmt:formatDate value="${news.publishAt }" pattern="MM-dd" />
									</span>
								</li>
								
							</c:forEach>
							
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="bot">
		<div class="bot_mid">
			<!-- <div class="bot_test">
				<a href="#">人才概况</a> 丨 <a href="#">机构设置</a> 丨 <a href="#">意见反馈</a> 丨
				<a href="#">新闻投稿</a> 丨 <a href="#">联系我们</a>
			</div> -->
			<div class="bot_test1">
				${Copyright } 版权所有Copyright 2018 All rights reserved<br />
				冀 ICP 证 00000000 号
			</div>
		</div>

	</div>


</body>
</html>
