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
		$("#grid").datagrid({
            height: document.body.clientHeight - 30,
            nowrap: true,
            rownumbers: true,
            fitColumns: true,
            singleSelect:true,
            animate: true,
            collapsible: true,
            toolbar:'#tb',
            url: 'base/person/list',
            queryParams:{
                isActive:1
			},
            idField: 'id',
            pagination: true,
            pageNumber:1,
            pageSize:20,
            fitColumns: true,
            striped: true,
            pageList: [20, 30, 40, 50, 100],
            columns : [[
                {
				title : '姓名',
				field : 'name',
				width : 60
			}, {
                    title : '单位',
                    field : 'baseOrgName',
				width : 120
			}, {
                    title : '编号',
                    field : 'sym',
				width : 60
			}, {
                    title : '性别',
                    field : 'legalRepresentative',
				width : 40
			}, {
                    title : '职务',
                    field : 'title',
				width : 100
			}, {
				field : 'id',
				hidden : true
			}, {
                    field : 'baseOrgId',
				hidden : true
			}, {
                    field : 'phone',
				hidden : true
			}, {
                    field : 'email',
				hidden : true
			} ]],
			sortName : 'lineNo',
			sortOrder : "asc",
            onSelect : function(rowIndex, rowData) {
				//var row = $("#grid").datagrid("getRowData", rowid);
				if (parent.onPersonSelOk) {
					parent.onPersonSelOk(rowData);
				}
				else if(top.frames[0].onPersonSelOk){
					top.frames[0].onPersonSelOk(rowData);
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
		$("#grid").datagrid("reload", para);
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
<div class="container">
	<div class="left-tree">
		<iframe scrolling="no" id="ifrmQdb"
				style="width: 100%; height: 100%;" frameborder="0"
				src="base/org/list4"></iframe>
	</div>
	<div class="content">
		<table id="grid">

		</table>
		<div id="tb" style="padding:0 30px;">
			<div class="conditions">
				<span class="con-span">姓名: </span><input class="easyui-textbox" type="text" id="name" name="name" style="width:166px;height:35px;line-height:35px;"></input>
				<a href="javascript:;" onclick="onQ()"  class="easyui-linkbutton" iconCls="icon-search" data-options="selected:true">查询</a>
				<a href="javascript:;" onclick="showAll()" class="easyui-linkbutton" iconCls="icon-reload">重置</a>
				<%--<a href="#" class="easyui-linkbutton more" iconCls="icon-more">更多</a>--%>
			</div>

		</div>
	</div>
</div>

</body>
</html>
