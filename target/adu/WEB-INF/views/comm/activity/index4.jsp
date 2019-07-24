<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>活动--列表</title>
<jsp:include page="/WEB-INF/views/include/head.jsp" />
<script src="jslib/projwf.js"></script>
<script>
	//装载表格
	function loadGrid() {
		var opts = {
			url : "comm/activity/list",
			postData : {
				category : "${category}",
				applyTo : "${applyTo}",
				refNum : "${refNum}"
			},
			height : 50,
			fitColumns : true,
			rownumbers : true,
			colModel : [
					//{
					//	label : '活动标题',
					//	name : 'title',
					//	index : 'title',
					//	sortable : false,
					//	width : 180
					//},
					{
						label : '执行人',
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
						width : 110,
						formatter : function(value, options, row) {
							return jsonDateTimeFormatter(value, 1);
						}
					},
					{
						label : '活动内容',
						name : 'descr',
						index : 'descr',
						sortable : false,
						width : 220
					},
					{
						label : ' ',
						name : 'id',
						width : 80,
						align : 'center',
						sortable : false,
						formatter : function(value, options, row) {
							var btn = "";
							btn += '&nbsp;<a href="javascript:onSave(' + value
									+ ')" title="">查看</a>'
							if ("${mode}" == "RW") {
								btn += '&nbsp;<a href="javascript:onDel('
										+ value + ')" title="">删除</a>'
							}
							return btn;
						}
					} ],
			rowNum : 100,
			rowList : [ 100, 200, 500 ],
			pager : '#pager',
			gridComplete : function() {
				var rows = $("#grid").jqGrid("getDataIDs").length
				$("#grid").jqGrid("setGridHeight", "auto")
				if (parent.document.getElementById("ifrmAct")) {
					parent.document.getElementById("ifrmAct").style.height = 50 + 40 * rows;
				}
				if (parent.document.getElementById("ifrmAct4")) {
					parent.document.getElementById("ifrmAct4").style.height = 50 + 40 * rows;
				}
			}
		}
		if ("${mode}" == "RW") {
			opts.colModel[3].label = '<button onclick="onSave(0)" class="btn btn-sm btn-info" type="button"><i class="fa  fa-fw fa-edit"></i>添加活动</button>'
		}
		$("#grid").jqGrid(opts);
		jQuery("#grid").jqGrid('bindKeys', {
			"onEnter" : function(rowid) {
				//alert ("你enter了一行， id为:" + rowid)
			},
			"onRightKey" : function(rowid) {
				if ("${mode}" == "RW") {
					onEdit(rowid)
				}
			},
			"onLeftKey" : function(rowid) {
				if ("${mode}" == "RW") {
					onDel(rowid)
				}
			},
			"onSpace" : function(rowid) {
			}
		});
	}

	//窗口变化时自适应宽度
	window.onresize = function() {
		$("#grid").setGridWidth(document.body.clientWidth - 12);
	}

	//编辑
	function onSave(id) {
		id = id || 0;
		var title = "查看"
		var mode = "RO";
		if (id == "0") {
			title = "添加";
			mode = "RW"
		}
		parent.layer
				.open({
					type : 2,
					title : title,
					shadeClose : true,
					shade : 0.8,
					area : [ '800', '80%' ],
					content : 'comm/activity/edit4?id='
							+ id
							+ '&applyTo=${applyTo}&refNum=${refNum}&category=${category}&actSym=${actSym}&mode='
							+ mode
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
		$("#grid").trigger("reloadGrid");
	}

	//显示全部
	function showAll() {
		$("#title").val("")
		onQ();
	}

	//初始化
	$(function() {
		loadGrid();
	});
</script>
</head>

<body>
	<div class="container-fluid">
		<table id="grid"></table>
		<div id="pager" style="height:35px;display:none;"></div>
	</div>
</body>
</html>