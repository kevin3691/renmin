<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>网站列表</title>
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
	        url : "cms/partWeb/list",
	        height : document.body.clientHeight - 100,
	        rownumbers : true,
	        colModel : [
	                {
	                    label : '网站名称',
	                    name : 'webName',
	                    index : 'webName',
	                    width : 30
	                }, {
	                    label : '网站标示',
	                    name : 'webMark',
	                    index : 'webMark',
	                    width : 30
	                }, {
	                    label : '网站描述',
	                    name : 'webDesc',
	                    index : 'webDesc',
	                    width : 30
	                }, {
	                    label : '操作',
	                    name : 'id',
	                    width : 100,
// 	                    align : 'center',
	                    sortable : false,
	                    formatter : function (value, options, row) {
	                    	var isPublish = row['isPublish'];
		                    var btn = "";
		                    var colSym='${colSym}';
		                    var colTitle='${colTitle}';
		                    if(colSym === "wzgl_lmgl"){//如果是网站管理下的栏目管理
		                    	 btn += '&nbsp;<a href="javascript:toManPartWebCol(' + value + ')" title="">管理</a>'
// 		                    	 btn += '&nbsp;<a href="javascript:toManPartWebCol(' + row + ')" title="">管理</a>'
		                    }else if(colSym === "wzgl_zdgl"){//如果是网站管理下的站点管理
		                    	 if(isPublish != 1){//未发布，可以编辑
					                    btn += '&nbsp;<a href="javascript:toEdit(' + value + ')" title="">编辑</a>'
				                    }
				                    btn += '&nbsp;<a href="javascript:onDel(' + value + ')" title="">删除</a>'
				                    btn += '&nbsp;<a href="javascript:toInPartWeb(' + value + ')" title="">进入</a>'
// 				                    btn += '&nbsp;<a href="javascript:toInfoManage(' + value + ')" title="">信息管理</a>'
				                    btn += '&nbsp;<a href="javascript:onPublish(' + value + ')" title="">发布</a>'
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
	        sortname : 'top',
	        sortorder : "desc"
	    });
    }
    //跳转到子网站中，显示、编辑选中的模板
    function toInPartWeb (id) {
	    window.location.href='/lb-cms/cms/partWeb/toInPartWeb?id=' + id ;
    }
    //跳转到子网站,栏目管理页面。
    function toManPartWebCol (id) {
	    window.location.href='/lb-cms/cms/partWeb/toManPartWebCol?id=' + id ;
    }
  //跳转到子网站中，管理其下的新闻信息
    function toInfoManage (id) {
	    window.location.href='/lb-cms/cms/partWeb/toInfoManage?id=' + id ;
    }
    function toEdit (id) {
	    id = id || 0;
	    var title = "编辑子网站"
	    layer.open ({
	        type : 2,
	        title : title,
	        shadeClose : true,
	        shade : 0.8,
	        area : [
	                '800px', '300px'
	        ],
	        content : '/lb-cms/cms/partWeb/toEdit?id=' + id + ''//iframe的url
	    });
    }
    //发布网站
    function onPublish (id) {
//     	 $.post ('cms/partWeb/publishPartWeb', {id:id}, function (result) {
    	 $.post ('cms/partWeb/publishPartWeb', {partWebId:id}, function (result) {
    		 layer.alert('发布成功');
    		 $ ("#grid").trigger ("reloadGrid");
  	    });
    }
   
  //执行添加方法
    function onAdd (id) {
	    var title = "添加子网站"
	    layer.open ({
	        type : 2,
	        title : title,
	        shadeClose : true,
	        shade : 0.8,
	        area : [
				'800', '350'
	        ],
	        content : '/lb-cms/cms/partWeb/toAdd' //iframe的url
	    });
    }
    //删除方法
    function onDel (id) {
	    layer.confirm ('确定要删除网站？', {
		    btn : [
		            '确定', '取消'
		    ]
	    //按钮
	    }, function () {
		    $.post ("cms/partWeb/del", {
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
    //查询
    function onQ (id) {f
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
</script>


</head>

<body>
<ul class="nav nav-tabs">
   <li class="active"><a >${colTitle} - 列表</a></li>
</ul>
	<div class="container-fluid">
		<div class="breadcrumb content-header form-inline"
			style="padding:8px;">
			<div class="form-group">
			<c:if test="${colSym=='wzgl_zdgl'}">
				<button class="btn btn-info" id="btnAdd" type="button"
					onclick="onAdd()">添加</button>
			</c:if>
			</div>
		</div>
		<table id="grid"></table>
		<div id="pager" style="height:35px;"></div>
	</div>
</body>
</html>
