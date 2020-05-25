<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>用户管理--列表</title>
<jsp:include page="/WEB-INF/views/include/head4.jsp" />
<script>
	//装载表格
    function loadGrid () {
	    $ ("#grid").jqGrid ({
	        url : "base/user/list",
	        height : document.body.clientHeight - 130,
	        rownumbers : true,
	        colModel : [
	                {
	                    label : '用户名',
	                    name : 'username',
	                    index : 'username',
	                    width : 40
	                }, {
	                    label : '状态',
	                    name : 'isActive',
	                    index : 'isActive',
	                    sortable : false,
	                    width : 30,
	                    formatter : function (value, options, row) {
		                    return value == 1 ? '使用中' : '<span style="color:gray;">已停用</span>'
	                    }
	                }, {
	                    label : '姓名',
	                    name : 'basePersonName',
	                    index : 'basePersonName',
	                    width : 40
	                }, {
	                    label : '单位',
	                    name : 'baseOrgName',
	                    index : 'baseOrgName',
	                    width : 100
	                }, {
	                    label : '角色',
	                    name : 'baseRoleName',
	                    index : 'baseRoleName',
	                    width : 60
	                }, {
	                    label : ' ',
	                    name : 'id',
	                    width : 110,
	                    align : 'center',
	                    sortable : false,
	                    formatter : function (value, options, row) {
		                    var btn = "";
		                    btn += '&nbsp;<a href="javascript:onSave(' + value + ')" title="">编辑</a>'
		                    btn += '&nbsp;<a href="javascript:onSort(' + value + ',\'up\')" title="">上移</a>'
		                    btn += '&nbsp;<a href="javascript:onSort(' + value + ',\'down\')" title="">下移</a>'
		                    btn += '&nbsp;<a href="javascript:onDel(' + value + ')" title="">删除</a>'
		                    btn += '&nbsp;<a href="javascript:onKeySet(' + value + ')" title="">设置加密锁</a>'
		                    return btn;
	                    }
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
    //编辑
    function onSave (id) {
	    id = id || 0;
	    var title = "添加用户"
	    if (id > 0){
		    title = "编辑用户"
	    }
	    layer.open ({
	        type : 2,
	        title : title,
	        shadeClose : true,
	        shade : 0.8,
	        area : [
	                '80%', '80%'
	        ],
	        content : 'base/user/edit?id=' + id //iframe的url
	    });
    }
    //设置加密锁
    function onKeySet (id) {
	    id = id || 0;
	    var title = "设置加密锁"
	    layer.open ({
	        type : 2,
	        title : title,
	        shadeClose : true,
	        shade : 0.8,
	        area : [
	                '800', '410'
	        ],
	        content : 'base/user/etKeySet?id=' + id //iframe的url
	    });
    }
    //添加完成后执行方法
    function onSaveOk (entity) {
	    $ ("#grid").trigger ("reloadGrid");
	    layer.closeAll ();
    }
    //删除
    function onDel (id) {
	    layer.confirm ('确定要删除该用户？', {
		    btn : [
		            '确定', '取消'
		    ]
	    //按钮
	    }, function () {
		    $.post ("base/user/del", {
			    id : id
		    }, function () {
			    $ ("#grid").trigger ("reloadGrid");
		    });
		    layer.closeAll ();
	    });
    }
    //排序
    function onSort (id, order) {
	    $.post ("base/user/sort", {
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
	        baseOrgId : orgid,
	        basePersonName : $ ("#basePersonName").val (),
	        username : $ ("#username").val ()
	    };
	    $ ("#grid").jqGrid ("setGridParam", {
	        page : 0,
	        postData : para
	    }).trigger ("reloadGrid");
    }
    //显示全部
    function showAll () {
	    $ ("#basePersonName").val ("")
	    $ ("#username").val ("")
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
				<label for="basePersonName">姓名</label> <input
					class="form-control input-sm" id="basePersonName" value=""
					type="text" />
			</div>
			<div class="form-group">
				<label for="username">用户名</label> <input
					class="form-control input-sm" id="username" value="" type="text" />
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
				<li class="active">用户管理</li>
				<button type="button" class="btn btn-danger" onclick="javascrtpt:window.location.href='seal/index5'">返回</button>

			</ol>
		</div>
		<div class="row">
			<div class="col-sm-2 no-padding" style="">
				<div class="nav-tabs-custom">
					<!-- Tabs within a box -->
					<ul class="nav nav-tabs pull-right ui-sortable-handle">
						<li class="pull-left header"
							style="padding-left:20px;font-size:14px;"><i
							class="fa fa-bank"></i> <b> 机构列表 <b></li>
					</ul>
					<div class="tab-content no-padding">
						<iframe scrolling="no" id="ifrmOrg"
							style="width: 100%; height: 300px;" frameborder="0"
							src="base/org/list4"></iframe>
					</div>
				</div>
			</div>
			<div class="col-sm-10">
				<table id="grid"></table>
				<div id="pager" style="height:35px;"></div>
			</div>
		</div>
	</div>
</body>
</html>
