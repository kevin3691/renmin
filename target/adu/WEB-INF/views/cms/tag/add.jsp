<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>

<title>栏目添加</title>
<jsp:include page="/WEB-INF/views/include/head.jsp" />
<link href="./jslib/umeditor/themes/default/css/umeditor.css"
	type="text/css" rel="stylesheet">
<script type="text/javascript" charset="utf-8"
	src="./jslib/umeditor/umeditor.config.js"></script>
<script type="text/javascript" charset="utf-8"
	src="./jslib/umeditor/umeditor.min.js"></script>
<script type="text/javascript"
	src="./jslib/umeditor/lang/zh-cn/zh-cn.js"></script>
<link href="./jslib/uploadify/Huploadify.css" rel="stylesheet"
	type="text/css" />
<script type="text/javascript"
	src="./jslib/uploadify/jquery.Huploadify.js"></script>
 <script language="javascript">
             function toVaild(){
            	
             }
             function onSave () {
            	 //表单验证
            	 var tagName = document.getElementById("tagName").value;
                 if(tagName == ""){
                	 document.getElementById("msg_tagName").style.display="block";  
                     return false;
                 }
         	    $.post ('cms/tag/createTag', $ ("#mainForm").serialize (), function (result) {
         		    if (parent.onSaveOk){
         			    parent.onSaveOk (result.entity)
         		    }
         		    else{
         		    	document.location=_BasePath+"cms/tag/index"
         		    }
         	    });
             }
           //返回
           	function onCancel() {
           		var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
           		parent.layer.close(index); //再执行关闭   
           	}
 </script>
<body>
		
          <div class="container-fluid">
		<div>&nbsp;</div>
		<form id="mainForm" class="form-horizontal">
			<jsp:include page="/WEB-INF/views/include/recordinfo.jsp" />
			<div class="form-group">
				<label class="col-sm-2 control-label" for="name">标签：</label>
				<div class="col-sm-8">
					<input class="form-control"  type="text" name="tagName" id="tagName">
						<span id="msg_tagName"  style="display: none">标签不能为空</span>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="name">标签描述：</label>
				<div class="col-sm-8">
					<textarea rows="7" cols="68" name="tagDesc" id="tagDesc"></textarea>
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
