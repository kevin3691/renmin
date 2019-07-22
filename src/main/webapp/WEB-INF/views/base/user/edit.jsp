<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<jsp:include page="/WEB-INF/views/include/head4.jsp" />
<title>用户编辑</title>
<script type="text/javascript">
	//保存
    function onSave () {
	    //表单验证
	    if (!$ ('#mainForm').validate ().form ()){
		    return false;
	    }
	    $ ("#baseRoleName").val ($ ("#baseRoleId").find ("option:selected").text ())
	    var para = $ ("#mainForm").serialize ();
	    $.post ('base/user/save', $ ("#mainForm").serialize (), function (result, status) {
		    if (result.error){
			    layer.msg (result.error);
			    $ ("#username").focus ();
			    return;
		    }
		    if (parent.onSaveOk){
			    parent.onSaveOk (result.entity)
		    }
	    });
    }
    //返回
    function onCancel () {
	    var index = parent.layer.getFrameIndex (window.name); //先得到当前iframe层的索引
	    parent.layer.close (index); //再执行关闭   
    }
    //选择人员
    function onSelPerson () {
	    var title = "选择人员"
	    layer.open ({
	        type : 2,
	        title : title,
	        shadeClose : true,
	        shade : 0.8,
	        area : [
	                '90%', '90%'
	        ],
	        content : 'base/person/sel'
	    });
    }
    //选择人员回调方法 
    function onPersonSelOk (row) {
	    $ ("#basePersonId").val (row.id)
	    $ ("#basePersonName").val (row.name)
	    $ ("#baseOrgId").val (row.baseOrgId)
	    $ ("#baseOrgName").val (row.baseOrgName)
	    layer.closeAll ();
    }
    //选择部门权限
    function onSelPurOrg () {
	    var title = "选择部门权限"
	    layer.open ({
	        type : 2,
	        title : title,
	        shadeClose : true,
	        shade : 0.8,
	        area : [
	                '820', '420'
	        ],
	        content : 'base/org/multiSel'
	    });
    }
    //选择部门回调 方法 
    function onOrgSelOk (nodes) {
	    layer.closeAll ();
	    var ids = [];
	    var names = [];
	    $.each (nodes, function (i, node) {
		    //只存储叶子节点
		    if (node.baseTree.isLeaf == 0)
			    return true;
		    ids.push (node.id);
		    names.push (node.name);
	    })
	    $ ("#purOrgIds").val (ids)
	    $ ("#purOrgNames").val (names)
	    genPurOrgList ()
    }
    //生成权限部门列表
    function genPurOrgList () {
	    $ ("#purOrgList").empty ();
	    var ids = $ ("#purOrgIds").val ().split (",");
	    var names = $ ("#purOrgNames").val ().split (",");
	    var tmp = '<div class="btn-group"><button type="button" class="btn btn-default">$NAME$</button><button onclick="onDelPurOrg($ID$)" class="btn btn-default" type="button">&times;</button></div>'
	    $.each (ids, function (i, id) {
		    if (id == "")
			    return true;
		    $ ("#purOrgList").append (
		            '<li id="purOrg'+id+'" style="float:left;list-style:none;padding:3px 3px 3px 0px;">'
		                    + tmp.replace ("$NAME$", names[i]).replace ("$ID$", id) + '</li>');
	    })
    }
    //删除部门权限
    function onDelPurOrg (id) {
	    var ids = $ ("#purOrgIds").val ().split (",");
	    var names = $ ("#purOrgNames").val ().split (",");
	    var idx;
	    $.each (ids, function (i, v) {
		    if (v == id){
			    idx = i;
			    return true;
		    }
	    })
	    ids.splice (idx, 1);
	    names.splice (idx, 1);
	    $ ("#purOrgIds").val (ids);
	    $ ("#purOrgNames").val (names);
	    $ ("#purOrg" + id).remove ();
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
	                '820', '420'
	        ],
	        content : 'base/power/multiSel'
	    });
    }
    //选择权限回调方法
    function onPowerSelOk (nodes) {
	    layer.closeAll ();
	    var ids = [];
	    var titles = [];
	    var syms = [];
	    var menuIds = [];
	    $.each (nodes, function (i, node) {
		    if (node.baseTree.isLeaf == 0)
			    return true;
		    ids.push (node.id);
		    titles.push (node.title);
		    syms.push (node.sym);
	    })
	    $ ("#purPowerIds").val (ids)
	    $ ("#purPowerTitles").val (titles)
	    $ ("#purPowerSyms").val (syms)
	    genPurPowerList ()
    }
    //生成权限列表
    function genPurPowerList () {
	    $ ("#purPowerList").empty ();
	    var ids = $ ("#purPowerIds").val ().split (",");
	    var titles = $ ("#purPowerTitles").val ().split (",");
	    var syms = $ ("#purPowerSyms").val ().split (",");
	    var tmp = '<div class="btn-group"><button type="button" class="btn btn-default">$TITLE$</button><button onclick="onDelPurPower($ID$)" class="btn btn-default" type="button">&times;</button></div>'
	    $.each (ids, function (i, id) {
		    if (id == "")
			    return true;
		    $ ("#purPowerList").append (
		            '<li id="purPower'+id+'" style="float:left;list-style:none;padding:3px 3px 3px 0px;">'
		                    + tmp.replace ("$TITLE$", titles[i]).replace ("$ID$", id) + '</li>');
	    })
    }
    //删除权限
    function onDelPurPower (id) {
	    var ids = $ ("#purPowerIds").val ().split (",");
	    var titles = $ ("#purPowerTitles").val ().split (",");
	    var syms = $ ("#purPowerSyms").val ().split (",");
	    var idx;
	    $.each (ids, function (i, v) {
		    if (v == id){
			    idx = i;
			    return true;
		    }
	    })
	    ids.splice (idx, 1);
	    titles.splice (idx, 1);
	    syms.splice (idx, 1);
	    $ ("#purPowerIds").val (ids);
	    $ ("#purPowerTitles").val (titles);
	    $ ("#purPowerSyms").val (syms);
	    $ ("#purPower" + id).remove ();
    }
    //避免页面加载时即执行onRoleChange,保证在选择项发生改变时才执行，因为可能对角色权限进行了个性调整，避免每次编辑时覆盖
    var _CurRoleId = "${o.baseRoleId}";
    //选择角色
    function onRoleChange (roleid) {
	  
	    if (roleid == 0 || _CurRoleId == roleid){
		    return;
	    }
	    _CurRoleId = roleid;
	      var index = layer.load (1, {
		    shade : [
		            0.1, '#fff'
		    ]
	    });
	    $.post ("base/role/get", {
		    id : roleid
	    }, function (result) {
		    var menu = result.entity;
		    $ ("#purPowerIds").val (menu.purPowerIds);
		    $ ("#purPowerTitles").val (menu.purPowerTitles);
		    $ ("#purPowerSyms").val (menu.purPowerSyms);
		    genPurPowerList ();
		    layer.close (index)
	    });
    }
    //页面加载完成执行
    $ (function () {
	    //初始化select
	    $ (".select2").select2 ();
	    //初始化角色选择项
	    $.post ("base/role/list", {}, function (rslt) {
		    var rows = rslt.rows;
		    $ ("#baseRoleId").append ("<option value='0'></option>");
		    for (var i = 0; i < rows.length; i++){
			    $ ("#baseRoleId").append ("<option value='" + rows[i].id + "'>" + rows[i].title + "</option>");
		    }
		    $ ("#baseRoleId").select2 ("val", "${o.baseRoleId}");
	    })
	    //编辑时页面赋值
	    if ("${o.id}" > 0){
		    $ ("#isActive").select2 ("val", "${o.isActive}");
		    genPurOrgList ();
		    genPurPowerList ();
	    }
	    _ISLODED = true;
    })
