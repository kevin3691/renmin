<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>留言板 - 列表</title>
<jsp:include page="/WEB-INF/views/include/head.jsp" />
<script>
	//装载表格
	function loadGrid() {
		$("#grid")
				.jqGrid(
						{
							url : "cms/gustBook/list?stts=0",
							height : document.body.clientHeight - 130,
							rownumbers : true,
							colModel : [
									{
										label : '标题',
										name : 'title',
										index : 'title',
										width : 100
									},
									{
										label : '留言人名称',
										name : 'name',
										index : 'name',
										width : 100
									},
									{
										label : '留言时间',
										name : 'messageAt',
										index : 'messageAt',
										width : 100,
										formatter : function (v) {
						                    return jsonDateTimeFormatter (v, 1)
					                    }
									},
									{
										label : '是否公开',
										name : 'display',
										index : 'display',
										width : 50,
										formatter : function(value, options,
												row) {
											return value == 1 ? '是'
													: '<span style="color:gray;">否</span>'
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
											btn += '&nbsp;<a href="javascript:onDisplay('
													+ value
													+ ')" title="">公开</a>'
											btn += '&nbsp;<a href="javascript:onCDisplay('
													+ value
													+ ')" title="">停用</a>'
											btn += '&nbsp;<a href="javascript:onReply('
													+ value
													+ ')" title="">回复</a>'
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

	//执行回复方法
	function onReply(id) {
		layer.open({
			type : 2,
			title : "回复",
			shadeClose : true,
			shade : 0.8,
			area : [ '80%', '80%'],
			content : _BasePath + 'cms/gustBook/edit?id=' + id //iframe的url
		});
	}
	//执行查看方法
	function onDtl(id) {
		layer.open({
			type : 2,
			title : "查看",
			shadeClose : true,
			shade : 0.8,
			area : [  '80%', '80%' ],
			content : _BasePath + 'cms/gustBook/dtl?id=' + id //iframe的url
		});
	}

	//删除方法
	function onDel(id) {
		layer.confirm('确定要删除该留言？', {
			btn : [ '确定', '取消' ]
		//按钮
		}, function() {
			$.post("cms/gustBook/del", {
				id : id
			}, function() {
				$("#grid").trigger("reloadGrid");
			});
			layer.closeAll();
		});
	}

	//公开
	function onDisplay(id, Display) {
		layer.confirm('确定要公开该留言？', {
			btn : [ '确定', '取消' ]
		//按钮
		}, function() {
			$.post("cms/gustBook/updateDisplay", {
				id : id,
				display : 1
			}, function(result) {
				$("#grid").trigger("reloadGrid");
			});
			layer.closeAll();
		});
	}

	//停用
	function onCDisplay(id, isDisplay) {
		layer.confirm('确定要停用该留言？', {
			btn : [ '确定', '取消' ]
		//按钮
		}, function() {
			$.post("cms/gustBook/updateDisplay", {
				id : id,
				display : 0
			}, function(result) {
				$("#grid").trigger("reloadGrid");
			});
			layer.closeAll();
		});
	}

	//查询
	function onQ(id) {
		var para = {
			id : id,
			title : $("#title").val(),
			name : $("#name").val(),
			stts:0
		};
		$("#grid").jqGrid("setGridParam", {
			postData : para
		}).trigger("reloadGrid");
	}

	//显示全部
	function showAll() {
		$("#title").val("");
		$("#name").val("");
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
				<label for="title">标题</label> <input class="form-control input-sm"
					id="title" value="" type="text" />
				<label for="name">留言人名称</label> <input class="form-control input-sm"
					id="name" value="" type="text" />
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
