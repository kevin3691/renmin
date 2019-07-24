<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<title>${WorkplateTitle}</title>
<jsp:include page="/WEB-INF/views/include/head.jsp" />
<link href="css/master.css" rel="stylesheet" type="text/css">

	<script type="text/javascript">
	//保存
    function onSave () {
	    //表单验证
	    if (!$ ('#mainForm').validate ().form ()){
		    return false;
	    }
	    
	    var para = $ ("#mainForm").serialize ();
	    $.post ('base/user/save', $ ("#mainForm").serialize (), function (result, status) {
	    	if (result.error){
			    layer.msg (result.error);
			    $ ("#basePersonName").focus ();
			    return;
		    }
	    	if (result.error2){
			    layer.msg (result.error2);
			    $ ("#username").focus ();
			    return;
		    }
		    alert("注册成功！");
		    document.location.href = "home/login";
	    });
    }
    //返回
    function onCancel () {
	    var index = parent.layer.getFrameIndex (window.name); //先得到当前iframe层的索引
	    parent.layer.close (index); //再执行关闭   
    }
  //数据字典回调函数,初始化后为其赋值
  
		$(function(){
			 //加载select特效
		    $ (".select2").select2 ();
		  //初始化角色选择项
		    $.post ("base/role/list", {}, function (rslt) {
			    var rows = rslt.rows;
			    var id = 0;
			    for (var i = 0; i < rows.length; i++){
			    	if(rows[i].title == "绿卡用户")
			    	{
			    		id = rows[i].id;
			    		$ ("#baseRoleId").append ("<option value='" + rows[i].id + "'>" + rows[i].title + "</option>");
			    	}
			    }
			    if ("${o.id}" > 0){
			    	$ ("#baseRoleId").select2 ("val", "${o.baseRoleId}");
			    }else{
			    	$ ("#baseRoleId").select2 ("val", id);
			    }
			    
		    })
		   
		    //赋值
		    if ("${o.id}" > 0){
			    $ ("#isActive").select2 ("val", "${o.isActive}");
		    }
		})
		
	</script>
  </head>
</head>
<body>

	<div class="top_up">
			<div class="top_up_mid">
				<ul class="top_um_left">
					<li>欢迎进入${PortalTitle }！</li>
					<li><fmt:formatDate
								value="${NowTime }" type="date" dateStyle="full" /></li>
				</ul>
				<ul class="top_um_right">
					<li><a href="home/login">用户登陆</a></li>
					<li>丨</li>
					<li><a href="home/register">用户注册</a></li>
				</ul>
			</div>
		</div>
	
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
				<label class="col-md-1 col-sm-5 control-label" for=""></label>
				<label class="col-md-1 col-sm-2 control-label" for="basePersonName">姓名</label>
				<div class="col-md-5 col-sm-3">
					<input class="form-control"
						id="basePersonName" name="basePersonName"
						value="${o.basePersonName}" type="text" required />
							<input type="hidden"
							id="basePersonId" name="basePersonId" value="${o.basePersonId}" />
					
					
				</div>
				<label style="display:none;" class="col-md-1 col-sm-2 control-label" for="baseOrgName">单位</label>
				<div class="col-md-5 col-sm-4" style="display:none;">
				
					<span class="input-group"><input class="form-control" id="baseOrgName" name="baseOrgName"
						value="${o.baseOrgName}" type="text" readonly required /> <input
						type="hidden" id="baseOrgId" name="baseOrgId"
						value="${o.baseOrgId}" />
						<span
						class="input-group-btn">
						<button class="btn btn-info btn-flat" type="button"
								onclick="onSelBaseOrg()">选择</button>
						</span>
						</span>
				</div>
			</div>
			<div class="form-group">
				<label class="col-md-1 col-sm-5 control-label" for=""></label>
				<label class="col-md-1 col-sm-2 control-label" for="username">用户名</label>
				<div class="col-md-5 col-sm-3">
					<input class="form-control" id="username" name="username"
						value="${o.username}" type="text" required />
				</div>
				<label style="display:none;" class="col-md-1 col-sm-2 control-label" for="baseRoleName">角色</label>
				<div style="display:none;" class="col-md-5 col-sm-4">
					<select onchange="onRoleChange(this.value)" id="baseRoleId"
						name="baseRoleId" class="form-control select2">
					</select> <input type="hidden" id="baseRoleName" name="baseRoleName"
						value="${o.baseRoleName}" />
				</div>
			</div>
			<div class="form-group">
				<label class="col-md-1 col-sm-5 control-label" for=""></label>
				<label class="col-md-1 col-sm-2 control-label" for="username">密码</label>
				<div class="col-md-5 col-sm-3">
					<input class="form-control" id="password" name="password"
						value="${o.password}" type="password" required />
				</div>
				
			</div>
			<div class="form-group">
				<label class="col-md-1 col-sm-5 control-label" for=""></label>
				<label class="col-md-1 col-sm-2 control-label" style="white-space:nowrap;" for="password2">确认密码</label>
				<div class="col-md-5 col-sm-3">
					<input class="form-control" id="password2" name="password2"
						value="${o.password}" type="password" equalTo="#password" />
				</div>
			</div>
			<div class="form-group" style="display:none">
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
			<div class="form-group" style="display:none">
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
			<div class="form-group" style="display:none;">
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
			<div class="form-group" style="display:none;">
				<label class="col-md-1 col-sm-2 control-label" for="descr">备注</label>
				<div class="col-md-11 col-sm-10">
					<textarea class="form-control" id="descr" name="descr" rows=3>${o.descr}</textarea>
				</div>
			</div>
			<div class="form-group controls" style="text-align:center">
				<button type="button" class="btn btn-info" onclick="onSave()">注册</button>
				
			</div>
		</form>
	</div>

<div class="bot">
  <div class="bot_mid"> 
  <div class="bot_test">
  </div>
    <div class="bot_test1">${Copyright } 版权所有Copyright 2013-2016 rcsd.cn All rights reserved<br /> 
冀 ICP 证 00000000 号 </div>
  </div>
  
</div>

</body>
</html>
