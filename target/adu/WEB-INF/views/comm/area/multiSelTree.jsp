<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>区域--多选</title>
<jsp:include page="/WEB-INF/views/include/head.jsp" />
<link rel="stylesheet" href="jslib/ztree/css/metroStyle/metroStyle.css"
	type="text/css">
<script src="jslib/ztree/js/jquery.ztree.all.js"></script>

<script>
	$ (document).ready (function () {
	    $.post ("comm/area/listBySym", {
	        sym : "${sym}",
	        nodeid : -1,//-1查出所有记录
	        isActive : 1
	    //只显示启用的记录
	    }, function (rslt) {
		    $.fn.zTree.init ($ ("#tree"), {
		        data : {
			        key : {
				        name : "name"
			        }
		        },
		        check : {
		            enable : true,
		            chkStyle : "checkbox",
		            chkboxType : {
		                "Y" : "s",
		                "N" : "ps"
		            }
		        }
		    }, rslt.rows);
		    //如果只有一个根节点则展开
		    var treeObj = $.fn.zTree.getZTreeObj ("tree");
		    var nodes = treeObj.getNodes ();
		    if (nodes.length == 1){
			    //打开指定节点会导致框架页布局错乱，暂时用打开所有节点
			    //treeObj.expandNode(nodes[0], true);
			    treeObj.expandAll (true);
		    }
	    })
    });
    //选择
    function onSelOk () {
	    var treeObj = $.fn.zTree.getZTreeObj ("tree");
	    var nodes = treeObj.getCheckedNodes (true);
	    if (parent.onAreaSelOk){
		    parent.onAreaSelOk (nodes);
	    }
    }
</script>
</head>

<body>
	<div class="container-fluid">
		<div class="breadcrumb pull-right" style="padding:0px;">
			<button class="btn btn-info" id="btnAdd" type="button"
				onclick="onSelOk()">选择</button>
		</div>
		<ul id="tree" class="ztree"></ul>
	</div>
</body>
</html>
