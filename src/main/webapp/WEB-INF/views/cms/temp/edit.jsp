<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>

<title>模板编辑</title>
<jsp:include page="/WEB-INF/views/include/head.jsp" />
<link href="./jslib/umeditor/themes/default/css/umeditor.css" type="text/css" rel="stylesheet">
<script type="text/javascript" charset="utf-8" src="./jslib/umeditor/umeditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="./jslib/umeditor/umeditor.min.js"></script>
<script type="text/javascript" src="./jslib/umeditor/lang/zh-cn/zh-cn.js"></script>
<link href="./jslib/uploadify/Huploadify.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="./jslib/uploadify/jquery.Huploadify.js"></script>
     
     
	 <script language="javascript">
	//返回
 	function onCancel() {
 		var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
 		parent.layer.close(index); //再执行关闭   
 	}
 	 function check () {
    	 //表单验证
    	 var tagName = document.getElementById("name").value;
         if(tagName == ""){
        	 document.getElementById("msg_name").style.display="block";  
             return false;
         }
     }
 	//保存
     function onSave () {
 	    var para = $ ("#mainForm").serialize ();
 	    $.post ('cms/temp/save', $ ("#mainForm").serialize (), function (result) {
 	    	if (parent.onSaveOk) {
 				parent.onSaveOk(result.entity);
 			}
 	    });
     }
 	
     $(function(){
	     $('#upload').Huploadify({
	         auto: true,//是否启用自动上传
	         fileTypeExts: '*.jpg;*.png;*.zip',//文件可上传的类型
	         multi: false,//是否启用多选
	         formData: { key: 123456, key2: 'vvvv' },
	         fileSizeLimit: 99999,//文件大小限制
	         showUploadedPercent: true,//是否实时显示上传的百分比，如20%
	         showUploadedSize: true,//是否显示文件大小
	         removeTimeout: 9999999,//超时时间
	         uploader: '/lb-cms/cms/temp/upload',
	         onUploadStart: function () {
	             //alert('开始上传');
	         },
	         onInit: function () {
	             //alert('初始化');
	         },
	         onUploadComplete: function (data) {
	         },
	         onDelete: function (file) {
	         },
             onUploadSuccess:function(file, data, response){
            	 var paths=data.split(","); //字符分割
            	 document.getElementById("comFilePath").value = paths[0];
            	 document.getElementById("uncomFilePath").value = paths[1];
            	 
             }
	     });
     })
	 </script>
</head>
<body>
	
	  <div class="container-fluid">
		<div>&nbsp;</div>
		<form id="mainForm" class="form-horizontal" action="<%=request.getContextPath()%>/cms/temp/uploadFile" method="POST" 
			enctype="multipart/form-data" onsubmit="return check()">
			
			<input type="hidden" id="id" name="id" value="${c.id }" />
			<input type="hidden" id="comFilePath" name="comFilePath" value="${c.comFilePath }" />
			<input type="hidden" id="uncomFilePath" name="uncomFilePath" value="${c.uncomFilePath }"/>
			
<!-- 			<div class="form-group"> -->
<!-- 				<label class="col-sm-2 control-label" for="releasDate">附件</label> -->
<!-- 				<div class="col-sm-10"> -->
<!-- 					<div class="input-group"> -->
<!-- 						<div id="upload"></div> -->
<!-- 					</div> -->
<!-- 				</div> -->
<!-- 			</div> -->
			
			<div class="form-group">
				<label class="col-sm-2 control-label" for="name">模板名：</label>
				<div class="col-sm-4">
					<input class="form-control"  type="text" name="name" id="name" value="${c.name }" >
<!-- 					<span id="msg_name"  style="display: none">模板名不能为空</span> -->
				</div>
			</div>
			<div class="form-group">
            	<label class="col-sm-2 control-label" for="name">模板描述：</label>
            	<div class="col-sm-4">
						<textarea rows="7" cols="81" name="tempDiscribe" id="tempDiscribe" >${c.tempDiscribe }</textarea>
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
