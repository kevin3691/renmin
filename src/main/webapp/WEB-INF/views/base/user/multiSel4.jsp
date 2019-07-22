<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>用户--多选</title>
<jsp:include page="/WEB-INF/views/include/head.jsp" />
<script>
	var _SELEDROWS = [];
    function loadGrid () {
	    $ ("#grid").jqGrid ({
	        url : "base/user/list",
	        postData : {
		        isActive : 1,
		        baseRoleName: "${baseRoleName}"
	        },
	        height : document.body.clientHeight - 130,
	        rownumbers : true,
	        multiselect : true,
	        colModel : [
	                {
	                    label : '用户名',
	                    name : 'username',
	                    index : 'username',
	                    width : 40
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
	                    name : 'baseOrgId',
	                    hidden : true
	                }, {
	                    name : 'basePersonId',
	                    hidden : true
	                }, {
	                    name : 'lineNo',
	                    hidden : true
	                }, {
	                    name : 'id',
	                    hidden : true
	                }
	        ],
	        rowNum : 20,
	        rowList : [
	                20, 50, 100
	        ],
	        pager : '#pager',
	        sortname : 'lineNo',
	        sortorder : "asc",
	        onSelectAll : function (ids, status) {
		        $.each (ids, function (i, v) {
			        var row = $ ("#grid").jqGrid ("getRowData", v);
			        if (status){
				        pushArr (row);
			        }
			        else{
				        spliceArr (row)
			        }
		        })
		        sortArr ();
		        genSeledList ();
	        },
	        onSelectRow : function (rowid, status) {
		        var row = $ ("#grid").jqGrid ("getRowData", rowid);
		        //如果是选中，则判断重复后加入数组,撤销选中则从数组中移除
		        if (status){
			        pushArr (row);
		        }
		        else{
			        spliceArr (row)
		        }
		        sortArr ();
		        genSeledList ();
	        },
	        loadComplete:function(xhr){
	        	$.each(_SELEDROWS, function (i, v) {
	        		$ ("#grid").jqGrid ("setSelection", v.id)
                });
	        }
	    });
    }
    //放置入选中数组
    function pushArr (row) {
	    var flag = true;
	    $.each (_SELEDROWS, function (i, v) {
		    if (v.id == row.id){
			    flag = false;
			    return false;
		    }
	    })
	    if (flag){
		    _SELEDROWS.push (row);
	    }
    }
    //从选中数组中删除
    function spliceArr (row) {
	    $.each (_SELEDROWS, function (i, v) {
		    if (v.id == row.id){
			    _SELEDROWS.splice (i, 1);
			    return false;
		    }
	    })
    }
    //选中数组排序
    function sortArr () {
	    //按序号为选择人员排序
	    _SELEDROWS.sort (function (a, b) {
		    return a.lineNo - b.lineNo
	    })
    }
    //生成权限列表
    function genSeledList () {
	    $ ("#seled").empty ();
	    var tmp = '<div class="btn-group" title="$USERNAME$"><button type="button" class="btn btn-default">$PERSONNAME$</button><button onclick="onDelSeled($ID$)" class="btn btn-default" type="button">&times;</button></div>'
	    $.each (_SELEDROWS, function (i, v) {
		    $ ("#seled").append (
		            '<li id="'+v.id+'" style="float:left;list-style:none;padding:3px 3px 3px 0px;">'
		                    + tmp.replace ("$PERSONNAME$", v.basePersonName).replace ("$ID$", v.id).replace (
		                            "$USERNAME$", v.username) + '</li>');
	    })
	    //设置grid高度随选中行高度变化，但不低于260
	    var h = document.body.clientHeight - 130 - $ ("#seled").height ();
	    if (h > 260){
		    $ ("#grid").jqGrid ("setGridHeight", h);
		    $ ("#ifrmOrg").height (document.body.clientHeight - 115 - $ ("#seled").height ());
	    }
    }
    //删除权限
    function onDelSeled (id) {
	    $.each (_SELEDROWS, function (i, v) {
		    if (v.id == id){
			    _SELEDROWS.splice (i, 1);
			    return false;
		    }
	    })
	    //清除已选项显示
	    $ ("#" + id).remove ();
	    //清除Grid选择状态
	    $ ("#grid").jqGrid ('setSelection', id);
    }
    //Iframe中点击ORG时获取ORGID，查询该机构下的人员
    function onOrgNodeClick (node) {
	    onQ (node.id);
    }
    //查询
    function onQ (orgid) {
	    var para = {
	        baseOrgId : orgid,
	        username : $ ("#username").val (),
	        basePersonName : $ ("#personName").val (),
	    };
	    $ ("#grid").jqGrid ("setGridParam", {
	        page : 0,
	        postData : para
	    }).trigger ("reloadGrid");
    }
    //显示全部
    function showAll () {
	    $ ("#name").val ("");
	    $ ("#sym").val ("")
	    onQ (0);
	    $ ('#ifrmOrg').attr ('src', $ ('#ifrmOrg').attr ('src'));
    }
    //选择
    function onSelOk () {
    	if (parent.onUserSelOk){
		    parent.onUserSelOk (_SELEDROWS);
	    }
    	
    }
    $ (function () {
	    $ ("#ifrmOrg").height (document.body.clientHeight - 115)
	    /* $.each ("${userList}", function (i, v) {
	    	pushArr(v)
	    }) */
	    loadGrid ();
    });
</script>
</head>

<body>
	<div class="container-fluid">
		<div class="breadcrumb content-header form-inline"
			style="padding:8px;">
			<div class="form-group">
				<label for="username">用户名</label> <input
					class="form-control input-sm" id="username" value="" type="text" />
			</div>
			<div class="form-group">
				<label for="personName">姓名</label> <input
					class="form-control input-sm" id="personName" value="" type="text" />
			</div>
			<div class="form-group">
				<label for="orgName">单位</label> <input class="form-control input-sm"
					id="orgName" value="" type="text" />
			</div>
			<div class="form-group">
				<button class="btn btn-info" id="btnAdd" type="button"
					onclick="onQ()">查询</button>
			</div>
			<div class="form-group">
				<button class="btn btn-info" id="btnShowAll" type="button"
					onclick="showAll()">显示全部</button>
			</div>
			&nbsp;
			<div class="form-group">
				<button class="btn btn-info" id="btnOnSel" type="button"
					onclick="onSelOk()">选择</button>
			</div>
		</div>
		<div id="seled" class="row bg-info" style="padding-left:15px;"></div>
		<div class="row">
			<div class="col-sm-3 no-padding" style="">
				<div class="nav-tabs-custom">
					<!-- Tabs within a box -->
					<ul class="nav nav-tabs pull-right ui-sortable-handle">
						<li class="pull-left header"
							style="padding-left:20px;font-size:14px;"><i
							class="fa fa-bank"></i> <b> 机构列表 <b></li>
					</ul>
					<div class="tab-content no-padding">
						<iframe scrolling="auto" id="ifrmOrg"
							style="width: 100%; height: 300px;" frameborder="0"
							src="base/org/list4"></iframe>
					</div>
				</div>
			</div>
			<div class="col-sm-9">
				<table id="grid"></table>
				<div id="pager" style="height:35px;"></div>
			</div>
		</div>
	</div>
</body>
</html>
