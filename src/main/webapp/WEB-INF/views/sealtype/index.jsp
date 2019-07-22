<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>组织机构--列表</title>
<jsp:include page="/WEB-INF/views/include/head4.jsp" />
<script>
	//tree
    var _expandPath = "";
    //生成表格
    function loadGrid () {
	    $ ("#grid").jqGrid (
	            {
	                url : "sealtype/list",
	                height : document.body.clientHeight - 100,
	                fitColumns : true,
	                //rownumbers : true,
	                colModel : [
	                        {
	                            label : '名称',
	                            name : 'name',
	                            index : 'name',
	                            sortable : false,
	                            width : 300
	                        },
	                        {
	                            label : '状态',
	                            name : 'isActive',
	                            index : 'isActive',
	                            sortable : false,
	                            width : 50,
	                            formatter : function (value, options, row) {
		                            return value == 1 ? '使用中' : '<span style="color:gray;">已停用</span>'
	                            }
	                        },
	                        {
	                            label : ' ',
	                            name : 'id',
	                            width : 260,
	                            align : 'center',
	                            sortable : false,
	                            formatter : function (value, options, row) {
		                            var btn = "";
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
	                //pager : '#pager',
	                sortname : 'lineNo',
	                sortorder : "asc",
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
    //编辑
    function onSave (id) {
	    id = id || 0;
	    var title = "添加公章类型"
	    if (id > 0){
		    title = "编辑公章类型"
	    }
	    layer.open ({
	        type : 2,
	        title : title,
	        shadeClose : true,
	        shade : 0.8,
	        area : [
	                '800', '300'
	        ],
	        content : 'sealtype/edit?id=' + id  //iframe的url
	    });
    }
    //添加完成后执行方法
    function onSaveOk (entity) {
	    $ ("#grid").trigger ("reloadGrid");
	    layer.closeAll ();
    }
    //删除
    function onDel (id, path) {
	    layer.confirm ('确定要删除该公章类型？', {
		    btn : [
		            '确定', '取消'
		    ]
	    //按钮
	    }, function () {
		    $.post ("sealtype/del", {
			    id : id
		    }, function () {
			    $ ("#grid").trigger ("reloadGrid");
		    });
		    layer.closeAll ();
	    });
    }
    
    //页面加载完成后执行
    $ (function () {
	    loadGrid ();
    });
</script>
</head>

<body>
	<div class="container-fluid">
		<div class="breadcrumb content-header form-inline"
			style="padding:8px;">
			<button class="btn btn-info" id="btnAdd" type="button"
				onclick="onSave()">添加</button>
			<ol class="pull-right breadcrumb">
				<li><a href="home/dashboard"><i class="fa fa-dashboard"></i>
						首页</a></li>
				<li class="active">公章类型</li>
			</ol>
		</div>
		<table id="grid"></table>
	</div>
</body>
</html>
