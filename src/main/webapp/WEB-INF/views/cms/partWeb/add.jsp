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
             function toVaild(){
               
             }
             function onSave () {
             	//表单验证
         	    if (!$ ('#mainForm').validate ().form ()){
         		    return false;
         	    }
         	   var para = $ ("#mainForm").serialize ();
         	    $.post ('cms/partWeb/createWeb', $ ("#mainForm").serialize (), function (result) {
         	    	if (result.error){
        			    layer.msg (result.error);
        			    $ ("#partWebMark").focus ();
        			    return;
        		    }
         		    if (parent.onSaveOk){
         			    parent.onSaveOk (result.entity)
         		    }
         		    else{
//          		    	document.location=_BasePath+"cms/news/index?colSym=${o.colSym}&colTitle=${o.colTitle}"
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
        		$("#uncomTempFilePathId").val(node.id);
        		$("#uncomTempFilePath").val(node.name);
        		layer.closeAll();
        	}
 </script>
<body>
   <div class="container-fluid">
		<div>&nbsp;</div>
		<form id="mainForm" class="form-horizontal">
			<jsp:include page="/WEB-INF/views/include/recordinfo.jsp" />
			<div class="form-group">
				<label class="col-sm-2 control-label" for="name">子站名称：</label>
				<div class="col-sm-4">
					<input class="form-control"  type="text" name="partWebName" id="partWebName" required>
				</div>
<!-- 			</div> -->
<!-- 			<div class="form-group"> -->
				<label class="col-sm-2 control-label" for="partWebMark">子站编码：</label>
				<div class="col-sm-4">
					<input class="form-control"  type="text" name="partWebMark" id="partWebMark" required>
				</div>
			</div>
            <div class="form-group">
				<label class="col-sm-2 control-label" for="baseOrgName">选择模板：</label>
				<div class="col-sm-4">
					<span class="input-group"> 
					 <input type="hidden" id="uncomTempFilePathId" name="uncomTempFilePathId" />
					 <input class="form-control" id="uncomTempFilePath" name="uncomTempFilePath" type="text" readonly required />
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
<!-- 						<input class="form-control"  type="text" name="partWebDesc" id="partWebDesc"> -->
						<textarea rows="5" cols="88" name="partWebDesc" id="partWebDesc"></textarea>
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
