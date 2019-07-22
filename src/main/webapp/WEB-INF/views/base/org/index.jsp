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
	                url : "base/org/list",
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
	                            label : '机构代码',
	                            name : 'sym',
	                            index : 'sym',
	                            sortable : false,
	                            width : 100
	                        },
	                        {
	                            label : '法人代表',
	                            name : 'legalRepresentative',
	                            index : 'legalRepresentative',
	                            sortable : false,
	                            width : 70
	                        },
	                        {
	                            label : '联系人',
	                            name : 'contactPerson',
	                            index : 'contactPerson',
	                            sortable : false,
	                            width : 60
	                        },
	                        {
	                            label : '电话',
	                            name : 'phone',
	                            index : 'phone',
	                            sortable : false,
	                            width : 100
	                        },
	                        {
	                            label : ' ',
	                            name : 'id',
	                            width : 260,
	                            align : 'center',
	                            sortable : false,
	                            formatter : function (value, options, row) {
		                            var btn = "";
		                            btn = '<a href="javascript:onSave(0,' + row.id + ')" title="">添加下级</a>'
		                            btn += '&nbsp;<a href="javascript:onSave(0,' + row.baseTree.parentId
		                                    + ')" title="">添加本级</a>'
		                            btn += '&nbsp;<a href="javascript:onSave(' + value + ')" title="">编辑</a>'
		                            btn += '&nbsp;<a href="javascript:onSort(' + value + ',\'up\',\''
		                                    + row.baseTree.path + '\')" title="">上移</a>'
		                            btn += '&nbsp;<a href="javascript:onSort(' + value + ',\'down\',\''
		                                    + row.baseTree.path + '\')" title="">下移</a>'
		                            btn += '&nbsp;<a href="javascript:onDel(' + value + ',\'' + row.baseTree.path
		                                    + '\')" title="">删除</a>'
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
	                //以下TreeGrid字段
	                treeGrid : true,
	                ExpandColumn : "name",
	                ExpandColClick : true,
	                gridComplete : treeExpand
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
    function onSave (id, pid) {
	    id = id || 0;
	    pid = pid || 0;
	    var title = "添加机构"
	    if (id > 0){
		    title = "编辑机构"
	    }
	    layer.open ({
	        type : 2,
	        title : title,
	        shadeClose : true,
	        shade : 0.8,
	        area : [
	                '800', '550'
	        ],
	        content : 'base/org/edit?id=' + id + "&parentId=" + pid //iframe的url
	    });
    }
    //添加完成后执行方法
    function onSaveOk (entity) {
	    _expandPath = entity.baseTree.path;
	    $ ("#grid").trigger ("reloadGrid");
	    layer.closeAll ();
    }
    //删除
    function onDel (id, path) {
	    layer.confirm ('确定要删除该机构？', {
		    btn : [
		            '确定', '取消'
		    ]
	    //按钮
	    }, function () {
		    $.post ("base/org/del", {
			    id : id
		    }, function () {
			    _expandPath = path;
			    $ ("#grid").trigger ("reloadGrid");
		    });
		    layer.closeAll ();
	    });
    }
    //排序
    function onSort (id, order, path) {
	    $.post ("base/org/sort", {
	        id : id,
	        order : order
	    }, function () {
		    _expandPath = path;
		    $ ("#grid").trigger ("reloadGrid");
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
				onclick="onSave()">添加根节点</button>
			<ol class="pull-right breadcrumb">
				<li><a href="home/dashboard"><i class="fa fa-dashboard"></i>
						首页</a></li>
				<li class="active">机构管理</li>
			</ol>
		</div>
		<table id="grid"></table>
	</div>
</body>
</html>
