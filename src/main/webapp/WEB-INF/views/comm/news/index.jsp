<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>新闻 - 列表</title>
<jsp:include page="/WEB-INF/views/include/head.jsp" />
<script>
	//装载表格
    function loadGrid () {
	    $ ("#grid").jqGrid ({
	        url : "comm/news/list?colSym=${colSym}",
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
	                }/* , {
	                    label : '关键字',
	                    name : 'keyword',
	                    index : 'keyword',
	                    width : 100
	                } */, {
	                    label : '发布时间',
	                    name : 'recordInfo.createdAt',
	                    index : 'recordInfo.createdAt',
	                    width : 100,
	                    formatter : function (v) {
		                    return jsonDateTimeFormatter (v, 1)
	                    }
	                }, {
	                    label : '发布人',
	                    name : 'recordInfo.createdByName',
	                    index : 'recordInfo.createdByName',
	                    width : 80
	                }/* , {
	                    label : '审核状态',
	                    name : 'stts',
	                    index : 'stts',
	                    width : 70
	                } */, {
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
	    document.location = _BasePath + 'comm/news/article?id=' + id + "&colSym=NEWS_GG&colTitle="
	            + encodeURI ("公告")+"&template="
	            + encodeURI ("NEWS_GG");
    }
    //删除方法
    function onDel (id) {
	    layer.confirm ('确定要删除该记录？', {
		    btn : [
		            '确定', '取消'
		    ]
	    //按钮
	    }, function () {
		    $.post ("comm/news/del", {
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
		    $.post ("comm/news/update", {
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
		    $.post ("comm/news/update", {
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
	        keyword : $ ("#keyword").val (),
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
	    $ ("#keyword").val ("");
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
					id="title" value="" type="text" /> 
				<input style="display:none;" class="form-control input-sm" id="keyword" value=""
					type="text" /> <label for="createdByName">发布人</label> <input
					class="form-control input-sm" id="createdByName" value=""
					type="text" /> <select id="stts"
					name="stts" style="width:100px;display:none;" class="form-control select2">
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
				<li class="active">公告管理</li>
			</ol>
		</div>
		<table id="grid"></table>
		<div id="pager" style="height:35px;"></div>
	</div>
</body>
</html>
