<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<jsp:include page="/WEB-INF/views/include/head4.jsp" />
<title>菜单-编辑</title>
<script type="text/javascript">
	//保存
	function onSave() {
		//表单验证
		if (!$('#mainForm').validate().form()) {
			return false;
		}
		var para = $("#mainForm").serialize();
		$.post('base/menu/save', $("#mainForm").serialize(), function(result,
				status) {
			if (result.error) {
				layer.msg(result.error);
				$("#sym").focus();
				return;
			}
			if (parent.onSaveOk) {
				parent.onSaveOk(result.entity)
			}
		});
	}

	//取消
	function onCancel() {
		var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
		parent.layer.close(index); //再执行关闭   
	}

	//选择图标
	function onPickerIcon() {
		var idx = layer.open({
			type : 2,
			title : "选择图标",
			area : [ "90%", "90%" ],
			maxmin : true,
			content : 'comm/picker/icon'
		});
	}

	//选择图标回调 函数
	function cb4SetIcon(v) {
		$("#icon").removeClass($("#icon").attr("class")).addClass(v);
		$("#img").val(v);
		layer.closeAll();
	}

	//选择模板
	function onTemplateSel() {
		layer.open({
			type : 2,
			title : '选择模板',
			shadeClose : true,
			shade : 0.8,
			area : [ '200', '320' ],
			content : 'base/dict/sel?sym=CMS_TEMPLATE'
		});
	}

	//数据字典回调函数
	function onSelDictOk(nodes, sym) {
		$("#template").val(nodes.title);
		$("#url").val(nodes.value);
		layer.closeAll();
	}

	//初始化
	$(
			function() {
				$(".select2").select2();
				if ("${o.id}" > 0) {
					$("#isActive").select2("val", "${o.isActive}");
					if ($("#img").val() != "") {
						$("#icon").removeClass($("#icon").attr("class"))
								.addClass($("#img").val());
					}
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
				<label class="col-sm-1 control-label" for="title">标题</label>
				<div class="col-sm-5">
					<input class="form-control" id="title" name="title"
						value="${o.title}" type="text" required />
				</div>
				<label class="col-sm-1 control-label" for="sym">代号</label>
				<div class="col-sm-5">
					<input class="form-control" id="sym" name="sym" value="${o.sym}"
						type="text" required />
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-1 control-label" for="url">地址</label>
				<div class="col-sm-5">
					<input class="form-control" id="url" name="url" value="${o.url}"
						type="text" />
				</div>
				<label class="col-sm-1 control-label" for="template">模板</label>
				<div class="col-sm-5">
					<span class="input-group"> <input class="form-control"
						id="template" name="template" value="${o.template}" type="text" />
						<span class="input-group-addon"> <i id="icon"
							class="fa fa-search-plus" onclick="onTemplateSel()"></i>
					</span>
					</span>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-1 control-label" for="img">图标</label>
				<div class="col-sm-5">
					<div class="input-group">
						<input class="form-control" id="img" name="img" value="${o.img}"
							type="text" />
						<div class="input-group-addon">
							<i id="icon" class="fa fa-image" onclick="onPickerIcon()"></i>
						</div>
					</div>
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
