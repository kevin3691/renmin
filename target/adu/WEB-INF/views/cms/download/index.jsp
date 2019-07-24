<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>文件下载 - 列表</title>
<jsp:include page="/WEB-INF/views/include/head.jsp" />
<script>
	//装载表格
	function loadGrid() {
		$("#grid").jqGrid(
				{
					url : "cms/news/list?colSym=${colSym}",
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
								label : '文件路径',
								name : 'url',
								index : 'url',
								width : 130
							},
							{
								label : '发布时间',
								name : 'publishAt',
								index : 'publishAt',
								width : 50,
								formatter : function(v) {
									return jsonDateTimeFormatter(v, 1)
								}
							},
							{
								label : '发布人',
								name : 'recordInfo.createdByName',
								index : 'recordInfo.createdByName',
								width : 50
							},
							{
								label : ' ',
								name : 'id',
								width : 50,
								align : 'center',
								sortable : false,
								formatter : function(value, options, row) {
									var btn = "";
									btn += '&nbsp;<a href="javascript:onSave('
											+ value + ')" title="">编辑</a>'
									btn += '&nbsp;<a href="javascript:onDel('
											+ value + ')" title="">删除</a>'
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

	//执行添加方法
	function onSave(id) {
		id = id || 0;
		document.location = _BasePath + 'cms/download/edit?id=' + id
				+ "&colSym=${colSym}&colTitle=" + encodeURI("${colTitle}");
	}

	//删除方法
	function onDel(id) {
		layer.confirm('确定要删除该记录？', {
			btn : [ '确定', '取消' ]
		//按钮
		}, function() {
			$.post("cms/news/del", {
				id : id
			}, function() {
				$("#grid").trigger("reloadGrid");
			});
			layer.closeAll();
		});
	}

	//添加成功后执行的方法
	function onSaveOk(entity) {
		$("#grid").trigger("reloadGrid");
		layer.closeAll();
	}

	//查询
	function onQ(id) {
		var stts = $("input[name='stts']:checked").val();
		var para = {
			id : id,
			title : $("#title").val(),
			source : $("#source").val(),
			stts : stts
		};
		$("#grid").jqGrid("setGridParam", {
			postData : para
		}).trigger("reloadGrid");
	}

	//显示全部
	function showAll() {
		$("#title").val("");
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
			style="padding:8px;">
			<div class="form-group">
				<label for="title">标题</label> <input class="form-control input-sm"
					id="title" value="" type="text" />
			</div>
			<div class="form-group">
				<button class="btn btn-info" id="btnAdd" type="button"
					onclick="onQ()">查询</button>
			</div>
			<div class="form-group">
				<button class="btn btn-info" id="btnShowAll" type="button"
					onclick="showAll()">显示全部</button>
			</div>
			<div class="form-group">
				<button class="btn btn-info" id="btnShowAll" type="button"
					onclick="onSave()">添加</button>
			</div>
			<ol class="pull-right breadcrumb">
				<li><a href="home/dashboard"><i class="fa fa-dashboard"></i>
						首页</a></li>
				<li class="active">${colTitle}</li>
			</ol>
		</div>
		<table id="grid"></table>
		<div id="pager" style="height:35px;"></div>
	</div>
</body>
</html>