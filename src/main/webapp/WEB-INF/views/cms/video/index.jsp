<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>视频新闻 - 列表</title>
<jsp:include page="/WEB-INF/views/include/head.jsp" />
<script>
	//装载表格
    function loadGrid () {
	    $ ("#grid").jqGrid ({
	        url : "cms/video/list?colSym=${colSym}",
	        height : document.body.clientHeight - 130,
	        rownumbers : true,
	        colModel : [
	                {
	                    label : '标题',
	                    name : 'title',
	                    index : 'title',
	                    width : 260,
	                    formatter : function (value, index, row) {
		                    if (row.top > 0){
			                    return '<i class="fa fa-star"></i>&nbsp;&nbsp;' + value;
		                    }
		                    else{
			                    return value;
		                    }
	                    }
	                }, {
	                    label : '类型',
	                    name : 'keyword',
	                    index : 'keyword',
	                    width : 100
	                }, {
	                    label : '片长',
	                    name : 'summary',
	                    index : 'summary',
	                    width : 100
	                }, {
	                    label : '发布时间',
	                    name : 'publishAt',
	                    index : 'publishAt',
	                    width : 100,
	                    formatter : function (v) {
		                    return jsonDateTimeFormatter (v, 1)
	                    }
	                }, {
	                    label : '发布人',
	                    name : 'recordInfo.createdByName',
	                    index : 'recordInfo.createdByName',
	                    width : 80
	                }, {
	                    label : ' ',
	                    name : 'id',
	                    align : 'center',
	                    width : 100,
	                    sortable : false,
	                    formatter : function (value, options, row) {
		                    var btn = "";
		                    btn += '&nbsp;<a href="javascript:onSave(' + value + ')" title="">编辑</a>'
		                    btn += '&nbsp;<a href="javascript:onDel(' + value + ')" title="">删除</a>'
		                    if (row.top == 0){
			                    btn += '&nbsp;<a href="javascript:onTop(' + value + ',100)" title="">置顶</a>'
		                    }
		                    else{
			                    btn += '&nbsp;<a href="javascript:onTop(' + value + ',0)" title="">取消置顶</a>&nbsp;'
		                    }
		                    return btn;
	                    }
	                }
	        ],
	        rowNum : 20,
	        rowList : [
	                20, 50, 100
	        ],
	        pager : '#pager',
	        sortname : 'top desc,recordInfo.createdAt desc,id desc',
	        sortorder : "desc"
	    });
    }
    //执行添加方法
    function onSave (id) {
	    id = id || 0;
	    document.location = _BasePath + 'cms/video/edit?id=' + id + "&colSym=${colSym}&colTitle="
	            + encodeURI ("${colTitle}") + "&template=" + encodeURI ("${template}");
    }
    //删除方法
    function onDel (id) {
	    layer.confirm ('确定要删除该记录？', {
		    btn : [
		            '确定', '取消'
		    ]
	    //按钮
	    }, function () {
		    $.post ("cms/news/del", {
			    id : id
		    }, function () {
			    $ ("#grid").trigger ("reloadGrid");
		    });
		    layer.closeAll ();
	    });
    }
    //添加成功后执行的方法
    function onSaveOk (entity) {
	    $ ("#grid").trigger ("reloadGrid");
	    layer.closeAll ();
    }
    //置顶方法
    function onTop (id, top) {
	    layer.confirm ('确定要置顶该记录？', {
		    btn : [
		            '确定', '取消'
		    ]
	    //按钮
	    }, function () {
		    $.post ("cms/news/update", {
		        colSym : "${colSym}",
		        id : id,
		        top : top
		    }, function (result) {
			    $ ("#grid").trigger ("reloadGrid");
		    });
		    layer.closeAll ();
	    });
    }
    //取消置顶
    function onCTop (id, top) {
	    layer.confirm ('确定要取消置顶该记录？', {
		    btn : [
		            '确定', '取消'
		    ]
	    //按钮
	    }, function () {
		    $.post ("cms/news/update", {
		        colSym : "${colSym}",
		        id : id,
		        top : 0
		    }, function (result) {
			    $ ("#grid").trigger ("reloadGrid");
		    });
		    layer.closeAll ();
	    });
    }
    //查询
    function onQ () {
	    var para = {
	        title : $ ("#title").val (),
	        createdByName : $ ("#createdByName").val (),
	        stts : $ ("#stts").val ()
	    };
	    $ ("#grid").jqGrid ("setGridParam", {
		    postData : para
	    }).trigger ("reloadGrid");
    }
    //显示全部
    function showAll () {
	    $ ("#title").val ("");
	    $ ("#createdByName").val ("");
	    $ ("#stts").val ("");
	    onQ ();
    }
    //初始化
    $ (function () {
	    loadGrid ();
    });
</script>

</head>

<body>
	<div class="container-fluid">
		<div class="breadcrumb content-header form-inline"
			style="padding:8px;">
			<div class="form-group">
				<label for="title">标题</label> <input class="form-control input-sm"
					id="title" value="" type="text" /> <label for="createdByName">发布人</label> <input
					class="form-control input-sm" id="createdByName" value=""
					type="text" /> <label for="stts">状态</label> <select id="stts"
					name="stts" style="width:100px;" class="form-control select2">
					<option value="">全部</option>
					<option value="待审核">待审核</option>
					<option value="已审核">已审核</option>
				</select>
			</div>

			<div class="form-group">
				<button class="btn btn-info" id="btnAdd" type="button"
					onclick="onQ()">查询</button>
			</div>
			<div class="form-group">
				<button class="btn btn-info" id="btnShowAll" type="button"
					onclick="showAll()">显示全部</button>
			</div>
			<div class="form-group">
				<button class="btn btn-info" id="btnShowAll" type="button"
					onclick="onSave()">添加</button>
			</div>
			<ol class="pull-right breadcrumb">
				<li><a href="home/dashboard"><i class="fa fa-dashboard"></i>
						首页</a></li>
				<li class="active">${colTitle}</li>
			</ol>
		</div>
		<table id="grid"></table>
		<div id="pager" style="height:35px;"></div>
	</div>
</body>
</html>
