<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>区域--选择</title>
<jsp:include page="/WEB-INF/views/include/head.jsp" />
<link rel="stylesheet" href="jslib/ztree/css/metroStyle/metroStyle.css"
	type="text/css">
<script src="jslib/ztree/js/jquery.ztree.all.js"></script>

<script>
	var _CategoryRows = [];
    var _AreaRows = [];
    var _SeledIdx = [];
    $ (document).ready (function () {
	    //
	    $.post ("base/dict/listBySym", {
	        nodeid : -1,
	        sym : "AREACATEGORY",
	        isActive : 1
	    //只显示启用的记录
	    }, function (rslt) {
		    _CategoryRows = rslt.rows;
		    $.post ("comm/area/list", {
		        nodeid : -1,//-1查出所有记录
		        isActive : 1
		    //只显示启用的记录
		    }, function (rslt) {
			    _AreaRows = rslt.rows;
			    genTab ();
		    })
	    })
    });
    //生成区域选项卡
    function genTab () {
	    $.each (_CategoryRows, function (idx, row) {
		    var title = row.value != null && row.value != "" ? row.value : row.title;
		    $ ("#tabs").append (
		            '<li><a aria-expanded="false" href="#'+row.sym+'" data-toggle="tab">' + title + '</a></li>');
		    $ ("#tabContents").append (
		            '<div class="tab-pane" id="'+row.sym+'"><ul id="ul'+row.sym+'" class="list-inline"></ul></div>');
	    })
	    $ ("#tabs li").eq (1).addClass ("active");
	    $ ("#tabContents div").eq (0).addClass ("active");
	    genList (0, 0);
    }
    //生成列表
    function genList (pid, ctgrIdx) {
	    $.each (_AreaRows, function (idx, row) {
		    if (row.baseTree.parentId == pid){
			    $ ("#ul" + _CategoryRows[ctgrIdx].sym).append (
			            "<li onclick='onSel(this," + row.id + "," + ctgrIdx + "," + idx + ")' style='padding:10px;'>"
			                    + row.name + "</li>")
		    }
	    })
    }
    //区域选择
    function onSel (obj, pid, ctgrIdx, idx) {
    	_SeledIdx = idx;
	    $ ("#" + _CategoryRows[ctgrIdx].sym + " li").removeClass ("btn-danger");
	    $ (obj).addClass ("btn-danger");
	    for (var i = ctgrIdx + 1; i < _CategoryRows.length; i++){
		    $ ("#ul" + _CategoryRows[i].sym).empty ();
	    }
	    if ((ctgrIdx + 1) < _CategoryRows.length){
		    $ ('.nav-tabs li:eq(' + (ctgrIdx + 2) + ') a').tab ('show');
		    genList (pid, ctgrIdx + 1);
	    }
	    //生成选择
	    var s = "";
	    $.each (_CategoryRows, function (idx, row) {
		    var v = $ ("#ul" + _CategoryRows[idx].sym + " .btn-danger").html ();
		    if (s == ""){
			    s += v != undefined ? v : "";
		    }
		    else{
			    s += v != undefined ? " / " + v : "";
		    }
	    })
	    $ ("#txtSeled").val (s);
	    return;
    }
    //选择
    function onSelOk () {
    	var row = _AreaRows[_SeledIdx];
	    var v = $ ("#txtSeled").val ();
	    if (v == ""){
		    layer.msg ("请选择区域")
	    }
	    if (parent.onAreaSelOk){
		    parent.onAreaSelOk (v,row);
	    }
	    var index = parent.layer.getFrameIndex (window.name); //先得到当前iframe层的索引
	    parent.layer.close (index); //再执行关闭   
    }
    //返回
    function onCancel () {
	    var index = parent.layer.getFrameIndex (window.name); //先得到当前iframe层的索引
	    parent.layer.close (index); //再执行关闭   
    }
</script>
</head>

<body style="background-color:#ecf0f5;">
	<div class="container-fluid">
		<div class="input-group" style="margin-top:10px;margin-bottom:5px;">
			<input id="txtSeled" class="form-control" type="text">
			<div class="input-group-btn">
				<button onclick="onSelOk()" class="btn btn-info" type="button">选
					择</button>
				<button onclick="onCancel()" class="btn btn-info" type="button">返
					回</button>
			</div>
		</div>
		<div class="nav-tabs-custom">
			<ul id="tabs" class="nav nav-tabs">
				<li class="header"><i class="fa fa-th"></i> 区域选择</li>

			</ul>
			<div id="tabContents" class="tab-content"></div>
		</div>
	</div>
</body>
</html>
