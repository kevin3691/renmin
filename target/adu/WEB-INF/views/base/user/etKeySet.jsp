<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<jsp:include page="/WEB-INF/views/include/head.jsp" />
<title>用户管理--设置密码锁</title>
<script type="text/javascript">
	//保存
    function onSave () {
	    //表单验证
	    if (!$ ('#mainForm').validate ().form ()){
		    return false;
	    }
	    var keySN = $ ("#keySN").val ();
	    if (keySN == ""){
		    layer.msg ("未检测到加密锁");
		    return;
	    }
	    //打开ET199
	    var ret = ETUCtrl.Open ()
	    var info = "{id:${o.id},username:\"${o.username}\",baseOrgName:\"${o.baseOrgName}\",baseOrgId:\"${o.baseOrgId}\",basePersonName:\"${o.basePersonName}\",basePersonId:\"${o.basePersonId}\"}"
	    //var result = ETUCtrl.SetTDESKey ("012345678912CDEF");
	    var ret = ETUCtrl.VerifyPIN (1, "123456781234567812345678");
	    var ret = ETUCtrl.VerifyPIN (0, "12345678");
	    info = ETUCtrl.TDESEncrypt (info);
	    var ret = ETUCtrl.Write (0, 1024, info);
	    if (ret != 0){
		    layer.msg ("数据写入失败，请点击‘初始化加密锁’后重试")
		    return;
	    }
	    $.post ('base/user/update', {
	        id : "${o.id}",
	        keySN : keySN
	    }, function (result, status) {
		    if (result.error){
			    layer.msg (result.error);
			    $ ("#username").focus ();
			    return;
		    }
		    if (parent.onSaveOk){
			    layer.msg ("加密锁设置成功");
			    parent.onSaveOk (result.entity)
		    }
	    });
    }
    //返回
    function onCancel () {
	    var index = parent.layer.getFrameIndex (window.name); //先得到当前iframe层的索引
	    parent.layer.close (index); //再执行关闭   
    }
    //检测加密锁
    function checkKey () {
	    var keySN = "";
	    var cnt = 0;
	    try{
		    //打开ET199
		    var ret = ETUCtrl.Open ()
		    $ ("#downDriver").html ('');
		    keySN = ETUCtrl.GetSN ();
		    cnt = ETUCtrl.Enum ();
		    $ ("keySN").val (keySN)
		    $ ("#etKeySN").val (keySN);
		    $ ("#keySN").val (keySN);
		    $ (".alert").hide ();
	    } catch (e){
		    $ (".alert").html (
		            '<a class="text-warning" href="driver/ET199-ActiveX-Setup.exe">系统检测到您未安装加密锁插件,点击下载安装</a>');
		    $ (".alert").show ();
		    onReset ();
		    return;
	    }
	    if (cnt == 0){
		    $ (".alert").html ("未检测到加密锁")
		    $ (".alert").show ();
		    onReset ();
		    //出现警示信息时页面会增高,让窗口自适应高度
		    var index = parent.layer.getFrameIndex (window.name); //获取窗口索引
		    parent.layer.iframeAuto (index);
		    return;
	    }
	    try{
		    //打开ET199
		    var ret = ETUCtrl.Open ();
		    var ret = ETUCtrl.VerifyPIN (1, "123456781234567812345678");
		    var ret = ETUCtrl.VerifyPIN (0, "12345678");
		    var info = ETUCtrl.Read (0, 255);
		    info += ETUCtrl.Read (255, 255);
		    info = ETUCtrl.TDESDecrypt (info);
		    info = eval ("(" + info + ")");
		    $ ("#etBasePersonName").val (info.basePersonName);
		    $ ("#etBaseOrgName").val (info.baseOrgName);
		    $ ("#etUsername").val (info.username);
	    } catch (e){
		    //$ (".alert").html ("此加密锁未绑定用户信息,请联系管理员绑定.")
		    //$ (".alert").show ();
		    //$ ('#mainForm')[0].reset ();
	    }
	    setTimeout ("checkKey()", 1000);
    }
    function onReset () {
	    $ ("#etBasePersonName").val ("");
	    $ ("#etBaseOrgName").val ("");
	    $ ("#etUsername").val ("");
	    $ ("#etKeySN").val ("");
	    $ ("#keySN").val ("");
	    setTimeout ("checkKey()", 1000);
    }
    function onInitKey () {
	    var ret = ET199.ResetPIN ("123456781234567812345678");
	    var ret = ET199.InitET199 ("123456781234567812345678");
	    if (ret != 0){
		    layer.msg ("初始化加密锁失败，请联系技术支持人员");
	    }
	    else{
		    layer.msg ("初始化加密锁成功， 请偿试重新绑定");
	    }
    }
    //页面加载完成执行
    $ (function () {
	    checkKey ();
    })
