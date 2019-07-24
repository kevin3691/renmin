<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<jsp:include page="/WEB-INF/views/include/head4.jsp" />
<title>机构-编辑</title>
<script type="text/javascript">
	function onSave() {
		//表单验证
	    if (!$ ('#mainForm').validate ().form ()){
		    return false;
	    }

		var para = $("#mainForm").serialize();
		$.post(_BasePath + 'base/org/save', $("#mainForm").serialize(),
				function(result, status) {
					if (parent.onSaveOk) {
						parent.onSaveOk(result.entity)
					}
				});
	}

	function onCancel() {
		var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
		parent.layer.close(index); //再执行关闭   
	}

	$(function() {
        $(".select2").select2();
		
		if ("${o.id}" > 0) {
			$("#isActive").select2("val", "${o.isActive}");
		}
	})
</script>
</head>

<body>
	<div class="container-fluid">
		<div>&nbsp;</div>
		<form id="mainForm" class="form-horizontal">
			<input type="hidden" id="id" name="id" value="${o.id}" />
			<input type="hidden" id="lineNo" name="lineNo" value="${o.lineNo}" />
			<jsp:include page="/WEB-INF/views/include/basetree.jsp" />
			<jsp:include page="/WEB-INF/views/include/recordinfo.jsp" />
			<div class="form-group">
				<label class="col-sm-2 control-label" for="name">机构名称</label>
				<div class="col-sm-4">
					<input class="form-control" id="name" name="name" value="${o.name}"
						type="text" requried />
				</div>
				<label class="col-sm-2 control-label" for="sym">机构代码</label>
				<div class="col-sm-4">
					<input class="form-control" id="sym" name="sym" value="${o.sym}"
						type="text" />
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="fullName"
					style="min-widht:80px;">全称</label>
				<div class="col-sm-4">
					<input class="form-control" id="fullName" name="fullName"
						value="${o.fullName}" type="text" />
				</div>
				<label class="col-sm-2 control-label" for="legalRepresentative">法人代表</label>
				<div class="col-sm-4">
					<input class="form-control" id="legalRepresentative"
						name="legalRepresentative" value="${o.legalRepresentative}"
						type="text" />
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="contactPerson">联系人</label>
				<div class="col-sm-4">
					<input class="form-control" id="contactPerson" name="contactPerson"
						value="${o.contactPerson}" type="text" />
				</div>
				<label class="col-sm-2 control-label" for="phone">联系电话</label>
				<div class="col-sm-4">
					<input class="form-control" id="phone" name="phone"
						value="${o.phone}" type="text" />
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="fax">传真</label>
				<div class="col-sm-4">
					<input class="form-control" id="fax" name="fax" value="${o.fax}"
						type="text" />
				</div>
				<label class="col-sm-2 control-label" for="email">邮箱</label>
				<div class="col-sm-4">
					<input class="form-control" id="email" name="email"
						value="${o.email}" type="text" />
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="website">网址</label>
				<div class="col-sm-10">
					<input class="form-control" id="website" name="website"
						value="${o.website}" type="text" />
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="address">地址</label>
				<div class="col-sm-10">
					<input class="form-control" id="address" name="address"
						value="${o.address}" type="text" />
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="isActive">状态</label>
				<div class="col-sm-4">
					<select id="isActive" name="isActive" class="form-control select2">
						<option value=1>启用</option>
						<option value=0>停用</option>
					</select>
				</div>
				<label class="col-sm-2 control-label" for=""></label>
				<div class="col-sm-4"></div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="descr">备注</label>
				<div class="col-sm-10">
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
