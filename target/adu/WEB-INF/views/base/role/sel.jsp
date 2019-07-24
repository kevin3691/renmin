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
			url : "base/person/list",
			postData : {
				isActive : 1
			},
			height : document.body.clientHeight - 130,
			rownumbers : true,
			colModel : [ {
				label : '姓名',
				name : 'name',
				index : 'name',
				width : 60
			}, {
				label : '单位',
				name : 'baseOrgName',
				index : 'baseOrgName',
				width : 120
			}, {
				label : '编号',
				name : 'sym',
				index : 'sym',
				width : 60
			}, {
				label : '性别',
				name : 'legalRepresentative',
				index : 'legalRepresentative',
				width : 40
			}, {
				label : '职务',
				name : 'title',
				index : 'title',
				width : 100
			}, {
				name : 'id',
				hidden : true
			}, {
				name : 'baseOrgId',
				hidden : true
			}, {
				name : 'phone',
				hidden : true
			}, {
				name : 'email',
				hidden : true
			} ],
			rowNum : 20,
			rowList : [ 20, 50, 100 ],
			pager : '#pager',
			sortname : 'lineNo',
			sortorder : "asc",
			onSelectRow : function(rowid, status) {
				var row = $("#grid").jqGrid("getRowData", rowid);
				if (parent.onPersonSelOk) {
					parent.onPersonSelOk(row);
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
	function onQ(orgid) {
		var para = {
			baseOrgId : orgid,
			name : $("#name").val(),
			sym : $("#sym").val()
		};
		$("#grid").jqGrid("setGridParam", {
			page : 0,
			postData : para
		}).trigger("reloadGrid");
	}
	function showAll() {
		$("#name").val("");
		$("#sym").val("")
		onQ(0);
		$('#ifrmOrg').attr('src', $('#ifrmOrg').attr('src'));
	}
</script>
</head>

<body>
	<div class="container-fluid">
		<div class="breadcrumb content-header form-inline"
			style="padding:8px;">
			<div class="form-group">
				<label for="name">姓名</label> <input class="form-control input-sm"
					id="name" value="" type="text" />
			</div>
			<div class="form-group">
				<label for="sym">编号</label> <input class="form-control input-sm"
					id="sym" value="" type="text" />
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
			<div class="col-sm-3 no-padding" style="">
				<div class="nav-tabs-custom">
					<!-- Tabs within a box -->
					<ul class="nav nav-tabs pull-right ui-sortable-handle">
						<li class="pull-left header"
							style="padding-left:20px;font-size:14px;"><i
							class="fa fa-bank"></i> <b> 机构列表 <b></li>
					</ul>
					<div class="tab-content no-padding">
						<iframe scrolling="auto" id="ifrmOrg"
							style="width: 100%; height: 300px;" frameborder="0"
							src="base/org/list4"></iframe>
					</div>
				</div>
			</div>
			<div class="col-sm-9">
				<table id="grid"></table>
				<div id="pager" style="height:35px;"></div>
			</div>
		</div>
	</div>
</body>
</html>