</script>
</head>
<body style="overflow:hidden;">
	<div class="alert alert-danger alert-dismissable" style="display:none;"></div>
	<div class="col-md-6 col-sm-6">
		<div class="box box-solid">
			<div class="box-header">
				<i class="fa fa-info-circle"></i> <span class="box-title">拟写入信息</span>
			</div>
			<div class="box-body border-radius-none">
				<form id="mainForm" class="form-horizontal">
					<input type="hidden" id="id" name="id" value="${o.id}" />
					<div class="form-group">
						<label class="col-sm-3 control-label" for="basePersonName">姓名</label>
						<div class="col-sm-9">
							<input class="form-control" id="basePersonName"
								name="basePersonName" value="${o.basePersonName}" type="text"
								readonly />
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-3 control-label" for="baseOrgName">部门</label>
						<div class="col-sm-9">
							<input class="form-control" id="baseOrgName" name="baseOrgName"
								value="${o.baseOrgName}" type="text" readonly /> <input
								type="hidden" id="baseOrgId" name="baseOrgId"
								value="${o.baseOrgId}" />
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-3 control-label" for="username">用户名</label>
						<div class="col-sm-9">
							<input class="form-control" id="username" name="username"
								value="${o.username}" type="text" readonly />
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-3 control-label" for="keySN">加密锁</label>
						<div class="col-sm-9">
							<input class="form-control" id="keySN" name="password"
								value="${o.keySN}" type="text" readonly />
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
	<div class="col-md-6 col-sm-6">
		<div class="box box-solid">
			<div class="box-header">
				<i class="fa fa-lock"></i> <span class="box-title">加密锁内信息</span>
			</div>
			<div class="box-body border-radius-none form-horizontal">
				<div class="form-group">
					<label class="col-sm-3 control-label" for="etBasePersonName">姓名</label>
					<div class="col-sm-9">
						<input class="form-control" id="etBasePersonName"
							name="etBasePersonName" value="" type="text" readonly />
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-3 control-label" for="etBaseOrgName">部门</label>
					<div class="col-sm-9">
						<input class="form-control" id="etBaseOrgName"
							name="etBaseOrgName" value="" type="text" readonly />
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-3 control-label" for="etUsername">用户名</label>
					<div class="col-sm-9">
						<input class="form-control" id="etUsername" name="etUsername"
							value="" type="text" readonly />
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-3 control-label" for="etKeySN">加密锁</label>
					<div class="col-sm-9">
						<input class="form-control" id="etKeySN" name="etKeySN" value=""
							type="text" readonly />
					</div>
				</div>
			</div>
		</div>
	</div>

	<div class="container-fluid">
		<div class="form-group controls" style="text-align:center">
			<button type="button" class="btn btn-info" onclick="onInitKey()">初始化加密锁</button>
			&nbsp;&nbsp;
			<button type="button" class="btn btn-info" onclick="onSave()">绑定</button>
			&nbsp;&nbsp;
			<button type="button" class="btn btn-danger" onclick="onCancel()">返回</button>
		</div>
		<OBJECT id="ETUCtrl"
			classid="clsid:9222986D-9A56-4324-99E0-FDAC970EE0B0" HEIGHT="0"
			WIDTH="0" VIEWASTEXT></OBJECT>
		<OBJECT ID="ET199"
			CLASSID="clsid:FDE438C5-7862-406B-892F-4D2D7F4A1C80"
			CODEBASE="ET199-ActiveX-Setup.exe" BORDER="0" VSPACE="0" HSPACE="0"
			ALIGN="TOP" HEIGHT="0" WIDTH="0"></OBJECT>
		</di>
</body>
</html>
