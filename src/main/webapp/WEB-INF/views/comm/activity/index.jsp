<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>活动--列表</title>
<jsp:include page="/WEB-INF/views/include/head.jsp" />
<script src="jslib/projwf.js"></script>
<script>
	var _STTS = "${stts}";
	var _APPLYTO = "${applyto}";
	var _REFNUM = "${refnum}";

	//装载表格
	function loadGrid() {
		$("#grid").jqGrid(
				{
					url : "comm/activity/list?applyto=" + _APPLYTO + "&refnum="
							+ _REFNUM,
					height : document.body.clientHeight - 130,
					fitColumns : true,
					rownumbers : true,
					colModel : [
							{
								label : '活动分类',
								name : 'category',
								index : 'category',
								sortable : false,
								width : 130
							},
							{
								label : '执行人姓名',
								name : 'actorName',
								index : 'actorName',
								sortable : false,
								width : 80
							},
							{
								label : '活动时间',
								name : 'actAt',
								index : 'actAt',
								sortable : false,
								width : 130,
								formatter : function(value, options, row) {
									return jsonDateTimeFormatter(value);
								}
							},
							{
								label : '联系人',
								name : 'contactPerson',
								index : 'contactPerson',
								sortable : false,
								width : 80
							},
							{
								label : '联系电话',
								name : 'contactPhone',
								index : 'contactPhone',
								sortable : false,
								width : 130
							},
							{
								label : ' ',
								name : 'id',
								width : 130,
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
					rowNum : 15,
					rowList : [ 15, 50, 100 ],
					pager : '#pager'
				});
	}

	//窗口变化时自适应宽度
	window.onresize = function() {
		$("#grid").setGridWidth(document.body.clientWidth - 12);
	}

	//编辑
	function onSave(id) {
		id = id || 0;
		var title = _STTS
		layer.open({
			type : 2,
			title : title,
			shadeClose : true,
			shade : 0.8,
			area : [ '80%', '80%' ],
			content : 'comm/activity/edit4?id=' + id + '&applyto=' + _APPLYTO
					+ '&refnum=' + _REFNUM + '&stts=' + encodeURI(_STTS)
		});
	}

	//添加完成后执行方法
	function onSaveOk() {
		$("#grid").trigger("reloadGrid");
		layer.closeAll();
	}

	//删除
	function onDel(id) {
		layer.confirm('确定要删除该记录吗？', {
			btn : [ '确定', '取消' ]
		//按钮
		}, function() {
			$.post("comm/activity/del", {
				id : id
			}, function(data) {
				$("#grid").trigger("reloadGrid");
			});
			layer.closeAll();
		});
	}
	//查询
	function onQ() {
		var para = {
			title : $("#title").val()
		};
		$("#grid").jqGrid("setGridParam", {
			page : 0,
			postData : para
		}).trigger("reloadGrid");
	}

	//显示全部
	function showAll() {
		$("#title").val("")
		onQ();
	}

	//更改状态
	function onUpStts() {
		$.ajax({
			type : "POST",
			url : 'project/projProject/updateStts',
			data : {
				refnum : _REFNUM,
				stts : getNextStts(_STTS)
			},
			async : false,
			success : function(vl) {
				if (parent.onActOk) {
					parent.onActOk(getNextStts(_STTS));
				}
			},
			error : function(x, e) {
				alert(e)
			}
		});
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
				onclick="onSave(0)">添加</button>
			<button class="btn btn-info" id="btnAdd" type="button"
				onclick="onUpStts()">结束</button>
			&nbsp;&nbsp;&nbsp;
		</div>
		<table id="grid"></table>
		<div id="pager" style="height:35px;"></div>
	</div>
</body>
</html>