<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>表单属性--列表</title>
<jsp:include page="/WEB-INF/views/include/head.jsp" />
<script>
	//装载表格
	function loadGrid() {
		$("#grid").jqGrid(
				{
					url : "comm/formFiled/list?commFormName="
							+ encodeURI("${commFormName}")
							+ "&commFormId=${commFormId}",
					height : document.body.clientHeight - 130,
					rownumbers : true,
					colModel : [
							{
								label : '显示标题',
								name : 'title',
								index : 'title',
								width : 130
							},
							{
								label : '属性名称',
								name : 'name',
								index : 'name',
								width : 130
							},
							{
								label : '类型',
								name : 'dataType',
								index : 'dataType',
								width : 130
							},
							{
								label : ' ',
								name : 'id',
								width : 100,
								align : 'center',
								sortable : false,
								formatter : function(value, options, row) {
									var btn = "";
									btn += '&nbsp;<a href="javascript:onSave('
											+ value + ')" title="">编辑</a>'
									btn += '&nbsp;<a href="javascript:onSort('
											+ value
											+ ',\'up\')" title="">上移</a>'
									btn += '&nbsp;<a href="javascript:onSort('
											+ value
											+ ',\'down\')" title="">下移</a>'
									btn += '&nbsp;<a href="javascript:onDel('
											+ value + ')" title="">删除</a>';
									return btn;
								}
							} ],
					rowNum : 20,
					rowList : [ 20, 50, 100 ],
					pager : '#pager',
					sortname : 'lineNo',
					sortorder : "asc"
				});
	}

	//编辑
	function onSave(id, parentid) {
		id = id || 0;
		parentid = parentid || 0;
		var title = "添加表单属性";
		if (id > 0) {
			title = "编辑表单属性";
		}
		layer.open({
			type : 2,
			title : title,
			shadeClose : true,
			shade : 0.8,
			area : [ '90%', '90%' ],
			content : 'comm/formFiled/edit?id=' + id + '&commFormName='
					+ encodeURI("${commFormName}")
					+ '&commFormId=${commFormId}'
		});
	}

	//排序
	function onSort(id, order) {	
		$.post("comm/commFiled/sort", {
			id : id,
			order : order
		}, function() {
			$("#grid").trigger("reloadGrid");
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
			$.post("comm/formFiled/del", {
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
				<label for="title">显示标题</label> <input class="form-control input-sm"
					id="title" value="" type="text" />
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
					onclick="onSave()">添加属性</button>
			</div>
		</div>
		<table id="grid"></table>
		<div id="pager" style="height:35px;"></div>
	</div>
</body>
</html>