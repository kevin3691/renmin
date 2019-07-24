<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>打印模板--列表</title>
<jsp:include page="/WEB-INF/views/include/head4.jsp" />
<script>
	//装载表格
    function loadGrid () {
	    var opts = {
	        url : "workflow/workflow/list",
	        height : document.body.clientHeight - 145,
	        rownumbers : true,
	        colModel : [
	                {
	                    label : '标题',
	                    name : 'title',
	                    index : 'title',
	                    width : 60
	                }, {
	                    label : '代号',
	                    name : 'sym',
	                    index : 'sym',
	                    width : 60
	                }, {
	                    label : '类别',
	                    name : 'category',
	                    index : 'category',
	                    width : 60
	                }, {
	                    label : '状态',
	                    name : 'isActive',
	                    index : 'isActive',
	                    width : 60,
	                    formatter : function (value, options, row) {
		                    return value == 1 ? '使用中' : '<span style="color:gray;">已停用</span>'
	                    }
	                }, {
	                    label : '备注',
	                    name : 'descr',
	                    index : 'descr',
	                    width : 60
	                }, {
	                    label : ' ',
	                    name : 'id',
	                    width : 100,
	                    align : 'center',
	                    sortable : false,
	                    formatter : function (value, options, row) {
		                    var btn = "";
		                    btn += '&nbsp;<a href="javascript:onSave(' + value + ')" title="">编辑</a>'
		                    btn += '&nbsp;<a href="javascript:onSort(' + value + ',\'up\')" title="">上移</a>'
		                    btn += '&nbsp;<a href="javascript:onSort(' + value + ',\'down\')" title="">下移</a>'
		                    btn += '&nbsp;<a href="javascript:onDel(' + value + ')" title="">删除</a>&nbsp;'
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
	        sortorder : "asc",
	        gridComplete : function () {
	        }
	    }
	    $ ("#grid").jqGrid (opts);
    }
    //编辑
    function onSave (id) {
	    id = id || 0;
	    document.location =  'workflow/workflow/edit?id=' + id
    }
    //编辑完成后执行方法
    function onSaveOk (entity) {
	    $ ("#grid").trigger ("reloadGrid");
	    layer.closeAll ();
    }
    //删除
    function onDel (id) {
	    layer.confirm ('确定要删除该角色？', {
		    btn : [
		            '确定', '取消'
		    ]
	    //按钮
	    }, function () {
		    $.post ("workflow/workflow/del", {
			    id : id
		    }, function () {
			    $ ("#grid").trigger ("reloadGrid");
		    });
		    layer.closeAll ();
	    });
    }
    //排序
    function onSort (id, order) {
	    $.post ("workflow/workflow/sort", {
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
	        sym : $ ("#sym").val (),
	        category : $ ("#category").val ()
	    //dob : $ ("dob").val()
	    };
	    //alert (para.category)
	    $ ("#grid").jqGrid ("setGridParam", {
		    postData : para
	    }).trigger ("reloadGrid");
    }
    //显示全部
    function showAll () {
	    $ ("#title").val ("");
	    $ ("#sym").val ("");
	    $ ("#lineNo").val ("");
	    $ ("#descr").val ("");
	    $ ("#isActive").val ("");
	    $ ("#category").val ("");
	    onQ ();
    }
    //窗口变化时自适应宽度
    window.onresize = function () {
	    $ ("#grid").setGridWidth (document.body.clientWidth - 12);
    }
    //初始化
    $ (function () {
	    loadGrid ();
    });
    //heyaping
</script>
</head>

<body>
	<div class="container-fluid">
		<div class="form-group">
			<div class="breadcrumb content-header form-inline"
				style="padding:8px;">
				<div class="form-group">
					<label for="title">标题</label> <input class="form-control input-sm"
						id="title" value="" type="text" />
				</div>
				<div class="form-group">
					<label for="sym">代号</label> <input class="form-control input-sm"
						id="sym" value="" type="text" />
				</div>
				<div class="form-group">
					<label for="category">类别</label> <input
						class="form-control input-sm" id="category" value="" type="text" />
				</div>

				<div class="form-group">
					<button class="btn btn-info" id="btnAdd" type="button"
						onclick="onQ()">查询</button>
				</div>
				<div class="form-group">
					<button class="btn btn-info" id="btnShowAll" type="button"
						onclick="showAll()">显示全部</button>
				</div>
				<button class="btn btn-info" id="btnAdd" type="button"
					onclick="onSave()">添加</button>
				<ol class="breadcrumb">
					<li><a href="home/dashboard"><i class="fa fa-dashboard"></i>
							首页</a></li>
					<li class="active">工作流</li>
				</ol>
			</div>
			<table id="grid"></table>
			<div id="pager" style="height:35px;"></div>
		</div>
	</div>
</body>
</html>