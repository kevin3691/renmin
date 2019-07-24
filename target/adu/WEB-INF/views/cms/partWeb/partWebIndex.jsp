<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>网站列表</title>
<jsp:include page="/WEB-INF/views/include/head.jsp" />
<script>
	$ (function () {
	    loadGrid ();
    });
    function loadGrid () {
    	var partWebId = $("#partWebId").val();
	    $ ("#grid").jqGrid ({
// 	        url : "cms/tag/list?colSym=${colSym}",
	        url : "cms/partWeb/tempList?partWebId="+partWebId,
	        height : document.body.clientHeight - 100,
	        rownumbers : true,
	        colModel : [
	                {
	                    label : '模板名',
	                    name : 'name',
	                    index : 'name',
	                    width : 30
	                },  {
	                    label : '操作',
	                    name : 'uncomFilePath',//该模板文件在此子网站下的路径
	                    width : 100,
	                    sortable : false,
	                    formatter : function (value, options, row) {
	                    	var valueRep = value.replace(/\\/g, "\\\\");//路径做处理，替换其中的斜线。
		                    var btn = "";
// 		                    btn += '&nbsp;<a href="javascript:toEditTemp("' + value + '")" title="">编辑</a>'
// 		                    btn += "&nbsp;<a href=\"javascript:toEditTemp('1')\" title=\"\">编辑</a>"
		                    btn += "&nbsp;<a href=\"javascript:toEditTemp('"+valueRep+"')\" title=\"\">编辑</a>"
		                    return btn;
	                    }
	                }
	        ],
	        rowNum : 20,
	        rowList : [
	                20, 50, 100
	        ],
	        pager : '#pager'
// 	        sortname : 'Id',
// 	        sortorder : "desc"
	    });
    }
    function toInPartWeb (id) {
	    window.location.href='/lb-cms/cms/partWeb/toInPartWeb?id=' + id ;
    }
    function toEditTemp(uncomFilePath) {
//     	uncomFilePath.replace("\\", "\\\\")
	    var title = "编辑模板"
	    layer.open ({
	        type : 2,
	        title : title,
	        shadeClose : true,
	        shade : 0.8,
	        area : [
// 	                '900px', '500px'
	                '1100px', '600px'
	        ],
	        content : '/lb-cms/cms/partWeb/toEditTemp?partWebTempPath=' + uncomFilePath  
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
				'800', '300'
	        ],
	        content : '/lb-cms/cms/partWeb/toAdd' //iframe的url
	    });
    }
    //删除方法
    function onDel (id) {
	    layer.confirm ('确定要删除人员？', {
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
   <li class="active"><a >${requestScope.cmsPartWeb.webName} - 模板 - 列表</a></li>
</ul>
	<div class="container-fluid">
		<div class="breadcrumb content-header form-inline"
			style="padding:8px;">
			<div class="form-group">
			</div>
		</div>
		<table id="grid"></table>
		<div id="pager" style="height:35px;"></div>
		<input type="hidden" id="partWebId" value="${requestScope.id}">
	</div>
</body>
</html>
