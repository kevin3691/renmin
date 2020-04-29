<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>用户管理--列表</title>
<jsp:include page="/WEB-INF/views/include/head4.jsp" />
<script>
	//装载表格
	function loadTable () {
		$ ("#userList").jqGrid ({
			url : "base/user/list",
			height : 500,
			colModel : [
				{
					label : '用户名',
					name : 'username',
					index : 'username',
					//width : 30
				},/* {
					label : '状态',
					name : 'isActive',
					index : 'isActive',
					sortable : false,
					width : 30,
					formatter : function (value, options, row) {
						return value == 1 ? '使用中' : '<span style="color:gray;">已停用</span>'
					}
				},*/ {
					label : '姓名',
					name : 'basePersonName',
					index : 'basePersonName',
					//width : 30
				}, /*{
					label : '单位',
					name : 'baseOrgName',
					index : 'baseOrgName',
					width : 100
				}, */{
					label : '角色',
					name : 'baseRoleName',
					index : 'baseRoleName',
					//width : 30
				}, {
					label : ' ',
					name : 'id',
					//width : 30,
					align : 'center',
					sortable : false,
					formatter : function (value, options, row) {
						var btn = "";
						btn += '&nbsp;<a href="javascript:onSave(' + row.id + ',\'' + row.basePersonName + '\',\'' + row.baseOrgName + '\');" title="">发信息</a>';
						return btn;
					}
				}
			],
			rowNum : 20,
			rowList : [
				20, 50, 100
			],
			pager : '#pager',
			sortname : 'lineNo',
			sortorder : "asc"
		});
	}

	//添加完成后执行方法
	function onSave (id,name,prName){
		parent.toSendMes(id,name,prName);
	}



	//添加完成后执行方法
	function onSaveOk (entity) {
		$ ("#userList").trigger ("reloadGrid");
		layer.closeAll ();
	}
	//Iframe中点击ORG时获取ORGID，查询该机构下的人员
	function onOrgNodeClick (node) {
		onQ (node.id);
	}
	//查询
	function onQ (orgid) {
		var para = {
			baseOrgId : orgid,
			basePersonName : $ ("#basePersonName").val (),
			username : $ ("#username").val ()
		};
		$ ("#userList").jqGrid ("setGridParam", {
			page : 0,
			postData : para
		}).trigger ("reloadGrid");
	}
	//显示全部
	function showAll () {
		$ ("#basePersonName").val ("")
		$ ("#username").val ("")
		onQ (0);
		$ ('#ifrmOrg').attr ('src', $ ('#ifrmOrg').attr ('src'));
	}

$(function () {
	loadTable();
})

</script>

</head>

<body>
	<div class="container-fluid">
		<div class="breadcrumb content-header form-inline"
			style="padding:8px;">
			<div class="form-group">
				<label for="basePersonName">姓名</label> <input
					class="form-control input-sm" id="basePersonName" value=""
					type="text" />
			</div>
			<div class="form-group">
				<label for="username">用户名</label> <input
					class="form-control input-sm" id="username" value="" type="text" />
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
			<div class="col-sm-2 no-padding" style="">
				<div class="nav-tabs-custom">
					<!-- Tabs within a box -->
					<ul class="nav nav-tabs pull-right ui-sortable-handle">
						<li class="pull-left header"
							style="padding-left:20px;font-size:14px;"><i
							class="fa fa-bank"></i> <b> 机构列表 </b></li>
					</ul>
					<div class="tab-content no-padding">
						<iframe scrolling="no" id="ifrmOrg"
							style="width: 100%; height: 300px;" frameborder="0"
							src="base/org/list4"></iframe>
					</div>
				</div>
			</div>
			<div class="col-sm-10">
				<table id="userList"></table>
				<div id="pager" style="height:35px;"></div>
			</div>
		</div>
	</div>
</body>
</html>
