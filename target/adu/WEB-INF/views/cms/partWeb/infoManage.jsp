<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>网站信息管理</title>
<jsp:include page="/WEB-INF/views/include/head.jsp" />
<script>
	$ (function () {
	    loadGrid ();
// 	    loadColGrid();
    });
	function loadColGrid(){
		 $ ("#colGrid").jqGrid ({
// 			 url : "cms/col/list",
			url : "cms/col/list?partWebId=${id}",
	        height : document.body.clientHeight - 100,
	        rownumbers : false,
	        colModel : [
	                {
	                    label : '栏目名称',
	                    name : 'colName',
	                    index : 'colName',
	                    align : 'center',
	                    width : 400,
	                    formatter : function (value, options, row) {
		                    var btn = "";
		                    btn += '&nbsp;<a href="javascript:toSelNews(' + row['id'] + ')" title="">' + value + '</a>'
		                    return btn;
	                    }
	                }
		        ],
	        sortname : 'publishAt',
	        sortorder : "desc"
		 })
	}
	function getQueryString(name) { 
		var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i"); 
		var r = window.location.search.substr(1).match(reg); 
		if (r != null) return unescape(r[2]); return null; 
	} 
    function loadGrid () {
    	var colSym = getQueryString("colSym");
    	if(colSym==null){
    		colSym = "";
    	}
	    $ ("#grid").jqGrid ({
// 	        url : "cms/tag/list?colSym=${colSym}",
// 	        url : "cms/news/list",
// 	        url : "cms/news/list?id=${id}",
	        url : "cms/news/list?id=${id}&colSym="+colSym,
	        height : document.body.clientHeight - 100,
	        rownumbers : true,
	        colModel : [
		                {
		                    label : '标题',
		                    name : 'title',
		                    index : 'title',
		                    width : 30
		                }, {
		                    label : '发布时间',
		                    name : 'publishAt',
		                    index : 'publishAt',
		                    width : 50,
		                    formatter : function (v) {
			                    return jsonDateTimeFormatter (v, 1)
		                    }
		                }, {
		                    label : '关键字',
		                    name : 'keyword',
		                    index : 'keyword',
		                    width : 50
		                }, {
		                    label : '操作',
		                    name : 'id',
		                    width : 100,
//	 	                    align : 'center',
		                    sortable : false,
		                    formatter : function (value, options, row) {
		                    	var isPublish = row['isPublish'];
			                    var btn = "";
			                    btn += '&nbsp;<a href="javascript:onDel(' + value + ')" title="">删除</a>'
			                    btn += '&nbsp;<a href="javascript:toEdit(' + value + ')" title="">编辑</a>'
			                    btn += '&nbsp;<a href="javascript:moveUp(' + value + ')" title="">上移</a>'
			                    btn += '&nbsp;<a href="javascript:moveDown(' + value + ')" title="">下移</a>'
			                    btn += '&nbsp;<a href="javascript:stick(' + value + ')" title="">置顶</a>'
			                   
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
    function onDel (value) {
    	console.log("onDel"+value);
   	  layer.confirm ('确定要删除栏目？', {
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
    function toEdit (value) {
    	console.log("toEdit"+value);
    }
    function moveUp (value) {
    	console.log("moveUp"+value);
    }
    function moveDown (value) {
    	console.log("moveDown"+value);
    }
    function stick (value) {
    	console.log("stick"+value);
    }
    //点击左侧树形菜单，根据树形菜单中栏目id查询，其下的新闻
    function toSelNews (value) {
    	var para = {colSym : value};//根据栏目id查询新闻
	    $ ("#grid").jqGrid ("setGridParam", {
		    postData : para
	    }).trigger ("reloadGrid");
    }
    function onAdd () {
// 	    id = id || 0;
		var partWebSym = document.getElementById("partWebSym").value;
	    var title = "添加新闻"
	    layer.open ({
	        type : 2,
	        title : title,
	        shadeClose : true,
	        shade : 0.8,
	        offset : ['80px' , '15%'],
	        area : [
	                '800px', '560px'
	        ],
// 	        content : '/lb-cms/cms/news/add?partWebSym='+partWebSym
	        content : '/lb-cms/cms/news/add?partWebId='+partWebSym
	    });
    }
    //添加成功后执行的方法
    function onSaveOk (entity) {
	    $ ("#grid").trigger ("reloadGrid");
	    layer.closeAll ();
    }
</script>


</head>

<body>
<ul class="nav nav-tabs">
   <li class="active"><a >${cmsPartWeb.webName}  信息管理</a></li>
</ul>
	
	
	<div class="container-fluid">
		<div class="breadcrumb content-header form-inline"
			style="padding:8px;">
			<div class="form-group">
				<button class="btn btn-info" id="btnAdd" type="button" onclick="onAdd()">添加</button>
				<input type="hidden" id="partWebSym" name="partWebSym" value="${cmsPartWeb.id}">
			</div>
		</div>
		<div class="row">
			
			<div class="col-sm-11">
				<table id="grid"></table>
				<div id="pager" style="height:35px;"></div>
			</div>
		</div>

	</div>
</body>
</html>
