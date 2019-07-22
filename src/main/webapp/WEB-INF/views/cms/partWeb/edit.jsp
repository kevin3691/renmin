<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>

<title>网站添加</title>
<jsp:include page="/WEB-INF/views/include/head.jsp" />
<link href="./jslib/umeditor/themes/default/css/umeditor.css" type="text/css" rel="stylesheet">
<script type="text/javascript" charset="utf-8" src="./jslib/umeditor/umeditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="./jslib/umeditor/umeditor.min.js"></script>
<script type="text/javascript" src="./jslib/umeditor/lang/zh-cn/zh-cn.js"></script>
<link href="./jslib/uploadify/Huploadify.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="./jslib/uploadify/jquery.Huploadify.js"></script>
 <script language="javascript">
             function onSave () {
         	    //表单验证
            	 var val = document.getElementById("webName").value;
                 if(val == ""){
                	 document.getElementById("msg_webname").style.display="block";  
                     return false;
                 }
         	   var para = $ ("#mainForm").serialize ();
         	    $.post ('cms/partWeb/edit', $ ("#mainForm").serialize (), function (result) {
         		    if (parent.onSaveOk){
         			    parent.onSaveOk (result.entity)
         		    }
         		    else{
         		    	document.location=_BasePath+"cms/partWeb/index"
         		    }
         	    });
             }
         	//返回
         	function onCancel() {
         		var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
         		parent.layer.close(index); //再执行关闭   
         	}
         	//选择部门
        	function onSelOrg() {
        		layer.open({
        			type : 2,
        			title : "选择模板",
        			shadeClose : true,
        			shade : 0.8,
        			area : [ '400', '220' ],
        			content : 'cms/temp/selTemp' //iframe的url
//         			content : 'base/org/sel' //iframe的url
        		});
        	}
        	//选择部门回调方法 
        	function onSelOrgOk(node) {
//         		$("#uncomTempFilePathId").val(node.id);
        		$("#tempId").val(node.id);
        		$("#uncomTempFilePath").val(node.name);
//         		document.getElementById("uncomTempFilePathId").value=node.id;
//         		document.getElementById("uncomTempFilePath").value=node.name;
        		layer.closeAll();
        	}
 </script>
<body>
   <div class="container-fluid">
		<div>&nbsp;</div>
		<form id="mainForm" class="form-horizontal">
			<jsp:include page="/WEB-INF/views/include/recordinfo.jsp" />
			<div class="form-group">
				<input type="hidden" name="id" id="id" value="${c.id}">
				<input type="hidden" name="webPath" id="webPath" value="${c.webPath}">
				<input type="hidden" name="tempId" id="tempId" value="${c.tempId}">
				<input type="hidden" name="partWebTempPath" id="partWebTempPath" value="${c.partWebTempPath}">
				<label class="col-sm-2 control-label" for="name">子站名称：</label>
				<div class="col-sm-4">
					<input class="form-control"  type="text" name="webName" id="webName" value="${c.webName}" >
						<span id="msg_webname"  style="display: none">网站名不能为空</span>
				</div>
				<label class="col-sm-2 control-label" for="name">子站编码：</label>
				<div class="col-sm-4">
					<input class="form-control"  type="text" name="webMark" id="webMark" value="${c.webMark}" >
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="baseOrgName">选择模板：</label>
				<div class="col-sm-4">
					<span class="input-group">                                                    
					 <input class="form-control" id="uncomTempFilePath" name="uncomTempFilePath" type="text" value="${tempName}" required />
						<span class="input-group-btn">
							<button class="btn btn-info btn-flat" type="button"
								onclick="onSelOrg()">选择</button>
						</span>
					</span>
				</div>
			</div>
			<div class="form-group">
            	<label class="col-sm-2 control-label" for="name">子站描述：</label>
            	<div class="col-sm-4"> 
						<textarea rows="3" cols="61" name="webDesc" id="webDesc">${c.webDesc}</textarea>
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
