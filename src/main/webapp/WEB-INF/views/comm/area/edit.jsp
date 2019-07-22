<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<jsp:include page="/WEB-INF/views/include/head.jsp" />
<title>区域管理--编辑</title>
<script type="text/javascript">
	function onSave () {
	    //表单验证
	    var vali = $ ('#mainForm').validate ({
		    rules : {
		        category : {
			        required : true,
		        },
		        name : {
			        required : true,
		        },
		        sym : {
			        required : true,
		        }
		    }
	    });
	    if (!vali.form ()){
		    return false;
	    }
	    var para = $ ("#mainForm").serialize ();
	    $.post ('comm/area/save', $ ("#mainForm").serialize (), function (result, status) {
		    if (result.error){
			    layer.msg (result.error);
			    $ ("#sym").focus ();
			    return;
		    }
		    if (parent.onSaveOk){
			    parent.onSaveOk (result.entity)
		    }
	    });
    }
    //返回
    function onCancel () {
	    var index = parent.layer.getFrameIndex (window.name); //先得到当前iframe层的索引
	    parent.layer.close (index); //再执行关闭   
    }
    //数据字典回调函数,初始化后为其赋值
    function dictCallBack (container) {
	    if (container == "category"){
		    $ ("#category").select2 ("val", "${o.category}");
		    if ("${o.id}" == "0"){
			    $ ("#category").select2 ("val", "${o.category}");
		    }
	    }
    }
    $ (function () {
	    $ (".select2").select2 ();
	    //加载数据字典--区域类别
	    bindDictSelect ("AREACATEGORY", "category");
	    
	    var pathName = "${o.baseTree.pathName}"
	    if(pathName!="")
	    {
	    	pathName = pathName.substring(1,pathName.length-1).replace("."," / ");
	    	$("#lblPathName").html(pathName)
	    } 
    })
</script>
</head>

<body>
	<div class="container-fluid">
		<div>&nbsp;</div>
		<form id="mainForm" class="form-horizontal">
			<input type="hidden" id="id" name="id" value="${o.id}" /> <input
				type="hidden" id="lineNo" name="lineNo" value="${o.lineNo}" />
			<jsp:include page="/WEB-INF/views/include/basetree.jsp" />
			<jsp:include page="/WEB-INF/views/include/recordinfo.jsp" />
			<div class="form-group">
				<label class="col-sm-1 control-label">上级
				</label>
				<label id="lblPathName" class="col-sm-11 control-label" style="text-align:left;">
				</label>
			</div>
			<div class="form-group">
				<label class="col-sm-1 control-label" for="category">类别</label>
				<div class="col-sm-5">
					<select id="category" name="category" class="form-control select2">

					</select>
				</div>
				<label class="col-sm-1 control-label" for="name">名称</label>
				<div class="col-sm-5">
					<input class="form-control" id="name" name="name" type="text"
						value="${o.name}" />
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-1 control-label" for="zipcode">邮编</label>
				<div class="col-sm-5">
					<input class="form-control" id="zipcode" name="zipcode" type="text"
						value="${o.zipcode}" />
				</div>
				<label class="col-sm-1 control-label" for="areacode">区号</label>
				<div class="col-sm-5">
					<input class="form-control" id="areacode" name="areacode" type="text"
						value="${o.areacode}" />
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-1 control-label" for="sym">代号</label>
				<div class="col-sm-5">
					<input class="form-control" id="sym" name="sym" type="text"
						value="${o.sym}" />
				</div>
				<label class="col-sm-1 control-label" for="isActive">状态</label>
				<div class="col-sm-5">
					<select id="isActive" name="isActive" class="form-control select2">
						<option value=1>启用</option>
						<option value=0>停用</option>
					</select>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-1 control-label" for="descr">备注</label>
				<div class="col-sm-11">
					<textarea class="form-control" id="descr" name="descr" rows=3>${o.descr}</textarea>
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
