<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>人员管理--列表</title>
<jsp:include page="/WEB-INF/views/include/head.jsp" />
<script>
	//装载表格
    function loadGrid () {
	    $ ("#grid").jqGrid ({
	        url : "cms/surveyTopics/list",
	        height : document.body.clientHeight - 130,
	        rownumbers : true,
	        colModel : [
	                {
	                    label : '标题',
	                    name : 'topicTitle',
	                    index : 'topicTitle',
	                    width : 150
	                }, {
	                    label : '状态',
	                    name : 'isActive',
	                    index : 'isActive',
	                    sortable : false,
	                    width : 50,
	                    formatter : function (value, options, row) {
		                    return value == 1 ? '使用中' : '<span style="color:gray;">已停用</span>'
	                    }
	                }, {
	                    label : '起始时间',
	                    name : 'startTime',
	                    index : 'startTime',
	                    width : 50,
	                    formatter : function (value, options, row) {
		                    return jsonDateTimeFormatter(value,0);
	                    }
	                }, {
	                    label : '终止时间',
	                    name : 'endTime',
	                    index : 'endTime',
	                    width : 50,
	                    formatter : function (value, options, row) {
		                    return jsonDateTimeFormatter(value,0);
	                    }
	                },  {
	                    label : ' ',
	                    name : 'id',
	                    width : 120,
	                    align : 'center',
	                    sortable : false,
	                    formatter : function (value, options, row) {
		                    var btn = "";
		                    btn += '&nbsp;<a href="javascript:onSave(' + value + ')" title="">编辑</a>'
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
	        sortname : 'id',
	        sortorder : "desc"
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
    //保存
    function onSave (id) {
	    id = id || 0;
	    var title = "添加调查主题"
	    if (id > 0){
		    title = "编辑调查主题"
	    }
	    layer.open ({
	        type : 2,
	        title : title,
	        shadeClose : true,
	        shade : 0.8,
	        area : [
	                '800', '350'
	        ],
	        content : 'cms/surveyTopics/edit?id=' + id //iframe的url
	    });
    }
    //添加完成后执行方法
    function onSaveOk (entity) {
	    $ ("#grid").trigger ("reloadGrid");
	    layer.closeAll ();
    }
    //删除
    function onDel (id) {
	    layer.confirm ('确定要删除调查主题？', {
		    btn : [
		            '确定', '取消'
		    ]
	    //按钮
	    }, function () {
		    $.post ("cms/surveyTopics/del", {
			    id : id
		    }, function () {
			    $ ("#grid").trigger ("reloadGrid");
		    });
		    layer.closeAll ();
	    });
    }
    //查询
    function onQ (orgid) {
	    var para = {
	    	topicTitle : $ ("#topicTitle").val (),
	    };
	    $ ("#grid").jqGrid ("setGridParam", {
	        page : 0,
	        postData : para
	    }).trigger ("reloadGrid");
    }
    //显示全部
    function showAll () {
	    $ ("#topicTitle").val ("");
	    onQ (0);
    }
    //页面加载完成后执行
    $ (function () {
    	$ ("#ifrmOrg").height (document.body.clientHeight - 115)
	    loadGrid ();
    });
</script>
</head>

<body>
	<div class="container-fluid">
		<div class="breadcrumb content-header form-inline"
			style="padding:8px;">
			<div class="form-group">
				<label for="name">调查主题标题</label> <input class="form-control input-sm"
					id="topicTitle" value="" type="text" />
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
				<li class="active">调查主题管理</li>
			</ol>
		</div>
		<div class="row">
			<div class="col-sm-12">
				<table id="grid"></table>
				<div id="pager" style="height:35px;"></div>
			</div>
		</div>

	</div>
</body>
</html>
