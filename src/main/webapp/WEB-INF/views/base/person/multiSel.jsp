<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>人员--多选</title>
<jsp:include page="/WEB-INF/views/include/head4.jsp" />
<script>
	var _SELEDROWS = [];
    function loadGrid () {
	    $ ("#grid").jqGrid ({
	        url : "base/person/list",
	        postData : {
		        isActive : 1
	        },
	        height : document.body.clientHeight - 130,
	        rownumbers : true,
	        multiselect : true,
	        colModel : [
	                {
	                    label : '姓名',
	                    name : 'name',
	                    index : 'name',
	                    width : 60
	                }, {
	                    label : '单位',
	                    name : 'baseOrgName',
	                    index : 'baseOrgName',
	                    width : 120
	                }, {
	                    label : '编号',
	                    name : 'sym',
	                    index : 'sym',
	                    width : 60
	                }, {
	                    label : '性别',
	                    name : 'legalRepresentative',
	                    index : 'legalRepresentative',
	                    width : 40
	                }, {
	                    label : '职务',
	                    name : 'title',
	                    index : 'title',
	                    width : 100
	                }, {
	                    name : 'baseOrgId',
	                    hidden : true
	                }, {
	                    name : 'id',
	                    hidden : true
	                }, {
	                    name : 'lineNo',
	                    hidden : true
	                }, {
	                    name : 'phone',
	                    hidden : true
	                }, {
	                    name : 'email',
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
	    var tmp = '<div class="btn-group"><button type="button" class="btn btn-default">$NAME$</button><button onclick="onDelSeled($ID$)" class="btn btn-default" type="button">&times;</button></div>'
	    $.each (_SELEDROWS, function (i, v) {
		    $ ("#seled").append (
		            '<li id="'+v.id+'" style="float:left;list-style:none;padding:3px 3px 3px 0px;">'
		                    + tmp.replace ("$NAME$", v.name).replace ("$ID$", v.id) + '</li>');
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
	        name : $ ("#name").val (),
	        sym : $ ("#sym").val ()
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
	    loadGrid ();
    });
</script>
</head>

<body>
	<div class="container-fluid">
		<div class="breadcrumb content-header form-inline"
			style="padding:8px;">
			<div class="form-group">
				<label for="name">姓名</label> <input class="form-control input-sm"
					id="name" value="" type="text" />
			</div>
			<div class="form-group">
				<label for="sym">编号</label> <input class="form-control input-sm"
					id="sym" value="" type="text" />
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
