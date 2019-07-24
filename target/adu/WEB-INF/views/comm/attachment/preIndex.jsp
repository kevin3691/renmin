<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>附件--预览列表</title>
<jsp:include page="/WEB-INF/views/include/head4.jsp" />
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path;
%>
<script>
	$ (function () {
	    loadGrid ();
    });
    function loadGrid () {
	    $ ("#grid").jqGrid ({
	        url : "comm/attachment/list",
	        height : document.body.clientHeight - 110,
	        rownumbers : true,
	        colModel : [
	                {
	                    label : ' ',
	                    name : 'icon',
	                    sortable : false,
	                    width : 30,
	                    formatter : function (value, options, row) {
		                    return "<i class='"+value+"'></i>";
	                    }
	                }, {
	                    label : '标题',
	                    name : 'title',
	                    index : 'title',
	                    sortable : false,
	                    width : 200
	                }, {
	                    label : '类别',
	                    name : 'category',
	                    index : 'category',
	                    sortable : false,
	                    width : 90
	                }, {
	                    label : '依附于',
	                    name : 'applyTo',
	                    index : 'applyTo',
	                    sortable : false,
	                    width : 60
	                }, {
	                    label : '文件地址',
	                    name : 'filePath',
	                    index : 'filePath',
	                    sortable : false,
	                    width : 120
	                }, {
	                    label : '文件大小',
	                    name : 'fileSize',
	                    index : 'fileSize',
	                    sortable : false,
	                    width : 80,
	                    formatter : function (value, options, row) {
		                    return commafy (value / 1024) + "KB";
	                    }
	                }, {
	                    label : '上传时间',
	                    name : 'createdAt',
	                    index : 'createdAt',
	                    sortable : false,
	                    width : 130,
	                    formatter : function (value, options, row) {
		                    return jsonDateTimeFormatter (row.recordInfo.createdAt, 2);
	                    }
	                }, {
	                    label : '上传人',
	                    name : 'createdByName',
	                    index : 'createdByName',
	                    sortable : false,
	                    width : 60,
	                    formatter : function (value, options, row) {
		                    return row.recordInfo.createdByName;
	                    }
	                }, {
	                    label : ' ',
	                    name : 'id',
	                    width : 130,
	                    align : 'center',
	                    sortable : false,
	                    formatter : function (value, options, row) {
		                    var btn = "";
		                    btn += '&nbsp;<a href="javascript:onShow(\''+ row.fileUrl +'\')" title="">查看</a>'
		                    btn += '&nbsp;<a href="<%=basePath%>'+ row.fileUrl +'" title=""  target= "_blank">下载</a>'
		                    btn += '&nbsp;<a href="javascript:onSave(' + value + ')" title="">编辑</a>'
		                    btn += '&nbsp;<a href="javascript:onDel(' + value + ')" title="">删除</a>'
		                    return btn;
	                    }
	                }
	        ],
	        rowNum : 100,
	        rowList : [
	                100, 200, 300
	        ],
	        pager : '#pager',
	        sortname : 'id',
	        sortorder : "asc",
	    });
    }
    function onSave (id, pid) {
	    id = id || 0;
	    pid = pid || 0;
	    var title = "添加附件"
	    layer.open ({
	        type : 2,
	        title : title,
	        shadeClose : true,
	        shade : 0.8,
	        area : [
	                '800', '450'
	        ],
	        content : 'comm/attachment/edit?id=' + id + "&parentId=" + pid //iframe的url
	    });
    }
    function onSaveOk (entity) {
	    layer.closeAll ();
	    $ ("#grid").trigger ("reloadGrid");
    }
      //查看
   function onShow(url) {
		var path="<%=basePath%>";
		url = path + url;
		window.open(url, "att", "")
	}
	function onDel(id) {
		layer.confirm('确定要删除该附件？', {
			btn : [ '确定', '取消' ]
		//按钮
		}, function() {
			$.post("comm/attachment/del", {
				id : id
			}, function() {
				$("#grid").trigger("reloadGrid");
			});
			layer.closeAll();
		});
	}
	function onSort(id, order) {
		$.post("comm/attachment/sort", {
			id : id,
			order : order
		}, function() {
			$("#grid").trigger("reloadGrid");
		});
	}
	//查询
	function onQ() {
		var para = {
			title : ""
		};
		$("#grid").jqGrid("setGridParam", {
			postData : para
		}).trigger("reloadGrid");
	}
	//显示全部
	function showAll() {
		$("#title").val("");
		onQ();
	}
	function onUpload(flag) {
		flag = flag || "";
		var title = "上传附件";
		var url = 'comm/attachment/upload';
		if (flag == "preview") {
			url = 'comm/attachment/preUpload';
		} else if (flag == "corpper") {
			url = 'comm/attachment/cropUpload';
		}
		layer.open({
			type : 2,
			title : title,
			shadeClose : true,
			shade : 0.8,
			area : [ '800', '450' ],
			content : url
		//iframe的url
		});
	}
	//上传完附件后执行
	function onUploadFinished() {
		onQ();
	}
	$(function() {
	})
</script>
</head>

<body>
	<div class="container-fluid">
		<ul class="nav nav-tabs">
			<li><a href="comm/attachment/index">附件列表</a></li>
			<li class="active"><a href="comm/attachment/preIndex">预览列表</a></li>
			<li><a href="comm/attachment/testIndex">测试引用附件</a></li>
		</ul>
		<div class="breadcrumb content-header form-inline">
			<button class="btn btn-info" id="btnAdd" type="button"
				onclick="onSave()">添加附件</button>
			<button class="btn btn-info" id="btnUpload" type="button"
				onclick="onUploadFinished()">上传</button>
			<button class="btn btn-info" id="btnUpload" type="button"
				onclick="onUpload('preview')">上传(预览)</button>
			<button class="btn btn-info" id="btnUpload" type="button"
				onclick="onUpload('corpper')">上传(裁剪)</button>
			<ol class="breadcrumb">
				<li><a href="home/dashboard"><i class="fa fa-dashboard"></i>
						首页</a></li>
				<li class="active">预览列表</li>
			</ol>
		</div>
		<table id="grid" style="height:35px;"></table>
	</div>
</body>
</html>
