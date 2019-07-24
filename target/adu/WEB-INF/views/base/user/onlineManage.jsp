<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>在线用户管理</title>
<jsp:include page="/WEB-INF/views/include/head.jsp" />
<script>

	var _ORGID = 0;
	var _ORGNUM = 0;
	//装载表格
    function loadGrid () {
	    $ ("#grid").jqGrid ({
	        url : "base/user/getOnlineUser",
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
	                    label : '登录IP',
	                    name : 'recordInfo.clientIP',
	                    index : 'recordInfo.clientIP',
	                    width : 60
	                }, {
	                    label : ' ',
	                    name : 'id',
	                    width : 110,
	                    align : 'center',
	                    sortable : false,
	                    formatter : function (value, options, row) {
		                    var btn = "";
		                    btn += '&nbsp;<a href="javascript:onOffline(\'' + row.keySN + '\')" title="">强制退出</a>'
		                   
		                    return btn;
	                    }
	                },{
	                    name : 'keySN',
	                    hidden : true
	                }
	        ],
	        rowNum : 20,
	        rowList : [
	                20, 40, 60
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
    
   
    //删除
    function onOffline (sessionid) {
	    parent.layer.confirm ('确定要将此用户注销吗？', {
		    btn : [
		            '确定', '取消'
		    ]
	    //按钮
	    }, function () {
		    $.post ("base/user/offline", {
		    	sessionid : sessionid
		    }, function () {
			    $ ("#grid").trigger ("reloadGrid");
		    });
		    parent.layer.closeAll ();
	    });
    }
    
    //Iframe中点击ORG时获取ORGID，查询该机构下的人员
    function onOrgNodeClick (node) {
    	_ORGID = node.id;
    	_ORGNUM = node.userCount;
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
			</ol>
		</div>
		<div class="row">
		<div class="col-sm-2 no-padding">
				<div class="box box-default collapsed-box box-solid">
            <div class="box-header with-border">
              <h3 class="box-title"><i
							class="fa fa-bank"></i>机构列表</h3>

              <div class="box-tools pull-right">
              
              </div>
            </div>
            <iframe scrolling="no" id="ifrmQdb"
							style="width: 100%; height: 100%;" frameborder="0"
							src="base/org/list4"></iframe>
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
