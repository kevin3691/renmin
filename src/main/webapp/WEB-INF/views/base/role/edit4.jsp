<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<jsp:include page="/WEB-INF/views/include/head.jsp" />
<title>角色-编辑</title>
<script type="text/javascript">
	var powerIds = [];
    var powerTitles = [];
    var powerSyms = [];
    var menuIds = [];
    var userIds = [];
    var userNames = [];
    var personIds = [];
    var personNames = [];
    function onSave () {
	    //表单验证
	    if (!$ ('#mainForm').validate ().form ()){
		    return false;
	    }
	    $ ("#category").val("temp");
	    var para = $ ("#mainForm").serialize ();
	    $.post ('base/role/save', $ ("#mainForm").serialize (), function (result, status) {
		    /* if (parent.onSaveOk){
			    parent.onSaveOk (result.entity)
		    } */
		    document.location = "base/role/index4";
	    });
    }
    function onCancel () {
	   /*  var index = parent.layer.getFrameIndex (window.name); //先得到当前iframe层的索引
	    parent.layer.close (index); //再执行关闭    */
    	document.location = "base/role/index4";
    }
    //选择权限
    function onSelPurPower () {
	    var title = "选择权限"
	    layer.open ({
	        type : 2,
	        title : title,
	        shadeClose : true,
	        shade : 0.8,
	        area : [
	                '820', '90%'
	        ],
	        content : 'base/power/multiSel'
	    });
    }
    //选择权限回调方法
    function onPowerSelOk (nodes) {
	    layer.closeAll ();
	    initPowers ();
	    $.each (nodes, function (i, node) {
		    if (node.baseTree.isLeaf == 0)
			    return true;
		    if (powerIds.indexOf (node.id.toString ()) == -1){
			    powerIds.push (node.id);
			    powerTitles.push (node.title);
			    powerSyms.push (node.sym);
			    if ($.inArray (node.baseMenuId, menuIds) == -1){
				    menuIds.push (node.baseMenuId);
			    }
		    }
	    })
	    setPowers ();
	    genPurPowerList ()
    }
    //从FORM获取权限初始值
    function initPowers () {
	    if ($ ("#purPowerIds").val () != ""){
		    powerIds = $ ("#purPowerIds").val ().split (",");
		    powerSyms = $ ("#purPowerSyms").val ().split (",");
		    powerTitles = $ ("#purPowerTitles").val ().split (",");
		    menuIds = $ ("#purMenuIds").val ().split (",");
	    }
    }
    //为FORM权限赋值
    function setPowers () {
	    $ ("#purPowerIds").val (powerIds);
	    $ ("#purPowerTitles").val (powerTitles);
	    $ ("#purPowerSyms").val (powerSyms);
	    $ ("#purMenuIds").val (menuIds);
    }
    //生成权限列表
    function genPurPowerList () {
	    $ ("#purPowerList .item").remove ();
	    initPowers ();
	    var tmp = '<div class="btn-group"><button type="button" class="btn btn-default">$TITLE$</button><button onclick="onDelPurPower($ID$)" class="btn btn-default" type="button">&times;</button></div>'
	    $.each (powerIds, function (i, id) {
		    if (id == "")
			    return true;
		    $ ("#purPowerList .sel").before (
		            '<li class="item" id="purPower'+id+'" style="float:left;list-style:none;padding:3px 3px 3px 0px;">'
		                    + tmp.replace ("$TITLE$", powerTitles[i]).replace ("$ID$", id) + '</li>');
	    })
    }
    //删除权限
    function onDelPurPower (id) {
	    initPowers ();
	    var idx = powerIds.indexOf (id.toString ());
	    if (idx >= 0){
		    powerIds.splice (idx, 1);
		    powerTitles.splice (idx, 1);
		    powerSyms.splice (idx, 1);
		    setPowers ();
	    }
	    $ ("#purPower" + id).remove ();
    }
    //清除所有权限
    function onClearPowers () {
	    powerIds = [];
	    powerTitles = [];
	    powerSyms = [];
	    setPowers ();
	    $ ("#purPowerList .item").remove ();
    }
    //选择用户
    function onSelUser () {
	    var title = "选择用户"
	    layer.open ({
	        type : 2,
	        title : title,
	        shadeClose : true,
	        shade : 0.8,
	        area : [
	                '90%', '90%'
	        ],
	        content : 'base/user/multiSel4?baseRoleName=参赛人员"'
	    });
    }
    //选择权限回调方法
    function onUserSelOk (rows) {
	    layer.closeAll ();
	    initUsers ();
	    $.each (rows, function (i, row) {
		    if (userIds.indexOf (row.id.toString ()) == -1){
			    userIds.push (row.id);
			    userNames.push (row.username);
			    personIds.push (row.basePersonId);
			    personNames.push (row.basePersonName);
		    }
	    })
	    setUsers ();
	    genUserList ();
    }
    //从FORM获取用户初始值
    function initUsers () {
	    if ($ ("#userIds").val () != ""){
		    userIds = $ ("#userIds").val ().split (",");
		    userNames = $ ("#userNames").val ().split (",");
		    personIds = $ ("#personIds").val ().split (",");
		    personNames = $ ("#personNames").val ().split (",");
	    }
    }
    //为FORM用户赋值
    function setUsers () {
	    $ ("#userIds").val (userIds);
	    $ ("#userNames").val (userNames);
	    $ ("#personIds").val (personIds);
	    $ ("#personNames").val (personNames);
    }
    //生成用户列表
    function genUserList () {
	    $ ("#userList .item").remove ();
	    initUsers ();
	    var tmp = '<div class="btn-group" title="$USERNAME$"><button type="button" class="btn btn-default">$PERSONNAME$</button><button onclick="onDelUser($ID$)" class="btn btn-default" type="button">&times;</button></div>'
	    $.each (userIds, function (i, v) {
		    $ ("#userList .sel").before (
		            '<li class="item" id="user'+v+'" style="float:left;list-style:none;padding:3px 3px 3px 0px;">'
		                    + tmp.replace ("$USERNAME$", userNames[i]).replace ("$PERSONNAME$", personNames[i])
		                            .replace ("$ID$", v) + '</li>');
	    })
    }
    //删除用户
    function onDelUser (id) {
	    initUsers ();
	    var idx = userIds.indexOf (id.toString ());
	    if (idx >= 0){
		    userIds.splice (idx, 1);
		    userNames.splice (idx, 1);
		    personIds.splice (idx, 1);
		    personNames.splice (idx, 1);
		    setUsers ();
	    }
	    $ ("#user" + id).remove ();
    }
    //清除所有用户
    function onClearUsers () {
	    userIds = [];
	    userNames = [];
	    personIds = [];
	    personNames = [];
	    setUsers ();
	    $ ("#userList .item").remove ();
    }
    $ (function () {
	    if ("${o.id}" > 0){
		    var v = ${o.isActive}
		    $ ("#isActive").val (v);
		    genPurPowerList ();
		    genUserList ();
	    }
    })
