<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>区域管理--列表</title>
<jsp:include page="/WEB-INF/views/include/head.jsp" />
<script>
	//tree
    var _expandPath = "";
    $ (function () {
	    loadGrid ();
    });
    //装载表格
    function loadGrid () {
	    $ ("#grid").jqGrid (
	            {
	                url : "comm/area/list",
	                height : document.body.clientHeight - 100,
	                //rownumbers : true,
	                colModel : [
	                        {
	                            label : '类别',
	                            name : 'category',
	                            index : 'category',
	                            sortable : false,
	                            width : 100
	                        },
	                        {
	                            label : '名称',
	                            name : 'name',
	                            index : 'name',
	                            sortable : false,
	                            width : 100
	                        },
	                        {
	                            label : '代号',
	                            name : 'sym',
	                            index : 'sym',
	                            sortable : false,
	                            width : 100
	                        },
	                        {
	                            label : '状态',
	                            name : 'isActive',
	                            index : 'isActive',
	                            width : 50,
	                            sortable : false,
	                            formatter : function (value, options, row) {
		                            return value == 1 ? '使用中' : '<span style="color:gray;">已停用</span>'
	                            }
	                        },
	                        {
	                            label : ' ',
	                            name : 'id',
	                            width : 220,
	                            align : 'center',
	                            sortable : false,
	                            formatter : function (value, options, row) {
		                            $ ("#" + row.id + " td").css ("background-color", "pink");
		                            var btn = "";
		                            btn = '<a href="javascript:onSave(0,' + row.id + ')" title="">添加下级</a>'
		                            btn += '&nbsp;<a href="javascript:onSave(0,' + row.baseTree.parentId
		                                    + ')" title="">添加本级</a>'
		                            btn += '&nbsp;<a href="javascript:onSave(' + value + ')" title="">编辑</a>'
		                            btn += '&nbsp;<a href="javascript:onSort(' + value + ',\'up\',\''
		                                    + row.baseTree.path + '\')" title="">上移</a>'
		                            btn += '&nbsp;<a href="javascript:onSort(' + value + ',\'down\',\''
		                                    + row.baseTree.path + '\')" title="">下移</a>'
		                            btn += '&nbsp;<a href="javascript:onDel(' + value + ',\'' + row.baseTree.path
		                                    + '\')" title="">删除</a>'
		                            return btn;
	                            }
	                        }
	                ],
	                rowNum : 100,
	                rowList : [
	                        100, 200, 300
	                ],
	                //pager : '#pager',
	                sortname : 'lineNo',
	                sortorder : "asc",
	                //以下TreeGrid字段
	                treeGrid : true,
	                ExpandColumn : "name",
	                ExpandColClick : true,
	                gridComplete : treeExpand
	            });
    }
    //编辑
    function onSave (id, pid) {
	    id = id || 0;
	    pid = pid || 0;
	    var title = "添加区域"
	    if (id > 0){
		    title = "编辑区域"
	    }
	    layer.open ({
	        type : 2,
	        title : title,
	        shadeClose : true,
	        shade : 0.8,
	        area : [
	                '800', '420'
	        ],
	        content : 'comm/area/edit?id=' + id + "&parentId=" + pid //iframe的url
	    });
    }
    //编辑完成后执行方法
    function onSaveOk (entity) {
	    _expandPath = entity.baseTree.path;
	    $ ("#grid").trigger ("reloadGrid");
	    layer.closeAll ();
    }
    //删除
    function onDel (id, path) {
	    layer.confirm ('确定要删除该条记录吗？', {
		    btn : [
		            '确定', '取消'
		    ]
	    //按钮
	    }, function () {
		    $.post ("comm/area/del", {
			    id : id
		    }, function () {
			    _expandPath = path;
			    $ ("#grid").trigger ("reloadGrid");
		    });
		    layer.closeAll ();
	    });
    }
    //排序
    function onSort (id, order, path) {
	    $.post ("comm/area/sort", {
	        id : id,
	        order : order
	    }, function () {
		    _expandPath = path;
		    $ ("#grid").trigger ("reloadGrid");
	    });
    }
    //窗口变化时自适应宽度
    window.onresize = function () {
	    $ ("#grid").setGridWidth (document.body.clientWidth - 12);
    }
    function onListView () {
	    document.location.href = "index"
    }
</script>
</head>

<body>
	<div class="container-fluid">
		<div class="breadcrumb content-header form-inline"
			style="padding:8px;">
			<button class="btn btn-info" id="btnAdd" type="button"
				onclick="onSave()">添加根节点</button>
			&nbsp;&nbsp;
			<button class="btn btn-info" id="btnView" type="button"
				onclick="onListView()">列表浏览</button>
			<ol class="breadcrumb">
				<li><a href="home/dashboard"><i class="fa fa-dashboard"></i>
						首页</a></li>
				<li class="active">区域管理</li>
			</ol>
		</div>
		<div>
			<table id="grid"></table>
		</div>
	</div>
</body>
</html>
