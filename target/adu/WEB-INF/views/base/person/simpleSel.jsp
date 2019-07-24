<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>人员--选择</title>
<jsp:include page="/WEB-INF/views/include/head4.jsp" />
<script>
	$(function() {
		$("#ifrmOrg").height(document.body.clientHeight - 115)
		loadGrid();
		$("#orgName").val("${baseOrgName}");
	});
	function loadGrid() {
		$("#grid").jqGrid(
				{
					url : "base/person/list?baseOrgId=${baseOrgId}"
							+ "&baseOrgName=" + encodeURI("${baseOrgName}"),
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

	//查询
	function onQ(orgid) {
		var para = {
			name : $("#name").val(),
			baseOrgName : $("#orgName").val()
		};
		$("#grid").jqGrid("setGridParam", {
			page : 0,
			postData : para
		}).trigger("reloadGrid");
	}
	function showAll() {
		$("#name").val("");
		$("#orgName").val("")
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
				<label for="orgName">单位</label> <input class="form-control input-sm"
					id="orgName" value="" type="text" />
			</div>
			<div class="form-group">
				<label for="name">姓名</label> <input class="form-control input-sm"
					id="name" value="" type="text" />
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
