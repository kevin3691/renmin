<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>任务--列表</title>
<jsp:include page="/WEB-INF/views/include/head.jsp" />
<script src="jslib/projwf.js"></script>
<script>
	//生成表格
	function loadGrid() {
		var opts = {
			url : "comm/task/list",
			postData : {
				category : "${category}",
				applyTo : "${applyTo}",
				refNum : "${refNum}"
			},
			height : 50,
			fitColumns : true,
			rownumbers : true,
			colModel : [
					{
						label : '任务标题',
						name : 'title',
						index : 'title',
						sortable : false,
						width : 230
					},
					/* {
						label : '办理期限起',
						name : 'limitStartAt',
						index : 'limitStartAt',
						sortable : false,
						width : 130,
						formatter : function(value, options, row) {
							return jsonDateTimeFormatter(value);
						}
					},
					{
						label : '止',
						name : 'limitEndAt',
						index : 'limitEndAt',
						sortable : false,
						width : 130,
						formatter : function(value, options, row) {
							return jsonDateTimeFormatter(value);
						}
					}, */
					{
						label : '负责人',
						name : 'primaryPerson',
						index : 'primaryPerson',
						sortable : false,
						width : 80
					},
					{
						label : '任务状态',
						name : 'status',
						index : 'status',
						sortable : false,
						width : 80
					},
					{
						label : ' ',
						name : 'id',
						width : 100,
						align : 'center',
						sortable : false,
						formatter : function(value, options, row) {
							var btn = "";
							if ("${mode}" == "RW") {
								if ("${personTitle}" == "副总"
										|| "${personTitle}" == "部门经理") {
									btn += '&nbsp;<a href="javascript:onPlan('
											+ value + ')" title="">安排</a>'
								}
							}
							if ("${mode}" == "RW") {
								btn += '&nbsp;<a href="javascript:onAct('
										+ value + ')" title="">办理</a>'
							}
							if ("${mode}" == "RO") {
								btn += '&nbsp;<a href="javascript:onAct('
										+ value + ')" title="">查看</a>'
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
				if ("${mode}" == "RW") {
					if (parent.document.getElementById("ifrmAct")) {
						parent.document.getElementById("ifrmAct").style.height = 50 + 40 * rows;
					}
				}
			}
		}
		/* if ("${mode}" == "RW") {
			opts.colModel[3].label = '<button onclick="onSave(0)" class="btn btn-sm btn-info" type="button"><i class="fa  fa-fw fa-edit"></i>添加活动</button>'
		} */
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

	//安排
	function onPlan(id) {
		id = id || 0;
		var title = "任务安排"
		var mode = "${mode}";
		parent.layer
				.open({
					type : 2,
					title : title,
					shadeClose : true,
					shade : 0.8,
					area : [ '800', '85%' ],
					content : 'comm/task/assign?id='
							+ id
							+ '&applyTo=${applyTo}&refNum=${refNum}&category=${category}&mode='
							+ mode
				});
	}

	//办理
	function onAct(id) {
		id = id || 0;
		var title = "任务办理"
		var mode = "${mode}";
		parent.layer
				.open({
					type : 2,
					title : title,
					shadeClose : true,
					shade : 0.8,
					area : [ '800', '420' ],
					content : 'comm/task/act?id='
							+ id
							+ '&applyTo=${applyTo}&refNum=${refNum}&category=${category}&mode='
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
			$.post("comm/task/del", {
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