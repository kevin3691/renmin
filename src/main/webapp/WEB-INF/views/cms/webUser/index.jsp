<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>外网用户 - 列表</title>
<jsp:include page="/WEB-INF/views/include/head.jsp" />
<script>
	//装载表格
	function loadGrid() {
		$("#grid")
				.jqGrid(
						{
							url : "cms/webUser/list",
							height : document.body.clientHeight - 130,
							rownumbers : true,
							colModel : [
									{
										label : '用户名',
										name : 'userName',
										index : 'userName',
										width : 100
									},
									{
										label : '手机号码',
										name : 'mobile',
										index : 'mobile',
										width : 100
									},
									{
										label : '邮箱地址',
										name : 'email',
										index : 'email',
										width : 70
									},
									{
										label : '性别',
										name : 'gender',
										index : 'gender',
										width : 70
									},
									{
										label : '是否启用',
										name : 'isActive',
										index : 'isActive',
										width : 50,
										formatter : function(value, options,
												row) {
											return value == 1 ? '使用中'
													: '<span style="color:gray;">已停用</span>'
										}
									},
									{
										label : ' ',
										name : 'id',
										align : 'center',
										sortable : false,
										formatter : function(value, options,
												row) {
											var btn = "";
											btn += '&nbsp;<a href="javascript:onActive('
													+ value
													+ ')" title="">启用</a>'
											btn += '&nbsp;<a href="javascript:onCActive('
													+ value
													+ ')" title="">停用</a>'
											btn += '&nbsp;<a href="javascript:onDtl('
													+ value
													+ ')" title="">查看</a>'

											return btn;
										}
									} ],
							rowNum : 20,
							rowList : [ 20, 50, 100 ],
							pager : '#pager',
							sortname : 'id',
							sortorder : "desc"
						});
	}

	
	//执行查看方法
	function onDtl(id) {
		layer.open ({
	        type : 2,
	        title : "查看",
	        shadeClose : true,
	        shade : 0.8,
	        area : [
	                '800', '410'
	        ],
	        content : _BasePath + 'cms/webUser/dtl?id=' + id //iframe的url
	    });
	}

	//删除方法
	function onDel(id) {
		layer.confirm('确定要删除该用户？', {
			btn : [ '确定', '取消' ]
		//按钮
		}, function() {
			$.post("cms/webUser/del", {
				id : id
			}, function() {
				$("#grid").trigger("reloadGrid");
			});
			layer.closeAll();
		});
	}
	

	//查询
	function onQ(id) {
		var para = {
			id : id,
			userName : $("#userName").val(),
			gender : $("#gender").val()
		};
		$("#grid").jqGrid("setGridParam", {
			postData : para
		}).trigger("reloadGrid");
	}
	//启用方法
	function onActive(id, isActive) {
		layer.confirm('确定要启用该用户？', {
			btn : [ '确定', '取消' ]
		//按钮
		}, function() {
			$.post("cms/webUser/updateActive", {
				id : id,
				isActive : 1
			}, function(result) {
				$("#grid").trigger("reloadGrid");
			});
			layer.closeAll();
		});
	}

	//停用
	function onCActive(id, isActive) {
		layer.confirm('确定要停用该用户？', {
			btn : [ '确定', '取消' ]
		//按钮
		}, function() {
			$.post("cms/webUser/updateActive", {
				id : id,
				isActive : 0
			}, function(result) {
				$("#grid").trigger("reloadGrid");
			});
			layer.closeAll();
		});
	}
	//显示全部
	function showAll() {
		$("#userName").val("");
		$("#gender").val("");
		onQ(0);
	}

	//初始化
	$(function() {
		loadGrid();
	});
</script>

</head>

<body>
	<div class="container-fluid">
		<div class="breadcrumb content-header form-inline"
			style="padding: 8px;">
			<div class="form-group">
				<label for="userName">用户名</label> <input
					class="form-control input-sm" id="userName" value="" type="text" />
				<label for="gender">性别</label> <input
					class="form-control input-sm" id="gender" value="" type="text" />
			</div>

			<div class="form-group">
				<button class="btn btn-info" id="btnAdd" type="button"
					onclick="onQ()">查询</button>
			</div>
			<div class="form-group">
				<button class="btn btn-info" id="btnShowAll" type="button"
					onclick="showAll()">显示全部</button>
			</div>

			<ol class="pull-right breadcrumb">
				<li><a href="home/dashboard"><i class="fa fa-dashboard"></i>
						首页</a></li>
				<li class="active">${colTitle}</li>
			</ol>
		</div>
		<table id="grid"></table>
		<div id="pager" style="height: 35px;"></div>
	</div>
</body>
</html>
