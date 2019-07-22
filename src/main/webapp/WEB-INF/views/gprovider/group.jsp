<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<jsp:include page="/WEB-INF/views/include/head4.jsp" />
<title>机构-编辑</title>
<script type="text/javascript">


var userIds = [];
var userNames = [];
var personIds = [];
var personNames = [];
	function onSave() {
		//表单验证
	    if (!$ ('#mainForm').validate ().form ()){
		    return false;
	    }

		var str = $("#userIds").val().split("");
	    if(str[str.length -1] != ",")
		{
			$("#userIds").val($("#userIds").val() + ",");
		}
	    str = $("#userNames").val().split("");
	    if(str[str.length -1] != ",")
		{
			$("#userNames").val($("#userNames").val() + ",");
		}
	    str = $("#personIds").val().split("");
	    if(str[str.length -1] != ",")
		{
			$("#personIds").val($("#personIds").val() + ",");
		}
	    str = $("#personNames").val().split("");
	    if(str[str.length -1] != ",")
		{
			$("#personNames").val($("#personNames").val() + ",");
		}
		var para = $("#mainForm").serialize();
		$.post(_BasePath + 'base/org/save4', $("#mainForm").serialize(),
				function(result, status) {
					if (result.error){
					    layer.msg (result.error);
					    $ ("#name").focus ();
					    return;
				    }
					/* if (parent.onSaveOk) {
						parent.onSaveOk(result.entity)
					} */
					//document.location = "base/org/index4";
					parent.goToIndex("base/org/index4")
				});
	}

	function onCancel() {
		/* var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
		parent.layer.close(index); //再执行关闭    */
		document.location = "base/org/index4";
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
	        content : 'base/user/multiSel4?baseRoleId=${o.id}&ids=' + userIds 
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
    
	$(function() {
        $(".select2").select2();
		
		if ("${o.id}" > 0) {
			//$("#isActive").select2("val", "${o.isActive}");
			genUserList ();
		}
	})
</script>
</head>

<body>
	<div class="container-fluid">
		<div>&nbsp;</div>
		<form id="mainForm" class="form-horizontal">
			<input type="hidden" id="id" name="id" value="${o.id}" />
			<input type="hidden" id="lineNo" name="lineNo" value="${o.lineNo}" />
			<input type="hidden" id="category" name="category" value="${o.category}" />
			<input type="hidden" id="isActive" name="isActive" value="${o.isActive}" />
			<jsp:include page="/WEB-INF/views/include/basetree.jsp" />
			<jsp:include page="/WEB-INF/views/include/recordinfo.jsp" />
			<div class="form-group">
				<label class="col-sm-2 control-label" for="name">群组名称</label>
				<div class="col-sm-10">
					<input class="form-control" id="name" name="name" value="${o.name}"
						type="text" required />
				</div>
				
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="userNames">用户</label>
				<div class="col-sm-10">
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
			<div style="display:none">
			<div class="form-group">
				<label class="col-sm-2 control-label" for="name"></label>
				<div class="col-sm-4">
					
				</div>
				<label class="col-sm-2 control-label" for="sym">机构代码</label>
				<div class="col-sm-4">
					<input class="form-control" id="sym" name="sym" value="${o.sym}"
						type="text" />
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="fullName"
					style="min-widht:80px;">全称</label>
				<div class="col-sm-4">
					<input class="form-control" id="fullName" name="fullName"
						value="${o.fullName}" type="text" />
				</div>
				<label class="col-sm-2 control-label" for="legalRepresentative">法人代表</label>
				<div class="col-sm-4">
					<input class="form-control" id="legalRepresentative"
						name="legalRepresentative" value="${o.legalRepresentative}"
						type="text" />
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="contactPerson">联系人</label>
				<div class="col-sm-4">
					<input class="form-control" id="contactPerson" name="contactPerson"
						value="${o.contactPerson}" type="text" />
				</div>
				<label class="col-sm-2 control-label" for="phone">联系电话</label>
				<div class="col-sm-4">
					<input class="form-control" id="phone" name="phone"
						value="${o.phone}" type="text" />
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="fax">传真</label>
				<div class="col-sm-4">
					<input class="form-control" id="fax" name="fax" value="${o.fax}"
						type="text" />
				</div>
				<label class="col-sm-2 control-label" for="email">邮箱</label>
				<div class="col-sm-4">
					<input class="form-control" id="email" name="email"
						value="${o.email}" type="text" />
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="website">网址</label>
				<div class="col-sm-10">
					<input class="form-control" id="website" name="website"
						value="${o.website}" type="text" />
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="address">地址</label>
				<div class="col-sm-10">
					<input class="form-control" id="address" name="address"
						value="${o.address}" type="text" />
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="isActive">状态</label>
				<div class="col-sm-4">
					
				</div>
				<label class="col-sm-2 control-label" for=""></label>
				<div class="col-sm-4"></div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="descr">备注</label>
				<div class="col-sm-10">
					<textarea class="form-control" id="descr" name="descr" rows=3>${o.descr}</textarea>
				</div>
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
