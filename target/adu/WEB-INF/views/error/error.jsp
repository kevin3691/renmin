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
<title>未授权</title>
<jsp:include page="/WEB-INF/views/include/ltehead.jsp" />
</head>

<body>
	<!-- Main content -->
	<div class="content">
		<section class="content">
		<div class="error-page">
			<div>
				<h2 class="headline text-red">
					<i class="fa fa-warning text-red"></i>请求参数错误！
				</h2>
				<br />
				<h4 style="line-height:150%;">
					对不起，请求参数错误。请点击 <a
					href="javascript:history.go(-1)">返回</a>
				</h4>
				<h4></h4>
				<form class="search-form" style="display:none;">
					<div class="input-group">
						<input type="text" name="search" class="form-control"
							placeholder="查询">
						<div class="input-group-btn">
							<button type="submit" name="submit"
								class="btn btn-danger btn-flat">
								<i class="fa fa-search"></i>
							</button>
						</div>
					</div>
					<!-- /.input-group -->
				</form>

			</div>
		</div>
		</section>
	</div>
	<!-- /.content -->
	<!-- /.content-wrapper -->
</body>
</html>
