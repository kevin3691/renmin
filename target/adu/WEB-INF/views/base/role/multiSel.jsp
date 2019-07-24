<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>考生组--多选</title>
<jsp:include page="/WEB-INF/views/include/head.jsp" />
<script>
	var _SELEDROWS = [];
    function loadGrid () {
	    $ ("#grid").jqGrid ({
	        url : "base/role/list",
	        postData : {
	        	category : "temp",
		        isActive : 1
	        },
	        height : document.body.clientHeight - 130,
	        rownumbers : true,
	        multiselect : true,
	        colModel : [
	        	 {
	                    label : '名称',
	                    name : 'title',
	                    index : 'title',
	                    width : 100
	                }, {
	                    label : '状态',
	                    name : 'isActive',
	                    index : 'isActive',
	                    sortable : false,
	                    width : 40,
	                    formatter : function (value, options, row) {
		                    return value == 1 ? '使用中' : '<span style="color:gray;">已停用</span>'
	                    }
	                }, {
	                    label : '用户数量',
	                    name : 'userIds',
	                    index : 'userIds',
	                    width : 80,
	                    formatter : function (value, options, row) {
		                    if (value != null && value != ""){
			                    var ar = value.split (",");
			                    return ar.length + " 人";
			                    ;
		                    }
		                    return 0 + " 人";
	                    }
	                }, {
	                    name : 'id',
	                    hidden : true
	                }, {
	                    name : 'lineNo',
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
		        /* var row = $ ("#grid").jqGrid ("getRowData", rowid);
		        //如果是选中，则判断重复后加入数组,撤销选中则从数组中移除
		        if (status){
			        pushArr (row);
		        }
		        else{
			        spliceArr (row)
		        }
		        onSelOk(); */
		        //sortArr ();
		        //genSeledList ();
		        var row = $("#grid").jqGrid("getRowData", rowid);
				if (parent.onAttendSelOk) {
					parent.onAttendSelOk(row);
				}
				var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
				parent.layer.close(index); //再执行关闭   
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
	    var tmp = '<div class="btn-group"><button type="button" class="btn btn-default">$NAME$</button><button onclick="onDelSeled($ID$)" class="btn btn-default" type="button">&times;</button></div>'
	    $.each (_SELEDROWS, function (i, v) {
		    $ ("#seled").append (
		            '<li id="'+v.id+'" style="float:left;list-style:none;padding:3px 3px 3px 0px;">'
		                    + tmp.replace ("$NAME$", v.title).replace ("$ID$", v.id) + '</li>');
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
    function onQ () {
	    var para = {
	    	title : $ ("#title").val (),
	    };
	    $ ("#grid").jqGrid ("setGridParam", {
	        page : 0,
	        postData : para
	    }).trigger ("reloadGrid");
    }
    //显示全部
    function showAll () {
	    $ ("#title").val ("");
	    onQ ();
    }
    //选择
    function onSelOk () {
	    if (parent.onAttendSelOk){
		    parent.onAttendSelOk (_SELEDROWS);
	    }
    }
    $ (function () {
	    loadGrid ();
    });
</script>
</head>

<body>
	<div class="container-fluid">
		<div class="breadcrumb content-header form-inline"
			style="padding:8px;">
			<div class="form-group">
				<label for="title">标题</label> <input class="form-control input-sm"
					id="title" value="" type="text" />
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
			<ol class="pull-right breadcrumb">
				<li><a href="home/dashboard"><i class="fa fa-dashboard"></i>
						首页</a></li>
				<li class="active">选择考生组</li>
			</ol>
		</div>
		<div id="seled" class="row bg-info" style="padding-left:15px;"></div>
		<div class="row">
			<div class="col-sm-12">
				<table id="grid"></table>
				<div id="pager" style="height:35px;"></div>
			</div>
		</div>
	</div>
</body>
</html>