</script>
</head>

<body>
	<div class="container-fluid">
		<div>&nbsp;</div>
		<form id="mainForm" class="form-horizontal">
		<input type="hidden" id="category" name="category" value="${o.category}" />
			<input type="hidden" id="id" name="id" value="${o.id}" /> <input
				type="hidden" id="lineNo" name="lineNo" value="${o.lineNo}" />
			<jsp:include page="/WEB-INF/views/include/recordinfo.jsp" />
			<div class="form-group">
				<label class="col-md-1 control-label" for="title">标题</label>
				<div class="col-md-5">
					<input class="form-control" id="title" name="title"
						value="${o.title}" type="text" required />
				</div>
			</div>
			<div class="form-group" style= "display:none">
				<label class="col-md-1 control-label" for="title">页面</label>
				<div class="col-md-11">
					<input class="form-control" id="homeSet" name="homeSet"
						value="${o.homeSet}" type="text"  />
				</div>
				
			</div>
			<div class="form-group" style= "display:none">
				<label class="col-md-1 control-label" for="purPowerTitles">权限</label>
				<div class="col-md-11">
					<input type="hidden" id="purPowerIds" name="purPowerIds"
						value="${o.purPowerIds}" /> <input type="hidden"
						id="purPowerTitles" name="purPowerTitles"
						value="${o.purPowerTitles}" /> <input type="hidden"
						id="purPowerSyms" name="purPowerSyms" value="${o.purPowerSyms}" />
					<input type="hidden" id="purMenuIds" name="purMenuIds"
						value="${o.purMenuIds}" /> <input type="hidden" id="purMenus"
						name="purMenus" value="${o.purMenus}" />
					<ul id="purPowerList" class="list-group">
						<li class="sel" style="float:left;list-style:none;padding:3px 3px 3px 0px;">
							<button class="btn btn-info btn-flat" type="button"
								onclick="onSelPurPower()">选择</button>
							<button class="btn btn-danger btn-flat" type="button"
								onclick="onClearPowers ()">清除</button>
						</li>
					</ul>

				</div>
			</div>
			<div class="form-group">
				<label class="col-md-1 control-label" for="userNames">用户</label>
				<div class="col-md-11">
					<input type="hidden" id="userIds" name="userIds"
						value="${o.userIds}" /> <input type="hidden" id="userNames"
						name="userNames" value="${o.userNames}" /> <input type="hidden"
						id="personIds" name="personIds" value="${o.personIds}" /> <input
						type="hidden" id="personNames" name="personNames"
						value="${o.personNames}" />
					<ul id="userList" class="list-group">
						<li class="sel" style="float:left;list-style:none;padding:3px 3px 3px 0px;">
							<button class="btn btn-info btn-flat" type="button"
								onclick="onSelUser()">选择</button>
							<button class="btn btn-danger btn-flat" type="button"
								onclick="onClearUsers()">清除</button>
						</li>
					</ul>

				</div>
			</div>
			<div class="form-group">
				<label class="col-md-1 control-label" for="isActive">状态</label>
				<div class="col-md-5">
					<select id="isActive" name="isActive" class="form-control select2">
						<option value=1>启用</option>
						<option value=0>停用</option>
					</select>
				</div>
			</div>
			<div class="form-group">
				<label class="col-md-1 control-label" for="descr">备注</label>
				<div class="col-md-11">
					<textarea class="form-control" id="descr" name="descr" rows=2>${o.descr}</textarea>
				</div>
			</div>
			<div class="form-group controls" style="text-align:center">
				<button type="button" class="btn btn-info" onclick="onSave()">保存</button>
				&nbsp;&nbsp;
				<button type="button" class="btn btn-danger" onclick="onCancel()">返回</button>
			</div>
		</form>

	</div>
</body>
</html>
