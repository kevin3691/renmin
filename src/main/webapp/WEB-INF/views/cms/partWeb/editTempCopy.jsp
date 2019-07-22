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
	 $ (function () {
		 $ (function () {
			    $("#myEditor").height( document.body.clientHeight - 400)
		    })
	 })
	//返回
   	 function onCancel() {
   		var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
   		parent.layer.close(index); //再执行关闭   
   	 }
	 function onSave () {
	    $.post ('cms/partWeb/saveTemp', $ ("#mainForm").serialize (), function (result) {
		    if (parent.onSaveOk){
			    parent.onSaveOk (result.entity)
		    }else{
		    	document.location=_BasePath+"cms/col/index"
		    }
	    });
	 }
 </script>
<body>

	<div class="container-fluid">
		<div>&nbsp;</div>
		<form id="mainForm" class="form-horizontal">
			<div class="form-group">
				<label class="col-sm-1 control-label" for="descr">内容</label>
				<div class="col-sm-11">
					<script type="text/plain" id="myEditor"
						style="width:100%;height:300px;">
						${requestScope.tempContent}
					</script>
					<script type="text/javascript">
						$ (function () {
	                        //实例化编辑器
	                        var um = UM.getEditor ('myEditor');
                        });
					</script>
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
