<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>打印模板--列表</title>
<jsp:include page="/WEB-INF/views/include/head4.jsp" />
<script>
	//装载表格
	function loadGrid() {
		var opts = {
			url : "workflow/printTemp/list",
			height : document.body.clientHeight - 130,
			rownumbers : true,
			colModel : [
					{
						label : '打印类型',
						name : 'type',
						index : 'type',
						width : 60
					},
					{
						label : '类别',
						name : 'category',
						index : 'category',
						width : 80
					},
					{
						label : '标题',
						name : 'title',
						index : 'title',
						width : 320
					},
					{
						label : '代号',
						name : 'sym',
						index : 'sym',
						width : 130
					},
					{
						label : '状态',
						name : 'isActive',
						index : 'isActive',
						width : 50,
						formatter : function(value, options, row) {
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
						formatter : function(value, options, row) {
							var btn = "";
							btn += '&nbsp;<a href="javascript:onSave(' + value
									+ ')" title="">编辑</a>'
							btn += '&nbsp;<a href="javascript:onSort(' + value
									+ ',\'up\')" title="">上移</a>'
							btn += '&nbsp;<a href="javascript:onSort(' + value
									+ ',\'down\')" title="">下移</a>'
							btn += '&nbsp;<a href="javascript:onDel(' + value
									+ ')" title="">删除</a>&nbsp;'
							return btn;
						}
					} ],
			rowNum : 100,
			rowList : [ 100, 200, 300 ],
			pager : '#pager',
			sortname : 'lineNo',
			sortorder : "asc",
			gridComplete : function() {
			}
		}
		$("#grid").jqGrid(opts);
	}
	//保存
	function onSave(id) {
		id = id || 0;
		document.location.href = 'workflow/printTemp/edit?id=' + id;
	}
	//添加完成后执行方法
	function onSaveOk(entity) {
		$("#grid").trigger("reloadGrid");
		layer.closeAll();
	}
	//删除
	function onDel(id) {
		layer.confirm('确定要删除人员？', {
			btn : [ '确定', '取消' ]
		//按钮
		}, function() {
			$.post("workflow/printTemp/del", {
				id : id
			}, function() {
				$("#grid").trigger("reloadGrid");
			});
			layer.closeAll();
		});
	}
	//排序
	function onSort(id, order) {
		$.post("workflow/printTemp/sort", {
			id : id,
			order : order
		}, function(result) {
			$("#grid").trigger("reloadGrid");
		});
	}
	//查询
	function onQ(orgid) {
		var para = {
			baseOrgId : orgid,
			title : $("#title").val(),
			sym : $("#sym").val()
		};
		$("#grid").jqGrid("setGridParam", {
			page : 0,
			postData : para
		}).trigger("reloadGrid");
	}
	//显示全部
	function showAll() {
		$("#title").val("");
		$("#sym").val("")
		onQ(0);
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
			<div class="form-group">
				<label for="title">标题</label> <input class="form-control input-sm"
					id="title" value="" type="text" />
			</div>
			<div class="form-group">
				<label for="sym">代号</label> <input class="form-control input-sm"
					id="sym" value="" type="text" />
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
					onclick="onSave()">添加</button>
			</div>
			<ol class="breadcrumb">
				<li><a href="home/dashboard"><i class="fa fa-dashboard"></i>
						首页</a></li>
				<li class="active">打印模板</li>
			</ol>
		</div>
		<table id="grid"></table>
		<div id="pager" style="height:35px;"></div>
	</div>
</body>
</html>