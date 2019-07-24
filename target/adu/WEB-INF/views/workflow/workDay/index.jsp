<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>工作日--列表</title>
<jsp:include page="/WEB-INF/views/include/head.jsp" />
<script>
	//装载表格
	function loadGrid() {
		var opts = {
			url : "workflow/workDay/list",
			height : document.body.clientHeight - 130,
			rownumbers : true,
			colModel : [
					{
						label : '日期',
						name : 'wfDate',
						index : 'wfDate',
						width : 130,
						formatter : function(value, options, row) {
							return jsonDateTimeFormatter(value);
						}
					},
					{
						label : '星期几',
						name : 'weekDay',
						index : 'weekDay',
						width : 130
					},
					{
						label : '是否班',
						name : 'ifClass',
						index : 'ifClass',
						width : 70,
						formatter : function(value, options, row) {
							return value == 1 ? '是'
									: '<span style="color:gray;">否</span>'
						}
					},
					{
						label : '备注',
						name : 'descr',
						index : 'descr',
						width : 130
					},
					{
						label : ' ',
						name : 'id',
						width : 70,
						align : 'center',
						sortable : false,
						formatter : function(value, options, row) {
							var btn = "";
							btn += '&nbsp;<a href="javascript:onSave(' + value
									+ ')" title="">编辑</a>'
							btn += '&nbsp;<a href="javascript:onDel(' + value
									+ ')" title="">删除</a>&nbsp;'
							return btn;
						}
					} ],
			rowNum : 100,
			rowList : [ 100, 200, 300 ],
			pager : '#pager',
			sortname : 'id',
			sortorder : "asc",
			gridComplete : function() {
			}
		}
		$("#grid").jqGrid(opts);
	}

	//编辑
	function onSave(id) {
		id = id || 0;
		var title = "添加";
		if (id > 0) {
			title = "编辑";
		}
		layer.open({
			type : 2,
			title : title,
			shadeClose : true,
			shade : 0.8,
			area : [ '800', '360' ],
			content : 'workflow/workDay/edit?id=' + id
		});
	}

	//添加完成后执行方法
	function onSaveOk() {
		$("#grid").trigger("reloadGrid");
		layer.closeAll();
	}

	//删除
	function onDel(id) {
		layer.confirm('确定要删除该记录？', {
			btn : [ '确定', '取消' ]
		//按钮
		}, function() {
			$.post("workflow/workDay/del", {
				id : id
			}, function() {
				$("#grid").trigger("reloadGrid");
			});
			layer.closeAll();
		});
	}

	//窗口变化时自适应宽度
	window.onresize = function() {
		$("#grid").setGridWidth(document.body.clientWidth - 12);
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
			<button class="btn btn-info" id="btnAdd" type="button"
				onclick="onSave()">添加</button>
			<ol class="pull-right breadcrumb">
				<li><a href="home/dashboard"><i class="fa fa-dashboard"></i>
						首页</a></li>
				<li class="active">工作日期</li>
			</ol>
		</div>
		<div>
			<table id="grid"></table>
		</div>
		<div id="pager" style="height:35px;"></div>
	</div>
</body>
</html>