<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>系统日志--列表</title>
<jsp:include page="/WEB-INF/views/include/head.jsp" />
<script>
    //装载表格
    function loadGrid () {
	    $ ("#grid").jqGrid ({
	        url : "base/log/list",
	        postData: { category:"系统日志" },
	        height : document.body.clientHeight - 130,
	        rownumbers : true,
	        colModel : [
	                {
	                    label : '类别',
	                    name : 'category',
	                    index : 'category',
	                    sortable : false,
	                    width : 100
	                }, {
	                    label : '标题',
	                    name : 'title',
	                    index : 'title',
	                    sortable : false,
	                    width : 220
	                }
	                ,{
	                    label : '操作人',
	                    name : 'recordInfo.createdByName',
	                    index : 'recordInfo.createdByName',
	                    sortable : false,
	                    width : 60
	                },{
	                    label : '发生时间',
	                    name : 'recordInfo.createdAt',
	                    index : 'recordInfo.createdAt',
	                    sortable : false,
	                    width : 100,
	                    formatter:function(value,options,row)
	                    {
	                    	return jsonDateTimeFormatter(value,2);
	                    }
	                }, {
	                    label : ' ',
	                    name : 'id',
	                    width : 100,
	                    align : 'center',
	                    sortable : false,
	                    formatter : function (value, options, row) {
		                    var btn = "";
		                    btn += '&nbsp;<a href="javascript:onDtl(' + value + ')" title="">查看</a>'
		                    btn += '&nbsp;<a href="javascript:onDel(' + value + ')" title="">删除</a>';
		                    btn += '&nbsp;<a href="javascript:onSort(' + value + ',\'up\')" title="">上移</a>'
		                    btn += '&nbsp;<a href="javascript:onSort(' + value + ',\'down\')" title="">下移</a>'
		                    return btn;
	                    }
	                }
	        ],
	        rowNum : 20,
	        rowList : [
	                20, 50, 100
	        ],
	        pager : '#pager',
	        sortname : 'id',
	        sortorder : "desc"
	    });
	    jQuery ("#grid").jqGrid ('bindKeys', {
	        "onEnter" : function (rowid) {
		        //alert ("你enter了一行， id为:" + rowid)
	        },
	        "onRightKey" : function (rowid) {
	        },
	        "onLeftKey" : function (rowid) {
	        },
	        "onSpace" : function (rowid) {
	        }
	    });
    }
  
    //编辑
    function onDtl (id) {
	    id = id || 0;
	    var title = "日志详细"
	    layer.open ({
	        type : 2,
	        title : title,
	        shadeClose : true,
	        shade : 0.8,
	        area : [
	                '800', '350'
	        ],
	        content : 'base/log/dtl?id=' + id //iframe的url
	    });
    }
    //编辑完成后回调函数
    function onSaveOk () {
	    layer.closeAll ();
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
		    $.post ("base/log/del", {
			    id : id
		    }, function () {
			    $ ("#grid").trigger ("reloadGrid");
		    });
		    layer.closeAll ();
	    });
    }
    //排序	
    function onSort (id, order) {
	    $.post ("base/log/sort", {
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
	        descr : $ ("#descr").val (),
	        startAt : $ ("#startAt").val (),
	        endAt : $ ("#endAt").val (),
	        personName : $ ("#personName").val ()
	    };
	    $ ("#grid").jqGrid ("setGridParam", {
		    postData : para
	    }).trigger ("reloadGrid");
    }
    //显示全部
    function showAll () {
	    $ ("#title").val ("");
	    $ ("#descr").val ("");
	    $ ("#startAt").val ("");
	    $ ("#endaAt").val ("");
	    $ ("#personName").val ("");
	    onQ ();
    }
    $ (function () {
	    $ ('#startAt').datetimepicker ({
	    	 minView : 3
	    });
	    $ ('#endAt').datetimepicker ({
		    minView : 3
	    });
	    loadGrid ();
    });
    
</script>
</head>

<body>
	<div class="container-fluid">
	<ul class="nav nav-tabs" style="padding-top:10px;">
			<li><a href="base/log/index">日志列表</a></li>
			<li class="active"><a href="base/log/systemIndex">系统日志</a></li>
			<li style="float:right;"><div>
					<button class="btn btn-info" id="btnUpload" type="button"
						onclick="onClearAll()">全部删除</button>
					<button class="btn btn-info" id="btnPerUpload" type="button"
						onclick="onClearQuery()">删除查询结果</button>
				</div></li>
		</ul>
		<div class="breadcrumb content-header form-inline"
			style="padding:8px;">
			<label for="title">标题</label> <input class="form-control input-sm"
					id="title" value="" style="width:100px;" type="text" /> <label
					for="descr">备注</label> <input class="form-control input-sm"
					id="descr" style="width:80px;" value="" type="text" />
				<label for="sizeFrom">时间</label>
				<div class="input-group">
					<input class="form-control input-sm" id="startAt" name="startAt"
						style="width:90px;" type="text" />
					<div class="input-group-addon">
						<i class="fa fa-calendar"
							onclick="$('#startAt').datetimepicker('show');"></i>
					</div>
				</div>
				至
				<div class="input-group">
					<input class="form-control input-sm" id="endAt" name="endAt"
						style="width:90px;" type="text" />
					<div class="input-group-addon">
						<i id="endAt" class="fa fa-calendar"
							onclick="$('#endAt').datetimepicker('show');"></i>
					</div>
				</div>
				<label for="personName">操作人</label> <input
					class="form-control input-sm" id="personName" value=""
					style="width:70px;" type="text" />

			<div class="form-group">
				<button class="btn btn-info" id="btnAdd" type="button"
					onclick="onQ()">查询</button>
			</div>
			<div class="form-group">
				<button class="btn btn-info" id="btnShowAll" type="button"
					onclick="showAll()">显示全部</button>
			</div>
			<ol class="breadcrumb">
				<li><a href="home/dashboard"><i class="fa fa-dashboard"></i>
						首页</a></li>
				<li class="active">日志管理</li>
			</ol>
		</div>
		<table id="grid"></table>
		<div id="pager" style="height:35px;"></div>
	</div>
</body>
</html>
