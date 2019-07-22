<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>新闻列表</title>
<jsp:include page="/WEB-INF/views/include/head.jsp" />
<script>
	$ (function () {
	    loadGrid ();
	    //加载select特效
	    $ (".select2").select2 ();
	    //加载日期控件
	    $ ('.inputmask').datetimepicker ({
	        minView : 0,
	        format : "yyyy-mm-dd hh:ii"
	    //时间，默认为日期时间
	    });
	    $ ('#publishAt').datetimepicker ();
	    $ ('#publishAtStart').datetimepicker ().on ('changeDate', function (ev) {
		    $ ('#publishAtEnd').datetimepicker ('setStartDate', ev.date);
	    });
	    if ("${o.id}" == "0"){
		    $ ("#publishAtStart").val (currentDateTime (false))
		    $ ('#publishAtEnd').datetimepicker ('setStartDate', $ ("#publishAtStart").val ());
	    }
	    setTimeout ("$('#publishAtStart').datetimepicker('hide')", 10)
    });
    function loadGrid () {
	    $ ("#grid").jqGrid ({
// 	        url : "cms/tag/list?colSym=${colSym}",
	        url : "cms/col/list?partWebId=${id}",
	        height : document.body.clientHeight - 100,
	        rownumbers : true,
	        colModel : [
	                {
	                    label : '栏目名',
	                    name : 'colName',
	                    index : 'colName',
	                    width : 30
	                }, {
	                    label : '栏目标示',
	                    name : 'colMark',
	                    index : 'colMark',
	                    width : 50
	                },  {
	                    label : '栏目描述',
	                    name : 'colDesc',
	                    index : 'colDesc;',
	                    width : 50
	                }, {
	                    label : '操作',
	                    name : 'id',
	                    width : 100,
	                    align : 'center',
	                    sortable : false,
	                    formatter : function (value, options, row) {
		                    var btn = "";
		                    btn += '&nbsp;<a href="javascript:toEdit(' + value + ')" title="">编辑</a>'
		                    btn += '&nbsp;<a href="javascript:onDel(' + value + ')" title="">删除</a>'
		                    return btn;
	                    }
	                }
	        ],
	        rowNum : 20,
	        rowList : [
	                20, 50, 100
	        ],
	        pager : '#pager',
	        sortname : 'top',
	        sortorder : "desc"
	    });
    }
  //执行添加方法
    function toAdd (id) {
	    var title = "添加栏目"
	    layer.open ({
	        type : 2,
	        title : title,
	        shadeClose : true,
	        shade : 0.8,
	        area : [
	                '800px', '300px'
	        ],
// 	        content : '/lb-cms/cms/col/toAdd' //iframe的url
	        content : '/lb-cms/cms/col/toAdd?partWebId=${id}'  
	    });
    }
    //删除方法
    function onDel (id) {
	    layer.confirm ('确定要删除栏目？', {
		    btn : [
		            '确定', '取消'
		    ]
	    //按钮
	    }, function () {
		    $.post ("cms/col/del", {
			    id : id
		    }, function () {
			    $ ("#grid").trigger ("reloadGrid");
		    });
		    layer.closeAll ();
	    });
    }
    function toEdit (id) {
	    id = id || 0;
	    var title = "编辑栏目"
	    layer.open ({
	        type : 2,
	        title : title,
	        shadeClose : true,
	        shade : 0.8,
	        area : [
	                '800px', '300px'
	        ],
// 	        content : '/lb-cms/cms/col/edit?id=' + id + ''//iframe的url
	        content : '/lb-cms/cms/col/edit?id=' + id + '&partWebId=${id}'  
	    });
    }
    //添加成功后执行的方法
    function onSaveOk (entity) {
	    $ ("#grid").trigger ("reloadGrid");
	    layer.closeAll ();
    }
    //查询
    function onQ (id) {
	    var para = {
	        id : id,
	        title : $ ("#title").val (),
	        status : $ ("#status").val (),
	        source : $ ("#source").val (),
	        publishAtStart : $ ("#publishAtStart").val (),
	        publishAtEnd : $ ("#publishAtEnd").val ()
	    };
	    $ ("#grid").jqGrid ("setGridParam", {
		    postData : para
	    }).trigger ("reloadGrid");
    }
    //置顶方法
    function onTop (id, top) {
	    $.post ("cms/news/top", {
	        id : id,
	        top : 1
	    }, function () {
		    $ ("#grid").trigger ("reloadGrid");
		    confirm ("");
	    });
    }
</script>


</head>

<body>
<ul class="nav nav-tabs">
   <li class="active"><a  >${colTitle} - 列表</a></li>
</ul>
	<div class="container-fluid">
		<div class="breadcrumb content-header form-inline"
			style="padding:8px;">
			<div class="form-group">
				<button class="btn btn-info" id="btnAdd" type="button"
					onclick="toAdd()">添加</button>
			</div>
		</div>
		<table id="grid"></table>
		<div id="pager" style="height:35px;"></div>
	</div>
</body>
</html>
