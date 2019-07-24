<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>数据字典--选择</title>
<jsp:include page="/WEB-INF/views/include/head.jsp" />
<link rel="stylesheet" href="jslib/ztree/css/metroStyle/metroStyle.css"
	type="text/css">
<script src="jslib/ztree/js/jquery.ztree.all.min.js"></script>

<script>
	$ (document).ready (function () {
	    $.post ("base/dict/listBySym", {
	        sym : "${sym}",
	        nodeid : -1,//-1查出所有记录
	        isActive : 1
	    //只显示启用的记录
	    }, function (rslt) {
		    $.fn.zTree.init ($ ("#tree"), {
		        data : {
			        key : {
				        name : "title"
			        }
		        },
		        callback : {
		            //单击节点事件之前
		            beforeClick : function (treeId, treeNode, clickFlag) {
		            	//检查是否限制只选择叶子节点
				        if ("${leafOnly}" == "1" && treeNode.isParent){
					        layer.msg ("当前设置只允许选择叶子节点")
					        return false;
				        }
				        return true;
		            },
		            //单击节点事件
		            onClick : function (event, treeId, treeNode, clickFlag) {
			            if (parent.onSelDictOk){
				            parent.onSelDictOk (treeNode,"${sym}");
			            }
			            if (parent.onDictSelOk){
				            parent.onDictSelOk (treeNode,"${sym}");
			            }
		            }
		        }
		    }, rslt.rows);
		    //如果只有一个根节点则展开
		    var treeObj = $.fn.zTree.getZTreeObj ("tree");
		    var nodes = treeObj.getNodes ();			  
		    treeObj.selectNode(nodes[0])
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
