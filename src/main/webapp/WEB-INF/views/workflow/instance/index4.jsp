<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>待办--列表</title>
<jsp:include page="/WEB-INF/views/include/head.jsp" />
<script>
	//装载表格
	function loadGrid() {
		var opts = {
			url : "workflow/instance/list?applyTo=${applyTo}&refNum=${refNum}",
			height : 50,
			rownumbers : true,
			postData : {
				applyTo : "${applyTo}",
				refNum : "${refNum}"
			},
			colModel : [ {
				label : '环节名称',
				name : 'stepName',
				index : 'stepName',
				sortable : false,
				width : 130
			}, {
				label : '执行人',
				name : 'actorName',
				index : 'actorName',
				sortable : false,
				width : 130
			}, {
				label : '执行时间',
				name : 'actAt',
				index : 'actAt',
				sortable : false,
				width : 160,
				formatter : function(value, options, row) {
					return jsonDateTimeFormatter(value, 2);
				}
			}, {
				label : '环节意见',
				name : 'descr',
				index : 'descr',
				sortable : false,
				width : 260,
				formatter : function(value, options, row) {
					return value;
				}
			} ],
			rowNum : 100,
			rowList : [ 100, 200, 300 ],
			/* pager : '#pager', */
			sortname : 'id',
			sortorder : "asc",
			gridComplete : function() {
				var rows = $("#grid").jqGrid("getDataIDs").length
				$("#grid").jqGrid("setGridHeight", "auto")
				$("#grid").jqGrid("setGridWidth", "auto")
				if (parent.document.getElementById("ifrmWf")) {
					parent.document.getElementById("ifrmWf").style.height = 50 + 40 * rows;
				}
			}
		}
		$("#grid").jqGrid(opts);
	}

	//初始化
	$(function() {
		loadGrid();
		/* if (parent.document.getElementById("ifrmWf")) {
			parent.document.getElementById("ifrmWf").style.height = parent.document.body.clientHeight - 200;
		} */
	});
</script>
</head>

<body>
	<div class="container-fluid">
		<table id="grid"></table>
		<!-- <div id="pager" style="height:35px;"></div> -->
	</div>
</body>
</html>