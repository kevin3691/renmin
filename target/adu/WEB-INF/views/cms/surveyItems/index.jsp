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
	        url : "cms/surveyItems/list",
	        height : document.body.clientHeight - 130,
	        rownumbers : true,
	        colModel : [
	                {
	                    label : '标题',
	                    name : 'itemTitle',
	                    index : 'itemTitle',
	                    width : 150
	                }, {
	                    label : '调查主题标题',
	                    name : 'topicTitle',
	                    index : 'topicTitle',
	                    sortable : false,
	                    width : 150,
	                },  {
	                    label : '调查项类型',
	                    name : 'itemType',
	                    index : 'itemType',
	                    width : 50
	                }, {
	                    label : ' ',
	                    name : 'id',
	                    width : 120,
	                    align : 'center',
	                    sortable : false,
	                    formatter : function (value, options, row) {
		                    var btn = "";
		                    btn += '&nbsp;<a href="javascript:onSave(' + value + ')" title="">编辑</a>';
		                    btn += '&nbsp;<a href="javascript:onDel(' + value + ')" title="">删除</a>&nbsp;';
		                    btn += '&nbsp;<a href="javascript:answer(' + value + ')" title="">添加答案</a>'
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
    function answer (id) {
	    var title = "添加答案"
	    layer.open ({
	        type : 2,
	        title : title,
	        shadeClose : true,
	        shade : 0.8,
	        area : [
	                '800', '400'
	        ],
	        content : 'cms/answerMan/mainIndex?itemId=' + id //iframe的url
	    });
    }
    //保存
    function onSave (id) {
	    id = id || 0;
	    var title = "添加调查项"
	    if (id > 0){
		    title = "编辑调查项"
	    }
	    layer.open ({
	        type : 2,
	        title : title,
	        shadeClose : true,
	        shade : 0.8,
	        area : [
	                '800', '350'
	        ],
	        content :  'cms/surveyItems/edit?id=' + id + '&topicId=' + $("#topicId").val()//iframe的url
	    });
    }
    //添加完成后执行方法
    function onSaveOk (entity) {
	    $ ("#grid").trigger ("reloadGrid");
	    layer.closeAll ();
    }
    //删除
    function onDel (id) {
	    layer.confirm ('确定要删除调查项？', {
		    btn : [
		            '确定', '取消'
		    ]
	    //按钮
	    }, function () {
		    $.post ("cms/surveyItems/del", {
			    id : id
		    }, function () {
			    $ ("#grid").trigger ("reloadGrid");
		    });
		    layer.closeAll ();
	    });
    }
    //Iframe中点击调查主题，获取调查主题中的项
    function onSurveyTopicsSelOk (node) {
    	$("#topicId").val(node.id);
	    onQ (node.id);
    }
    //查询
    function onQ (topicId) {
	    var para = {
	    		topicId : topicId,
	    		itemTitle : $ ("#itemTitle").val (),
	    };
	    $ ("#grid").jqGrid ("setGridParam", {
	        page : 0,
	        postData : para
	    }).trigger ("reloadGrid");
    }
    //显示全部
    function showAll () {
	    $ ("#itemTitle").val ("")
	    onQ (0);
	    $ ('#ifrmOrg').attr ('src', $ ('#ifrmOrg').attr ('src'));
    }
    //页面加载完成后执行
    $ (function () {
    	$ ("#ifrmOrg").height (document.body.clientHeight - 115)
	    loadGrid ();
    });
</script>
</head>

<body>
	<input type="hidden" id="topicId" />
	<div class="container-fluid">
		<div class="breadcrumb content-header form-inline"
			style="padding:8px;">
			<div class="form-group">
				<label for="name">调查项标题</label> <input class="form-control input-sm"
					id="itemTitle" value="" type="text" />
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
				<li class="active">调查项管理</li>
			</ol>
		</div>
		<div class="row">
			<div class="col-sm-2 no-padding" style="">
				<div class="nav-tabs-custom">
					<!-- Tabs within a box -->
					<ul class="nav nav-tabs pull-right ui-sortable-handle">
						<li class="pull-left header"
							style="padding-left:20px;font-size:14px;"><i
							class="fa fa-bank"></i> <b> 调查主题列表 <b></li>
					</ul>
					<div class="tab-content no-padding">
						<iframe scrolling="no" id="ifrmOrg"
							style="width: 100%; height: 300px;" frameborder="0"
							src="cms/surveyTopics/list4"></iframe>
					</div>
				</div>
			</div>
			<div class="col-sm-10">
				<table id="grid"></table>
				<div id="pager" style="height:35px;"></div>
			</div>
		</div>

	</div>
</body>
</html>
