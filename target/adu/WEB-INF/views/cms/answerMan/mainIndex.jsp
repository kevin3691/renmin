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
	        url : "cms/answerMan/list?itemId=${itemId}",
	        height : document.body.clientHeight - 130,
	        rownumbers : true,
	        colModel : [
	                {
	                    label : '内容',
	                    name : 'answerCont',
	                    index : 'answerCont',
	                    width : 150
	                }, {
	                    label : '调查项标题',
	                    name : 'itemTitle',
	                    index : 'itemTitle',
	                    sortable : false,
	                    width : 150,
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
	                '100%', '100%'
	        ],
	        content : 'cms/answerMan/edit?itemId=${itemId}&id=' + id //iframe的url
	    });
    }
    //添加完成后执行方法
    function onSaveOk (entity) {
	    $ ("#grid").trigger ("reloadGrid");
	    layer.closeAll ();
    }
    //删除
    function onDel (id) {
	    layer.confirm ('确定要删除答案？', {
		    btn : [
		            '确定', '取消'
		    ]
	    //按钮
	    }, function () {
		    $.post ("cms/answerMan/del", {
			    id : id
		    }, function () {
			    $ ("#grid").trigger ("reloadGrid");
		    });
		    layer.closeAll ();
	    });
    }
    //Iframe中点击调查主题，获取调查主题中的项
    function onSurveyTopicsSelOk (node) {
	    onQ (node.id);
    }
    //查询
    function onQ (topicId) {
	    var para = {
	    		answerCont : $ ("#answerCont").val (),
	    };
	    $ ("#grid").jqGrid ("setGridParam", {
	        page : 0,
	        postData : para
	    }).trigger ("reloadGrid");
    }
    //显示全部
    function showAll () {
	    $ ("#answerCont").val ("")
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
	<div class="container-fluid">
		<div class="breadcrumb content-header form-inline"
			style="padding:8px;">
			<div class="form-group">
				<label for="name">答案内容</label> <input class="form-control input-sm"
					id="answerCont" value="" type="text" />
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
