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
<title>页面找不到</title>
<jsp:include page="/WEB-INF/views/include/ltehead.jsp" />
</head>

<body style="background-color: #ecf0f5;">
	<section class="content">
	<div class="error-page">
		<h2 class="headline text-yellow">404</h2>
		<div class="error-content">
			<h3>
				<i class="fa fa-warning text-yellow"></i> 你所访问的页面找不到！
			</h3>
			<p>
				你所访问的页面找不到！请点击 <a href="home/workplate">回到首页</a> 或 <a
					href="javascript:history.go(-1)">返回上页</a>
			</p>
			<form class="search-form" style="display:none;">
				<div class="input-group">
					<input type="text" name="search" class="form-control"
						placeholder="查询"> <span class="input-group-btn">
						<button class="btn btn-info btn-flat" type="button"
							onclick="onSearch()">
							<i class="fa fa-search"></i>查询
						</button>
					</span>
				</div>
				<!-- /.input-group -->
			</form>
		</div>
		<!-- /.error-content -->
	</div>
	</section>
</body>
</html>
