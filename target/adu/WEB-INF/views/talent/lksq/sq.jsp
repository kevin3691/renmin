<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<jsp:include page="/WEB-INF/views/include/head.jsp" />
<script type="text/javascript" charset="utf-8" src="u000e/config.min.js"></script>
<script type="text/javascript" charset="utf-8" src="u000e/all.min.js"></script>
<link rel="stylesheet" type="text/css"
	href="jslib/webuploader/webuploader.min.css">
<script type="text/javascript"
	src="jslib/webuploader/webuploader.min.js"></script>
<script type="text/javascript" src="jslib/webuploader/uploader.min.js"></script>
<title>人员-编辑</title>
<script type="text/javascript">
	//保存
    function onSave () {
	    //表单验证
	    if (!$ ('#mainForm').validate ().form ()){
		    return false;
	    }
	    var ue = UE.getEditor ('editor');
	    $ ("#experience").val (ue.getContent ());
	    
	    var ue2 = UE.getEditor ('editor2');
	    $ ("#achievements").val (ue.getContent ());
	    
	    var para = $ ("#mainForm").serialize ();
	    $.post ('talent/lksq/save', $ ("#mainForm").serialize (), function (result, status) {
		    alert("保存成功!")
		    document.location.href = "talent/lksq/sq?id=" + result.entity.id;
	    });
    }
    //返回
    function onCancel () {
	    var index = parent.layer.getFrameIndex (window.name); //先得到当前iframe层的索引
	    parent.layer.close (index); //再执行关闭   
    }
    //选择部门
    function onSelOrg () {
	    layer.open ({
	        type : 2,
	        title : "选择单位",
	        shadeClose : true,
	        shade : 0.8,
	        area : [
	                '350', '420'
	        ],
	        content : 'base/org/sel' //iframe的url
	    });
    }
    //选择部门回调方法 
    function onSelOrgOk (node) {
	    $ ("#baseOrgId").val (node.id)
	    $ ("#baseOrgName").val (node.name)
	    layer.closeAll ()
    }
    
  //上传背景图
    function onUploadBg () {
	    $ ("input[name='file']").click ();
    }
    //清除背景图
    function onClearBg () {
	    $ ("#img").val ("");
	    $ ("#imgPreview").attr ('src', "");
    }
    function onUploadSucess (file, res) {
	    $ ("#img").val (res.entity.fileUrl);
	    $ ("#imgPreview").attr ('src', res.entity.fileUrl);
    }
    
  //ueditor 上传完成后回调
    function ueSimpleUploadCallback(json){
    	/* $.post("comm/uploader/saveAs",{url:json.url},function(result,stts){
                        		//alert(result+"\n\r"+stts)
                        	}) */
    }
  
  function onChange(flag){
	  var url = "talent/lksq/sq?id=${o.id}";
	  if(flag == 2)
	  {
		  if("${o.id}" == 0)
		{
			  alert("请先保存信息，再上传材料！");
			  return false;
		}
		  url = "talent/lksq/sc?id=${o.id}";
	  }
	  document.location.href = url;
		  
  }
    //数据字典回调函数,初始化后为其赋值
    function dictCallBack (container) {
	    if (container == "title"){
		    $ ("#title").select2 ("val", "${o.title}");
	    }
	    else if (container == "education"){
		    $ ("#education").select2 ("val", "${o.education}");
	    }
	    else if (container == "gender"){
		    $ ("#gender").select2 ("val", "${o.gender}");
	    }
	    else if (container == "idCardTypeId"){
		    $ ("#idCardTypeId").select2 ("val", "${o.idCardTypeId}");
	    }
    }
    $ (function () {
    	UPLOADER.accept = {
    	        title : 'Images',
    	        extensions : 'gif,jpg,jpeg,bmp,png',
    	        mimeTypes : 'image/*'
    	    }
    	    UPLOADER.formData = {
    		    applyTo : 'WfPrintTemp'
    	    }
    	    UPLOADER.init ();
    	 //实例化编辑器
	    var ue = UE.getEditor ('editor');
	    $ ("#editor").height (230);
	    
	    //实例化编辑器
	    var ue2 = UE.getEditor ('editor2');
	    $ ("#editor2").height (230);
	    
	    //加载select特效
	    $ (".select2").select2 ();
	    //为日期设置格式输入
	    $ ("#DOB").inputmask ("yyyy-mm-dd", {
		    "placeholder" : "yyyy-mm-dd"
	    });
	    //加载日期控件
	    $ ('#DOB').datetimepicker ({
		    minView : 3
	    //时间，默认为日期时间
	    });
	    //设置掩码
	    $ ('#DOB').inputmask ("yyyy-mm-dd");
	    //加载数据字典--性别
	    bindDictSelect ("SEX", "gender");
	    //加载数据字典--职务
	    //bindDictSelect ("TITLE", "title");
	    //加载数据字典--教育程度
	    bindDictSelect ("EDUCATION", "education");
	    
	    bindDictSelect ("SFZJLX", "idCardTypeId");
	    //赋值
	    if ("${o.id}" > 0){
		    $ ("#isActive").select2 ("val", "${o.isActive}");
	    }
    })
