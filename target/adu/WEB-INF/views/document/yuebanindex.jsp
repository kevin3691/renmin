<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>${category }--列表</title>
<jsp:include page="/WEB-INF/views/include/head.jsp" />
<script>
	//装载表格
    function loadGrid () {
	    $ ("#grid").jqGrid ({
	        url : "document/list",
	        postData : {
	        	type : 0,
				isActive : 1
			},
	        height : document.body.clientHeight - 130,
	        rownumbers : true,
	        colModel : [
		        	{
	                    label : '类别',
	                    name : 'category',
	                    index : 'category',
	                    width : 80
	                },{
	                    label : '标题',
	                    name : 'title',
	                    index : 'title',
	                    width : 240
	                }, {
	                    label : ' ',
	                    name : 'id',
	                    width : 120,
	                    align : 'center',
	                    sortable : false,
	                    formatter : function (value, options, row) {
		                    var btn = "";
		                    btn += '&nbsp;<a href="javascript:onDtl(' + value + ')" title="">查看</a>&nbsp;'
		                    btn += '&nbsp;<a href="javascript:onSave(' + value + ')" title="">修改</a>'
		               		
		                    btn += '&nbsp;<a href="javascript:onDel(' + row.refNum + ')" title="">删除</a>&nbsp;'
		                    return btn;
	                    }
	                },{
                    	name : 'refNum',
                    	hidden : true
                    }
	        ],
	        rowNum : 20,
	        rowList : [
	                20, 50, 100
	        ],
	        pager : '#pager',
	        sortname : 'lineNo',
	        sortorder : "asc"
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
	    var title = "添加公文"
	    if (id > 0){
		    title = "编辑公文"
	    }
	    /* layer.open ({
	        type : 2,
	        title : title,
	        shadeClose : true,
	        shade : 0.8,
	        area : [
	                '800', '530'
	        ],
	        content : 'document/yueban?id=' + id //iframe的url
	    }); */
	    document.location = 'document/yueban?id=' + id
    }
    
    function onDtl (id) {
	    id = id || 0;
	    var title = "查看公文"
	    document.location = 'document/dtl?id=' + id
    }
    //添加完成后执行方法
    function onSaveOk (entity) {
	    $ ("#grid").trigger ("reloadGrid");
	    layer.closeAll ();
    }
    //删除
    function onDel (id) {
	    layer.confirm ('确定要删除公文？', {
		    btn : [
		            '确定', '取消'
		    ]
	    //按钮
	    }, function () {
		    $.post ("document/delIns", {
			    refNum : id
		    }, function () {
			    $ ("#grid").trigger ("reloadGrid");
		    });
		    layer.closeAll ();
	    });
    }
    //排序
    function onSort (id, order) {
	    $.post ("document/sort", {
	        id : id,
	        order : order
	    }, function () {
		    $ ("#grid").trigger ("reloadGrid");
	    });
    }
    //Iframe中点击ORG时获取ORGID，查询该机构下的人员
    function onOrgNodeClick (node) {
	    onQ (node.id);
    }
    //查询
    function onQ (orgid) {
	    var para = {
	        type : type,
	        title : $ ("#title").val ()
	    };
	    $ ("#grid").jqGrid ("setGridParam", {
	        page : 0,
	        postData : para
	    }).trigger ("reloadGrid");
    }
    //显示全部
    function showAll () {
	    $ ("#title").val ("");
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
				<label for="name">标题</label> <input class="form-control input-sm"
					id="name" value="" type="text" />
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
			<ol class="pull-right breadcrumb">
				<li><a href="home/dashboard"><i class="fa fa-dashboard"></i>
						首页</a></li>
				<li class="active">${category }管理</li>
			</ol>
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
