<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>菜单管理--列表</title>
<jsp:include page="/WEB-INF/views/include/head4.jsp" />
<script>
	var _expandPath = "";

    //装载表格
    function loadGrid () {
	    $ ("#grid").jqGrid (
	            {
	                url : "base/menu/list",
	                height : document.body.clientHeight - 100,
	                colModel : [
	                        {
	                            label : '标题',
	                            name : 'title',
	                            index : 'title',
	                            width : 200
	                        },
	                        {
	                            label : ' ',
	                            name : "img",
	                            width : 35,
	                            formatter : function (value, option, row) {
		                            return "<i class='"+value+"'></i>";
	                            }
	                        },
	                        {
	                            label : '状态',
	                            name : 'isActive',
	                            index : 'isActive',
	                            sortable : false,
	                            width : 60,
	                            formatter : function (value, options, row) {
		                            return value == 1 ? '使用中' : '<span style="color:gray;">已停用</span>'
	                            }
	                        },
	                        {
	                            label : '代号',
	                            name : 'sym',
	                            index : 'sym',
	                            width : 200
	                        },
	                        {
	                            label : '地址',
	                            name : 'url',
	                            index : 'url',
	                            width : 180
	                        },
	                        {
	                            label : ' ',
	                            name : 'id',
	                            width : 260,
	                            align : 'center',
	                            sortable : false,
	                            formatter : function (value, options, row) {
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
	    jQuery ("#grid").jqGrid ('bindKeys', {
	        "onEnter" : function (rowid) {
		        //alert ("你enter了一行， id为:" + rowid)
	        },
	        "onRightKey" : function (rowid) {
		        onSave (rowid)
	        },
	        "onLeftKey" : function (rowid) {
		        onDel (rowid)
	        },
	        "onSpace" : function (rowid) {
	        }
	    });
    }
    //编辑
    function onSave (id, pid) {
	    id = id || 0;
	    pid = pid || 0;
	    var title = "添加菜单"
	    if (id > 0){
		    title = "编辑菜单"
	    }
	    layer.open ({
	        type : 2,
	        title : title,
	        shadeClose : true,
	        shade : 0.8,
	        area : [
	                '800', '410'
	        ],
	        content : 'base/menu/edit?id=' + id + "&parentId=" + pid //iframe的url
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
	    layer.confirm ('确定要删除该菜单？', {
		    btn : [
		            '确定', '取消'
		    ]
	    //按钮
	    }, function () {
		    $.post ("base/menu/del", {
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
	    $.post ("base/menu/sort", {
	        id : id,
	        order : order
	    }, function () {
		    _expandPath = path;
		    $ ("#grid").trigger ("reloadGrid");
	    });
    }
    
    //页面加载完成后执行
    $ (function () {
	    loadGrid ();
    });
</script>
</head>

<body>
	<div class="container-fluid">
		<div class="breadcrumb content-header form-inline"
			style="padding:8px;">
			<button class="btn btn-info" id="btnAdd" type="button"
				onclick="onSave()">添加根节点</button>
			<ol class="pull-right breadcrumb">
				<li><a href="home/dashboard"><i class="fa fa-dashboard"></i>
						首页</a></li>
				<li class="active">菜单管理</li>
			</ol>
		</div>
		<table id="grid"></table>
	</div>
</body>
</html>
