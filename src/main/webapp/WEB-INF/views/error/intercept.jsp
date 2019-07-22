<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">
<title>非法请求</title>
<jsp:include page="/WEB-INF/views/include/ltehead.jsp" />
</head>

<body>
	<!-- Main content -->
	<div class="content">
		<section class="content">
		<div class="error-page">
			<h2 class="headline text-red">500</h2>
			<div class="error-content">
				<h3>
					<i class="fa fa-warning text-red"></i>服务器监测到一个非法请求。
				</h3>
				<form class="search-form">
					<div class="input-group">
						
					</div>
					<!-- /.input-group -->
				</form>
				<br />
				<H4>
					
				</H4>
			</div>
		</div>
		</section>
	</div>
	<!-- /.content -->
	<!-- /.content-wrapper -->
</body>
</html>