</script>
</head>

<body>
	<div class="container-fluid">
		<div>&nbsp;</div>
		<ul class="nav nav-tabs">
								<li class="active" style="cursor:pointer;"><a
									href="javascript:onChange(1)">基本信息
								</a></li>
								<li style="cursor:pointer;"><a
									href="javascript:onChange(2)">上传材料
								</a></li>
		</ul>
		<form id="mainForm" class="form-horizontal">
			<input type="hidden" id="id" name="id" value="${o.id}" />
			<input type="hidden" id="baseUserId" name="baseUserId" value="${o.baseUserId}" />
			<input type="hidden" id="sym" name="sym" value="${o.sym}" />
			<input type="hidden" id="nationId" name="nationId" value="${o.nationId}" />
			<input type="hidden" id="baseOrgName" name="baseOrgName" value="${o.baseOrgName}" />
			<input type="hidden" id="baseOrgId" name="baseOrgId" value="${o.baseOrgId}" />
			<input type="hidden" id="isActive" name="isActive" value="${o.isActive}" />
			<input type="hidden" id="lineNo" name="lineNo" value="${o.lineNo}" />
			<input type="hidden" id="descr" name="descr" value="${o.descr}" />
			<input type="hidden" id="experience" name="experience" value="${o.experience}" />
			<input type="hidden" id="achievements" name="achievements" value="${o.achievements}" />
			<input type="hidden" id="inservice" name="inservice" value="${o.inservice}" />
			<jsp:include page="/WEB-INF/views/include/recordinfo.jsp" />
			<div class="row">
				<div class="col-lg-9 col-sm-8">
					<div class="form-group">
						<label class="col-lg-1  col-sm-2 control-label" for="name">中文姓名</label>
						<div class="col-lg-5 col-sm-4">
							<input class="form-control" id="name" name="name"
								value="${o.name}" type="text" maxlength=200 />
						</div>
						<label class="col-lg-1  col-sm-2 control-label" for="ename">英文姓名</label>
						<div class="col-lg-5 col-sm-4">
							<input class="form-control" id="ename" name="ename"
								value="${o.ename}" type="text" maxlength=200 />
						</div>
					</div>
					<div class="form-group">
						<label class="col-lg-1 col-sm-2 control-label" for="source">性别</label>
						<div class="col-lg-5 col-sm-4">
							<select id="gender" name="gender" class="form-control select2">
							</select>
						</div>
						<label class="col-lg-1 col-sm-2 control-label" for="DOB"
							style="white-space:nowrap;">出生日期</label>
						<div class="col-lg-5 col-sm-4">
							<div class="input-group">
								<input class="form-control" id="DOB" name="DOB"
									value="${o.DOB}" type="text" />
								<div class="input-group-addon">
									<i id="icon" class="fa fa-calendar"
										onclick="$('#DOB').datetimepicker('show');"></i>
								</div>
							</div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-lg-1 col-sm-2 control-label" for="volk">民族</label>
						<div class="col-lg-5 col-sm-4">
							<input class="form-control" id="volk" name="volk"
								value="${o.volk}" type="text" maxlength=20 />
						</div>
						<label class="col-lg-1 col-sm-2 control-label" for="nation">国籍/籍贯</label>
						<div class="col-lg-5 col-sm-4">
							<input class="form-control" id="nation" name="nation"
								value="${o.nation}" type="text" />
						</div>
					</div>
					<div class="form-group">
						<label class="col-lg-1 col-sm-2 control-label" for="address">本市居住地</label>
						<div class="col-lg-11 col-sm-10">
							<input class="form-control" id="address" name="address"
								value="${o.address}" type="text" maxlength=600 />
						</div>
					</div>
					<div class="form-group">
						<label class="col-lg-1 col-sm-2 control-label" for="education">学历学位</label>
						<div class="col-lg-5 col-sm-4">
							<select id="education" name="education"
								class="form-control select2">
							</select>
						</div>
						<label class="col-lg-1 col-sm-2 control-label" for="fulltime">毕业院校</label>
						<div class="col-lg-5 col-sm-4">
							<input class="form-control" id="fulltime" name="fulltime"
								value="${o.fulltime}" type="text" maxlength=40/>
						</div>
					</div>
					
					<div class="form-group">
						<label class="col-lg-1 col-sm-2 control-label" for="idCardTypeId">证件类型</label>
						<div class="col-lg-5 col-sm-4">
							<select id="idCardTypeId" name="idCardTypeId"
								class="form-control select2">
							</select>
							<input type="hidden" id="idCardType" name="idCardType"
						value="${o.idCardType}" />
						</div>
						<label class="col-lg-1 col-sm-2 control-label" for="idCardNo">证件号码</label>
						<div class="col-lg-5 col-sm-4">
							<input class="form-control" id="idCardNo" name="idCardNo"
								value="${o.idCardNo}" type="text" maxlength=40/>
						</div>
					</div>
					
				<div class="form-group">
						<label class="col-lg-1 col-sm-2 control-label" for="phone">固定电话</label>
						<div class="col-lg-5 col-sm-4">
							<input class="form-control" id="phone" name="phone"
								value="${o.phone}" type="text" maxlength=40/>
						</div>
						<label class="col-lg-1 col-sm-2 control-label" for="mobile">手机号码</label>
						<div class="col-lg-5 col-sm-4">
							<input class="form-control" id="mobile" name="mobile"
								value="${o.mobile}" type="text" maxlength=40/>
						</div>
					</div>
					<div class="form-group">
						<label class="col-lg-1 col-sm-2 control-label" for="email">电子邮箱</label>
						<div class="col-lg-5 col-sm-4">
							<input class="form-control" id="email" name="email"
								value="${o.email}" type="text" maxlength=40/>
						</div>
						
					</div>
					

				</div>
				<div class="col-lg-3 col-sm-4">
					<img id="imgPreview" src='${o.photo}'
						style="width:95%;height:230px;background-image:url(images/noimg.jpg);background-position:center; " />
						<div class="input-group">
								<input class="form-control" id="photo" name="photo" value="${o.photo}"
									type="text" readOnly maxlength=255 />
								<div class="input-group-addon">
									<i id="icon" class="fa fa-image" onclick="onUploadBg()"></i>
								</div>
								<div class="input-group-addon">
									<i id="icon" class="fa fa-trash-o" onclick="onClearBg()"></i>
								</div>
							</div>
				</div>
				
			</div>
			
			国内外学习工作经历：
			<script id="editor" name="editor" type="text/plain"
				style="width:100%;">${o.experience}</script>
			<br/>
			成果和奖励：
			<script id="editor2" name="editor2" type="text/plain"
				style="width:100%;">${o.achievements}</script>
				
			<div class="form-group controls" style="text-align:center">
				<button type="button" class="btn btn-info" onclick="onSave()">保存</button>
				
			</div>
		</form>
	</div>
</body>
</html>
