<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<jsp:include page="/WEB-INF/views/include/head4.jsp" />
<title>工作流 - 编辑</title>
<script type="text/javascript">
	function onSave () {
	    //表单验证
	    if (!$ ('#mainForm').validate ().form ()){
		    return false;
	    }
	    var para = $ ("#mainForm").serialize ();
	    $.post ('workflow/workflow/save', $ ("#mainForm").serialize (), function (result, status) {
		    if (result.error){
			    layer.msg (result.error);
			    return;
		    }
		    layer.msg ("保存成功")
		    $ ("#id").val (result.entity.id);
		    //if (parent.onSaveOk){
		    //  parent.onSaveOk (result.entity)
		    //}
		    //else{
		    //    document.location = "index";
		    //}
	    });
    }
    function onCancel () {
	    document.location = "workflow/workflow/index";
	    //var index = parent.layer.getFrameIndex (window.name); //先得到当前iframe层的索引
	    //parent.layer.close (index); //再执行关闭   
    }
    function loadGrid () {
	    var opts = {
	        url : "workflow/step/list",
	        postData : {
		        wfWorkflowId : $ ("#id").val ()
	        },
	        height : document.body.clientHeight - 545,
	        rownumbers : true,
	        colModel : [
	                {
	                    label : '标题',
	                    name : 'title',
	                    index : 'title',
	                    width : 60
	                },
	                {
	                    label : '代号',
	                    name : 'sym',
	                    index : 'sym',
	                    width : 60
	                },
	                {
	                    label : '上一环节',
	                    name : 'preSteps',
	                    index : 'preSteps',
	                    width : 60
	                },
	                {
	                    label : '下一环节',
	                    name : 'nextSteps',
	                    index : 'nextSteps',
	                    width : 60
	                },
	                {
	                    label : '操作地址',
	                    name : 'actUrl',
	                    index : 'actUrl',
	                    width : 60
	                },
	                {
	                    label : ' ',
	                    name : 'id',
	                    width : 100,
	                    align : 'center',
	                    sortable : false,
	                    formatter : function (value, options, row) {
		                    var btn = "";
		                    btn += '&nbsp;<a href="javascript:onStepSave(' + value + ')" title="">编辑</a>'
		                    btn += '&nbsp;<a href="javascript:onStepSort(' + value + ',' + row.wfWorkflowId
		                            + ',\'up\')" title="">上移</a>'
		                    btn += '&nbsp;<a href="javascript:onStepSort(' + value + ',' + row.wfWorkflowId
		                            + ',\'down\')" title="">下移</a>'
		                    btn += '&nbsp;<a href="javascript:onStepDel(' + value + ')" title="">删除</a>&nbsp;'
		                    return btn;
	                    }
	                }
	        ],
	        rowNum : 20,
	        rowList : [
	                20, 50, 100
	        ],
	        pager : '#pager',
	        sortname : 'lineNo',
	        sortorder : "asc",
	        gridComplete : function () {
	        }
	    }
	    $ ("#grid").jqGrid (opts);
    }
    //编辑
    function onStepSave (id) {
	    if ($ ("#id").val () == "0"){
		    layer.msg ("请先保存流程后再添加环节")
		    return;
	    }
	    id = id || 0;
	    var title = "添加流程环节"
	    if (id > 0){
		    title = "编辑流程环节"
	    }
	    layer.open ({
	        type : 2,
	        title : title,
	        shadeClose : true,
	        shade : 0.8,
	        area : [
	                '800', '510'
	        ],
	        content : 'workflow/step/edit?id=' + id + "&wfWorkflowId=" + $ ("#id").val () + "&wfWorkflowTitle="
	                + $ ("#title").val ()
	    });
    }
    //编辑完成后执行方法
    function onStepSaveOk (entity) {
	    $ ("#grid").jqGrid ("setGridParam", {
		    postData : {
			    wfWorkflowId : $ ("#id").val ()
		    }
	    }).trigger ("reloadGrid");
	    layer.closeAll ();
    }
    //删除
    function onStepDel (id) {
	    layer.confirm ('确定要删除该环节？', {
		    btn : [
		            '确定', '取消'
		    ]
	    //按钮
	    }, function () {
		    $.post ("workflow/step/del", {
			    id : id
		    }, function () {
			    $ ("#grid").trigger ("reloadGrid");
		    });
		    layer.closeAll ();
	    });
    }
    //排序
    function onStepSort (id,wfWorkflowId, order) {
	    $.post ("workflow/step/sort", {
	        id : id,
	        wfWorkflowId:wfWorkflowId,
	        order : order
	    }, function (rest) {
		    $ ("#grid").trigger ("reloadGrid");
	    });
    }
    //初始化
    $ (function () {
	    loadGrid ()
    })
</script>
</head>

<body>
	<div class="container-fluid">
		<div class="breadcrumb content-header form-inline"
			style="padding:8px;height:45px;">
			<ol class="breadcrumb">
				<li><a href="home/dashboard"><i class="fa fa-dashboard"></i>
						首页</a></li>
				<li class="active">编辑流程环节</li>
			</ol>
		</div>
		<form id="mainForm" class="form-horizontal">
			<input type="hidden" id="id" name="id" value="${o.id}" /> <input
				type="hidden" id="lineNo" name="lineNo" value="${o.lineNo}" />
			<jsp:include page="/WEB-INF/views/include/recordinfo.jsp" />
			<div class="form-group">
				<label class="col-sm-1 control-label" for="title">标题</label>
				<div class="col-sm-5">
					<input class="form-control" id="title" name="title"
						value="${o.title}" type="text" required />
				</div>
				<label class="col-sm-1 control-label" for="isActive">状态</label>
				<div class="col-md-5 col-sm-4">
					<select id="isActive" name="isActive" class="form-control select2">
						<option value=1>启用</option>
						<option value=0>停用</option>
					</select>
				</div>
			</div>
			<div class="form-group" style="display: none;">
				<label class="col-sm-1 control-label" for="category">类别</label>
				<div class="col-sm-5">
					<input class="form-control" id="category" name="category"
						value="${o.category}" type="text" />
				</div>
				<label class="col-sm-1 control-label" for="sym">代号</label>
				<div class="col-sm-5">
					<input class="form-control" id="sym" name="sym" value="${o.sym}"
						   type="text" />
				</div>
				
			</div>
			<div class="form-group">
				<label class="col-sm-1 control-label" for="descr">备注</label>
				<div class="col-sm-11">
					<textarea class="form-control" id="descr" name="descr" rows=3>${o.descr}</textarea>
				</div>
			</div>
			<table id="grid"></table>
			<div class="form-group controls" style="text-align:center">
				<button type="button" class="btn btn-info" onclick="onSave()">保存</button>
				&nbsp;&nbsp;
				<button id="btnStepSave" type="button" class="btn btn-info"
					onclick="onStepSave()">添加流程环节</button>
				&nbsp;&nbsp;
				<button type="button" class="btn btn-danger" onclick="onCancel()">返回</button>
			</div>
		</form>
	</div>
</body>
</html>
