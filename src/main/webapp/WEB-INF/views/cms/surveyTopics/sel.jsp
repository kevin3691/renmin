<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>人员--选择</title>
<jsp:include page="/WEB-INF/views/include/head.jsp" />
<script>
	$(function() {
		$("#ifrmOrg").height(document.body.clientHeight - 115)
		loadGrid();
	});
	function loadGrid() {
		$("#grid").jqGrid({
			url : "cms/surveyTopics/list",
	        height : document.body.clientHeight - 130,
	        rownumbers : true,
	        colModel : [
					{
						name : 'id',
						index : 'id',
						hidden : true
					},
	                {
	                    label : '标题',
	                    name : 'topicTitle',
	                    index : 'topicTitle',
	                    width : 150
	                }, {
	                    label : '状态',
	                    name : 'isActive',
	                    index : 'isActive',
	                    sortable : false,
	                    width : 50,
	                    formatter : function (value, options, row) {
		                    return value == 1 ? '使用中' : '<span style="color:gray;">已停用</span>'
	                    }
	                }, {
	                    label : '起始时间',
	                    name : 'startTime',
	                    index : 'startTime',
	                    width : 50,
	                    formatter : function (value, options, row) {
		                    return jsonDateTimeFormatter(value,0);
	                    }
	                }, {
	                    label : '终止时间',
	                    name : 'endTime',
	                    index : 'endTime',
	                    width : 50,
	                    formatter : function (value, options, row) {
		                    return jsonDateTimeFormatter(value,0);
	                    }
	                },
	        ],
			rowNum : 20,
			rowList : [ 20, 50, 100 ],
			pager : '#pager',
			sortname : 'id',
			sortorder : "desc",
			onSelectRow : function(rowid, status) {
				var row = $("#grid").jqGrid("getRowData", rowid);
				if (parent.onSurveyTopicsSelOk) {
					parent.onSurveyTopicsSelOk(row);
				}
				var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
				parent.layer.close(index); //再执行关闭   
			}
		});
	}
	//Iframe中点击ORG时获取ORGID，查询该机构下的人员
	function onOrgNodeClick(node) {
		onQ(node.id);
	}
	 //查询
    function onQ (orgid) {
	    var para = {
	    	topicTitle : $ ("#topicTitle").val (),
	    };
	    $ ("#grid").jqGrid ("setGridParam", {
	        page : 0,
	        postData : para
	    }).trigger ("reloadGrid");
    }
    //显示全部
    function showAll () {
	    $ ("#topicTitle").val ("");
	    onQ (0);
    }
</script>
</head>

<body>
	<div class="container-fluid">
		<div class="breadcrumb content-header form-inline"
			style="padding:8px;">
			<div class="form-group">
				<label for="name">调查主题标题</label> <input class="form-control input-sm"
					id="topicTitle" value="" type="text" />
			</div>
			<div class="form-group">
				<button class="btn btn-info" id="btnAdd" type="button"
					onclick="onQ()">查询</button>
			</div>
			<div class="form-group">
				<button class="btn btn-info" id="btnShowAll" type="button"
					onclick="showAll()">显示全部</button>
			</div>
		</div>
		<div class="row">
			<div class="col-sm-12">
				<table id="grid"></table>
				<div id="pager" style="height:35px;"></div>
			</div>
		</div>
	</div>
</body>
</html>
