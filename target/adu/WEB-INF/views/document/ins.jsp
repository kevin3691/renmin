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
	        url : "document/listIns",
	        postData : {
	        	actorId : "${baseUserId}",
	        	yesNo : "${yesNo}"
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
	                },{
	                    label : '办理人',
	                    name : 'actorName',
	                    index : 'actorName',
	                    width : 80
	                }, {
	                    label : '状态',
	                    name : 'yesNo',
	                    index : 'yesNo',
	                    sortable : false,
	                    width : 50,
	                    formatter : function (value, options, row) {
		                    return value == "yes" ? '办结' : '<span style="color:gray;">办理中</span>'
	                    }
	                },{
	                    label : ' ',
	                    name : 'id',
	                    width : 120,
	                    align : 'center',
	                    sortable : false,
	                    formatter : function (value, options, row) {
		                    var btn = "";
		                    if(row.yesNo != "yes")
		                    {
		                    	btn += '&nbsp;<a href="javascript:onSave(\'' + row.actUrl + '\',' + row.refNum + ','+ row.stepId +')" title="">办理</a>'
		                    }else{
		                    	btn += '&nbsp;<a href="javascript:onDtl(' + row.refNum + ')" title="">查看</a>&nbsp;'
		                    }
		                    if(row.stepId == 1 && row.yesNo != "yes")
		                    {
		                    	btn += '&nbsp;<a href="javascript:onDel(' + row.refNum + ')" title="">删除</a>&nbsp;'
		                    }
		                    
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
	        sortname : 'id',
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
    function onSave (actUrl,refNum,stepId) {
    	actUrl = actUrl || "";
    	refNum = refNum || 0;
    	stepId = stepId || 0;
	    var title = "添加文档"
	    if (refNum > 0){
		    title = "编辑文档"
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
	    document.location = actUrl + '?id=' + refNum + '&stepId=' + stepId + '&colTitle=' + encodeURI("${category}");
    }
    
    function onDtl (refNum) {
    	refNum = refNum || 0;
	    var title = "查看公文"
	    document.location = 'document/dtl?id=' + refNum
    }
    //添加完成后执行方法
    function onSaveOk (entity) {
	    $ ("#grid").trigger ("reloadGrid");
	    layer.closeAll ();
    }
    //删除
    function onDel (refNum) {
	    layer.confirm ('确定要删除文档？', {
		    btn : [
		            '确定', '取消'
		    ]
	    //按钮
	    }, function () {
		    $.post ("document/delIns", {
			    refNum : refNum
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