</script>
</head>

<body>
	<div class="container-fluid">
		<div>&nbsp;</div>
		<form id="mainForm" class="form-horizontal">
			<input type="hidden" id="id" name="id" value="${o.id}" /> <input
				type="hidden" id="purMenuIds" name="purMenuIds"
				value="${o.purMenuIds}" /> <input type="hidden" id="purMenus"
				name="purMenus" value="${o.purMenus}" />
				<input type="hidden" id="orgiRoleId" name="orgiRoleId" value="${o.baseRoleId}" /> 
			<jsp:include page="/WEB-INF/views/include/recordinfo.jsp" />
			<div class="form-group">
				<label class="col-md-1 col-sm-2 control-label" for="basePersonName">姓名</label>
				<div class="col-md-5 col-sm-4">
					<span class="input-group"> <input class="form-control"
						id="basePersonName" name="basePersonName"
						value="${o.basePersonName}" type="text" readonly required /><span
						class="input-group-btn">
							<button class="btn btn-info btn-flat" type="button"
								onclick="onSelPerson()">选择</button> <input type="hidden"
							id="basePersonId" name="basePersonId" value="${o.basePersonId}" />
					</span>
					</span>
				</div>
				<label class="col-md-1 col-sm-2 control-label" for="baseOrgName">单位</label>
				<div class="col-md-5 col-sm-4">
					<input class="form-control" id="baseOrgName" name="baseOrgName"
						value="${o.baseOrgName}" type="text" readonly /> <input
						type="hidden" id="baseOrgId" name="baseOrgId"
						value="${o.baseOrgId}" />
				</div>
			</div>
			<div class="form-group">
				<label class="col-md-1 col-sm-2 control-label" for="username">用户名</label>
				<div class="col-md-5 col-sm-4">
					<input class="form-control" id="username" name="username"
						value="${o.username}" type="text" required />
				</div>
				<label class="col-md-1 col-sm-2 control-label" for="baseRoleName">角色</label>
				<div class="col-md-5 col-sm-4">
					<select onchange="onRoleChange(this.value)" id="baseRoleId"
						name="baseRoleId" class="form-control select2">
					</select> <input type="hidden" id="baseRoleName" name="baseRoleName"
						value="${o.baseRoleName}" />
				</div>
			</div>
			<div class="form-group">
				<label class="col-md-1 col-sm-2 control-label" for="username">密码</label>
				<div class="col-md-5 col-sm-4">
					<input class="form-control" id="password" name="password"
						value="${o.password}" type="password" required />
				</div>
				<label class="col-md-1 col-sm-2 control-label" style="white-space:nowrap;" for="password2">确认密码</label>
				<div class="col-md-5 col-sm-4">
					<input class="form-control" id="password2" name="password2"
						value="${o.password}" type="password" equalTo="#password" />
				</div>
			</div>
			<div class="form-group">
				<label class="col-md-1 col-sm-2 control-label" style="white-space:nowrap;" for="purOrgNames">部门权限</label>
				<div class="col-md-11 col-sm-10">
					<input type="hidden" id="purOrgIds" name="purOrgIds"
						value="${o.purOrgIds}" /> <input type="hidden" id="purOrgNames"
						name="purOrgNames" value="${o.purOrgNames}" />
					<ul id="purOrgList" class="list-group">
					</ul>
					<button class="btn btn-info btn-flat pull-right" type="button"
						onclick="onSelPurOrg()">选择</button>
				</div>
			</div>
			<div class="form-group">
				<label class="col-md-1 col-sm-2 control-label" for="purPowerTitles">权限</label>
				<div class="col-md-11 col-sm-10">
					<input type="hidden" id="purPowerIds" name="purPowerIds"
						value="${o.purPowerIds}" /> <input type="hidden"
						id="purPowerTitles" name="purPowerTitles"
						value="${o.purPowerTitles}" /> <input type="hidden"
						id="purPowerSyms" name="purPowerSyms" value="${o.purPowerSyms}" />
					<ul id="purPowerList" class="list-group">
					</ul>
					<button class="btn btn-info btn-flat pull-right" type="button"
						onclick="onSelPurPower()">选择</button>
				</div>
			</div>
			<div class="form-group">
				<label class="col-md-1 col-sm-2 control-label" for="isActive">状态</label>
				<div class="col-md-5 col-sm-4">
					<select id="isActive" name="isActive" class="form-control select2">
						<option value=1>启用</option>
						<option value=0>停用</option>
					</select>
				</div>
				<label class="col-md-1 col-sm-2 control-label" for=""></label>
				<div class="col-md-5 col-sm-4"></div>
			</div>
			<div class="form-group">
				<label class="col-md-1 col-sm-2 control-label" for="descr">备注</label>
				<div class="col-md-11 col-sm-10">
					<textarea class="form-control" id="descr" name="descr" rows=3>${o.descr}</textarea>
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
