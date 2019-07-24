<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>分类--选择</title>
<jsp:include page="/WEB-INF/views/include/head4.jsp" />
<link rel="stylesheet" href="jslib/ztree/css/metroStyle/metroStyle.css"
	type="text/css">
<script src="jslib/ztree/js/jquery.ztree.all.min.js"></script>

<script>
	$ (document).ready (function () {
	    $.post ("goodstype/list", {
	        nodeid : -1,//-1查出所有记录
	        isActive : 1
	    //只显示启用的记录
	    }, function (rslt) {
		    $.fn.zTree.init ($ ("#tree"), {
			    callback : {
				    //单击节点事件
				    onClick : function (event, treeId, treeNode, clickFlag) {
					    if (parent.onSelOrgOk){
						    parent.onSelOrgOk (treeNode);
					    }
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
</script>
</head>

<body>
	<div class="container-fluid">
		<ul id="tree" class="ztree"></ul>
	</div>
</body>
</html>
