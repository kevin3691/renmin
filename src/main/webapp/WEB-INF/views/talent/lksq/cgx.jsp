<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>表单--列表</title>
<jsp:include page="/WEB-INF/views/include/head.jsp" />
<script>
	//装载表格
	function loadGrid() {
		$("#grid")
				.jqGrid(
						{
							url : "talent/lksq/list",
							height : document.body.clientHeight - 130,
							postData : {
								userId : "${baseUserId}"
							},
							rownumbers : true,
							colModel : [
								{
									label : '姓名',
									name : 'name',
									index : 'name',
									width : 260
								},{
									label : '性别',
									name : 'gender',
									index : 'gender',
									width : 260
								},{
									label : '创建日期',
									name : 'recordInfo.createdAt',
									index : 'recordInfo.createdAt',
									width : 260,
									formatter : function (v) {
					                    return jsonDateTimeFormatter (v, 1)
				                    }
								},
									
									{
										label : ' ',
										name : 'id',
										width : 100,
										align : 'center',
										sortable : false,
										formatter : function(value, options,
												row) {
											var btn = "";
											btn += '&nbsp;<a href="javascript:onSave('
													+ value
													+ ')" title="">编辑</a>'
											
											btn += '&nbsp;<a href="javascript:onDel('
													+ value
													+ ')" title="">删除</a>';
											return btn;
										}
									} ],
							rowNum : 20,
							rowList : [ 20, 50, 100 ],
							pager : '#pager'

						});
	}

	//编辑
	function onSave(id, parentid) {
		id = id || 0;
		parentid = parentid || 0;
		var title = "添加申请表"
		if (id > 0) {
			title = "编辑申请表"
		}
		
		document.location.href = 'talent/lksq/sq?id=' + id
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
			$.post("talent/lksq/del", {
				id : id
			}, function() {
				$("#grid").trigger("reloadGrid");
			});
			layer.closeAll();
		});
	}

	//查询
	function onQ() {
		
	}

	//显示全部
	function showAll() {
		
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
			
			<ol class="breadcrumb">
				<li><a href="home/dashboard"><i class="fa fa-dashboard"></i>
						首页</a></li>
				<li class="active">草稿箱</li>
			</ol>
		</div>
		<table id="grid"></table>
		<div id="pager" style="height:35px;"></div>
	</div>
</body>
</html>