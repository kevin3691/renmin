<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>表单--列表</title>
<jsp:include page="/WEB-INF/views/include/head.jsp" />
<script>
	//装载表格
	function loadGrid() {
		$("#grid")
				.jqGrid(
						{
							url : "comm/form/list",
							height : document.body.clientHeight - 130,
							rownumbers : true,
							colModel : [
									{
										label : '名称',
										name : 'name',
										index : 'name',
										width : 260
									},
									{
										label : '状态',
										name : 'isActive',
										index : 'isActive',
										sortable : false,
										width : 60,
										formatter : function(value, options,
												row) {
											return value == 1 ? '使用中'
													: '<span style="color:gray;">已停用</span>'
										}
									},
									{
										label : ' ',
										name : 'id',
										width : 100,
										align : 'center',
										sortable : false,
										formatter : function(value, options,
												row) {
											var btn = "";
											btn += '&nbsp;<a href="javascript:onSave('
													+ value
													+ ')" title="">编辑</a>'
											btn += '&nbsp;<a href="javascript:onFormFiled('
											+ value + ',\'' + row.name
											+ '\')" title="">表单属性</a>'
											btn += '&nbsp;<a href="javascript:onDel('
													+ value
													+ ')" title="">删除</a>';
											return btn;
										}
									} ],
							rowNum : 20,
							rowList : [ 20, 50, 100 ],
							pager : '#pager'

						});
	}

	//编辑
	function onSave(id, parentid) {
		id = id || 0;
		parentid = parentid || 0;
		var title = "添加表单"
		if (id > 0) {
			title = "编辑表单"
		}
		layer.open({
			type : 2,
			title : title,
			shadeClose : true,
			shade : 0.8,
			area : [ '70%', '350' ],
			content : 'comm/form/edit?id=' + id
		});
	}

	//表单属性
	function onFormFiled(id, name) {
		id = id || 0;
		var title = "表单属性";
		layer.open({
			type : 2,
			title : title,
			shadeClose : true,
			shade : 0.8,
			area : [ '90%', '90%' ],
			content : 'comm/formFiled/index?id=' + id + '&commFormName='
					+ encodeURI(name) + '&commFormId='+id
		});
	}

	//编辑完成回调函数
	function onSaveOk() {
		layer.closeAll();
		$("#grid").trigger("reloadGrid");
	}

	//删除
	function onDel(id) {
		layer.confirm('确定要删除该记录？', {
			btn : [ '确定', '取消' ]
		//按钮
		}, function() {
			$.post("comm/form/del", {
				id : id
			}, function() {
				$("#grid").trigger("reloadGrid");
			});
			layer.closeAll();
		});
	}

	//查询
	function onQ() {
		var para = {
			title : $("#title").val(),
			sym : $("#sym").val()
		};
		$("#grid").jqGrid("setGridParam", {
			postData : para
		}).trigger("reloadGrid");
	}

	//显示全部
	function showAll() {
		$("#name").val("");
		onQ();
	}

	$(function() {
		loadGrid();
	});
</script>
</head>

<body>
	<div class="container-fluid">
		<div class="breadcrumb content-header form-inline"
			style="padding:8px;">
			<div class="form-group">
				<label for="name">标题</label> <input class="form-control input-sm"
					id="name" value="" type="text" />
			</div>
			<div class="form-group">
				<button class="btn btn-info" id="btnAdd" type="button"
					onclick="onQ()">查询</button>
			</div>
			<div class="form-group">
				<button class="btn btn-info" id="btnShowAll" type="button"
					onclick="showAll()">显示全部</button>
				&nbsp;&nbsp;
				<button class="btn btn-info" id="btnAdd" type="button"
					onclick="onSave()">添加表单</button>
			</div>
			<ol class="breadcrumb">
				<li><a href="home/dashboard"><i class="fa fa-dashboard"></i>
						首页</a></li>
				<li class="active">表单管理</li>
			</ol>
		</div>
		<table id="grid"></table>
		<div id="pager" style="height:35px;"></div>
	</div>
</body>
</html>