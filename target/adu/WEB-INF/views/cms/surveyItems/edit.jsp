<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<jsp:include page="/WEB-INF/views/include/head.jsp" />
<title>人员-编辑</title>
<script type="text/javascript">
	//保存
    function onSave () {
	    //表单验证
	    if (!$ ('#mainForm').validate ().form ()){
		    return false;
	    }
	    var para = $ ("#mainForm").serialize ();
	    $.post ('cms/surveyItems/save', $ ("#mainForm").serialize (), function (result, status) {
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
    //选择部门
    function onSelOrg () {
	    layer.open ({
	        type : 2,
	        title : "选择调查主题",
	        shadeClose : true,
	        shade : 0.8,
	        area : [
	                '100%', '100%'
	        ],
	        content : 'cms/surveyTopics/sel' //iframe的url
	    });
    }
    //选择部门回调方法 
    function onSurveyTopicsSelOk (row) {
	    $ ("#topicId").val (row.id);
	    $ ("#topicTitle").val (row.topicTitle);
	    layer.closeAll ()
    }
    //数据字典回调函数,初始化后为其赋值
    function dictCallBack (container) {
	    if (container == "itemType"){
		    $ ("#itemType").select2 ("val", "${o.itemType}");
	    }
    }
    $ (function () {
	    //加载select特效
	    $ (".select2").select2 ();
	    //为日期设置格式输入
	    $ ("#DOB").inputmask ("yyyy-mm-dd", {
		    "placeholder" : "yyyy-mm-dd"
	    });
	    //加载日期控件
	    $ ('#DOB').datetimepicker ({
		    minView : 3
	    //时间，默认为日期时间
	    });
	    //设置掩码
	    $ ('#DOB').inputmask ("yyyy-mm-dd");
	  //加载数据字典--性别
	    bindDictSelect ("itemType", "itemType");
    })
</script>
</head>

<body>
	<div class="container-fluid">
		<div>&nbsp;</div>
		<form id="mainForm" class="form-horizontal">
			<input type="hidden" id="id" name="id" value="${o.id}" />
			<input type="hidden" id="topicId" name="topicId" value="${o.topicId}" />
			<jsp:include page="/WEB-INF/views/include/recordinfo.jsp" />
			<div class="form-group">
				<label class="col-sm-2 control-label" for="name">调查项标题</label>
				<div class="col-sm-10">
					<input class="form-control" id="itemTitle" name="itemTitle" value="${o.itemTitle}"
						type="text" required />
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="topicTitle">调查项主题</label>
				<div class="col-sm-10">
					<div class="input-group">
						<input class="form-control" id="topicTitle" name="topicTitle"
							value="${o.topicTitle}" type="text" readOnly/>
						<div class="input-group-addon">
							<i class="fa fa-search"
								onclick="onSelOrg()"></i>
						</div>
					</div>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="email">调查项类型</label>
				<div class="col-sm-4">
					<select id="itemType" name="itemType" class="form-control select2">
					</select>
				</div>
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
