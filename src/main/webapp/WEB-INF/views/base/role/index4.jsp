<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>角色机构--列表</title>
<jsp:include page="/WEB-INF/views/include/head.jsp" />
<script>
    //装载表格
    function loadGrid () {
	    $ ("#grid").jqGrid ({
	        url : "base/role/list",
	        height : document.body.clientHeight - 130,
	        rownumbers : true,
	        postData:{
	        	category : "temp"
	        },
	        colModel : [
	                {
	                    label : '名称',
	                    name : 'title',
	                    index : 'title',
	                    width : 100
	                }, {
	                    label : '状态',
	                    name : 'isActive',
	                    index : 'isActive',
	                    sortable : false,
	                    width : 40,
	                    formatter : function (value, options, row) {
		                    return value == 1 ? '使用中' : '<span style="color:gray;">已停用</span>'
	                    }
	                }, {
	                    label : '用户数量',
	                    name : 'userIds',
	                    index : 'userIds',
	                    width : 80,
	                    formatter : function (value, options, row) {
		                    if (value != null && value != ""){
			                    var ar = value.split (",");
			                    return ar.length + " 人";
			                    ;
		                    }
		                    return 0 + " 人";
	                    }
	                }, {
	                    label : ' ',
	                    name : 'id',
	                    width : 100,
	                    align : 'center',
	                    sortable : false,
	                    formatter : function (value, options, row) {
		                    var btn = "";
		                    btn += '&nbsp;<a href="javascript:onSave(' + value + ')" title="">编辑</a>'
		                    btn += '&nbsp;<a href="javascript:onDel(' + value + ')" title="">删除</a>';
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
    function onSave (id, parentid) {
	    id = id || 0;
	    parentid = parentid || 0;
	    document.location = "base/role/edit4?id=" + id;
    }
    //编辑完成回调函数
    function onSaveOk () {
	    //layer.closeAll ();
	    $ ("#grid").trigger ("reloadGrid");
    }
    //删除
    function onDel (id) {
	    layer.confirm ('确定要删除该角色？', {
		    btn : [
		            '确定', '取消'
		    ]
	    //按钮
	    }, function () {
		    $.post ("base/role/del", {
			    id : id
		    }, function () {
			    $ ("#grid").trigger ("reloadGrid");
		    });
		    layer.closeAll ();
	    });
    }
    //排序
    function onSort (id, order) {
	    $.post ("base/role/sort", {
	        id : id,
	        order : order
	    }, function (rest) {
		    $ ("#grid").trigger ("reloadGrid");
	    });
    }
    //查询
    function onQ () {
	    var para = {
	        title : $ ("#title").val (),
	        sym : $ ("#sym").val ()
	    };
	    $ ("#grid").jqGrid ("setGridParam", {
	        page : 0,
	        postData : para
	    }).trigger ("reloadGrid");
    }
    //显示全部
    function showAll () {
	    $ ("#title").val ("");
	    $ ("#sym").val ("")
	    onQ ();
    }
    
    //页面加载完成后执行
    $ (function () {
	    loadGrid ();
    });
</script>
</head>

<body><button class="btn btn-info" id="btnAdd" type="button"
					onclick="javascript:document.location='base/user/index'">用户管理</button>
					&nbsp;&nbsp;
					<button class="btn btn-info" id="btnAdd" type="button"
					onclick="javascript:document.location='base/role/index4'">考生组管理</button>
	<div class="container-fluid">
		<div class="breadcrumb content-header form-inline"
			style="padding:8px;">
			<div class="form-group">
				<label for="title">标题</label> <input class="form-control input-sm"
					id="title" value="" type="text" />
			</div>
			<div class="form-group" style="display:none">
				<label for="sym">代号</label> <input class="form-control input-sm"
					id="sym" value="" type="text" />
			</div>
			<div class="form-group">
				<button class="btn btn-info" id="btnAdd" type="button"
					onclick="onQ()">查询</button>
			</div>
			<div class="form-group">
				<button class="btn btn-info" id="btnShowAll" type="button"
					onclick="showAll()">显示全部</button>
				&nbsp;&nbsp;
				<button class="btn btn-info" id="btnAdd" type="button"
					onclick="onSave()">添加</button>
			</div>
			<ol class="pull-right breadcrumb">
				<li><a href="home/dashboard"><i class="fa fa-dashboard"></i>
						首页</a></li>
				<li class="active">考生组管理</li>
			</ol>
		</div>
		<table id="grid"></table>
		<div id="pager" style="height:35px;"></div>
	</div>
</body>
</html>
