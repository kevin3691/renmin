<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>

<title>栏目编辑</title>
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
            	 var colName = document.getElementById("colName").value;
            	 var colMark = document.getElementById("colMark").value;
                 if(colName == ""){
                	 document.getElementById("msg_colName").style.display="block";  
                     return false;
                 }
                 if(colMark == ""){
                	 document.getElementById("msg_colMark").style.display="block";  
                     return false;
                 }
         	    $.post ('cms/col/saveCol', $ ("#mainForm").serialize (), function (result) {
         		    if (parent.onSaveOk){
         			    parent.onSaveOk (result.entity)
         		    }
         		    else{
         		    	document.location=_BasePath+"cms/col/index"
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
				<input type="hidden" name="id" id="id" value="${c.id}">
				<input type="hidden" id="partWebId" name="partWebId" value="${partWebId }">
				<label class="col-sm-2 control-label" for="name">栏目名称：</label>
				<div class="col-sm-4">
					<input class="form-control"  type="text" name="colName" id="colName" value="${c.colName}">
						<span id="msg_colName"  style="display: none">栏目名不能为空</span>
				</div>
				
				<label class="col-sm-1 control-label" for="isActive">模板</label>
				<div class="col-sm-5">
					<select id="listPath" name="listPath" class="form-control select2">
						<c:forEach items="${htmlFiles }" var="f">
							<c:choose>  
							   <c:when test="${f.value == requestScope.listPath }">
							     <option selected="selected" value="${f.value }">${f.key }</option>
							   </c:when>  
							   <c:otherwise>  
									<option value="${f.value }">${f.key }</option>
							   </c:otherwise>  
							</c:choose>  
						</c:forEach>
					</select>
				</div>
				
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="name">栏目标示：</label>
				<div class="col-sm-4">
					<input class="form-control"  type="text" name="colMark" id="colMark" value="${c.colMark}">
					<span id="msg_colMark"  style="display: none">栏目标示不能为空</span>
				</div>
			</div>
			<div class="form-group">
            	<label class="col-sm-2 control-label" for="name">栏目描述：</label>
            	<div class="col-sm-4">
<!-- 						<input class="form-control"  type="text" name="colDesc" id="colDesc" value="${c.colDesc}"> -->
						<textarea rows="3" cols="61" name="colDesc" id="colDesc">${c.colDesc}</textarea>
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
