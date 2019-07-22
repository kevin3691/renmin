<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>

<title>视频新闻 - 编辑</title>
<jsp:include page="/WEB-INF/views/include/head.jsp" />
<link rel="stylesheet" type="text/css"
	href="jslib/webuploader/webuploader.min.css">
<script type="text/javascript"
	src="jslib/webuploader/webuploader.min.js"></script>
<script type="text/javascript" src="jslib/webuploader/uploader.min.js"></script>
<script type="text/javascript">
	//保存
    function onSave () {
	    //表单验证
	    if (!$ ('#mainForm').validate ().form ()){
		    return false;
	    }
	    var para = $ ("#mainForm").serialize ();
	     if ($ ("#stts").val () == ""){
		    $ ("#stts").val ("待审核");
	    }
	    $.post ('cms/news/save', $ ("#mainForm").serialize (), function (result) {
		    onCancel ()
	    });
    }
   
    //上传背景图
    function onUploadBg () {
	    $ ("input[name='file']").click ();
    }
    //清除背景图
    function onClearBg () {
	    $ ("#img").val ("");
    }
    function onUploadSucess (file, res) {
	    $ ("#img").val (res.entity.fileUrl);
    }
    //返回
    function onCancel () {
     if ("${returnUrl}" != ""){
		    window.location = _BasePath + "${returnUrl}?colSym=${colSym}&colTitle=" + encodeURI ("${colTitle}");
	    }
	    else{
		    window.location = _BasePath + "cms/video/index?colSym=${colSym}&colTitle=" + encodeURI ("${colTitle}");
	    }
    }
    //初始化
    $ (function () {
	    //加载日期控件		
	    $ ('#publishAt').datetimepicker ({
	        minView : 0,
	        format : "yyyy-mm-dd hh:ii"
	    });
	    //如果执行时间为空则设为当前时间
	    if ($ ('#publishAt').val () == ""){
		    $ ('#publishAt').val (currentDateTime ())
	    }
	    if ("${o.id}" == "0" || "${o.id}" == ""){
		    $ ("#colSym").val ("${colSym}");
		    $ ("#colTitle").val ("${colTitle}");
	    }
	    
	    UPLOADER.accept = {
	        title : 'Images',
	        extensions : '*.*'
	    }
	    UPLOADER.formData = {
		    applyTo : 'WfPrintTemp'
	    }
	    UPLOADER.init ();
	 
    })
</script>
</head>
<body>
	<div class="container-fluid">
		<div class="breadcrumb content-header form-inline"
			style="padding:8px;">
			<div class="form-group">
				<button type="button" class="btn btn-info" onclick="onSave()">保存</button>
				&nbsp;
				<button type="button" class="btn btn-danger" onclick="onCancel()">返回</button>
			</div>
			<ol class="pull-right breadcrumb">
				<li><a href="home/dashboard"><i class="fa fa-dashboard"></i>
						首页</a></li>
				<li class="active">${colTitle}</li>
			</ol>
		</div>
		<form id="mainForm" class="form-horizontal">
			<input type="hidden" id="id" name="id" value="${o.id}" /> <input
				type="hidden" id="template" name="template" value="视频新闻" /> <input
				type="hidden" id="colSym" name="colSym" value="${o.colSym}" /> <input
				type="hidden" id="colTitle" name="colTitle" value="${o.colTitle}" />
			<input type="hidden" id="top" name="top" value="${o.top}" /> <input
				type="hidden" id="width" name="width" value="${o.width}" /> <input
				type="hidden" id="height" name="height" value="${o.height}" /> <input
				type="hidden" id="content" name="content" value="" /> <input
				type="hidden" id="stts" name="stts" value="${o.stts}" /> <input
				type="hidden" id="lineNo" name="lineNo" value="${o.lineNo}" />
			<jsp:include page="/WEB-INF/views/include/recordinfo.jsp" />

			<div class="form-group">
				<label class="col-md-1 col-sm-2 control-label" for="title">标题</label>
				<div class="col-md-5 col-sm-4">
					<input class="form-control" id="title" name="title"
						value="${o.title}" type="text" required />
				</div>
				<label class="col-md-1 col-sm-2 control-label" for="publishAt">发布时间</label>
				<div class="col-md-5 col-sm-4">
					<div class="input-group">
						<input class="form-control" id="publishAt" name="publishAt"
							value="${o.publishAt}" type="text" />
						<div class="input-group-addon">
							<i id="icon" class="fa fa-calendar"
								onclick="$('#publishAt').datetimepicker('show');"></i>
						</div>
					</div>
				</div>
			</div>
			<div class="form-group">
				<label class="col-lg-1 col-sm-2 control-label" for="keyword">类型</label>
				<div class="col-lg-5 col-sm-4">
					<input class="form-control" id="keyword" name="keyword"
						value="${o.keyword}" type="text" maxlength=20 />
				</div>
				<label class="col-lg-1 col-sm-2 control-label" for="summary">片长</label>
				<div class="col-lg-5 col-sm-4">
					<input class="form-control" id="summary" name="summary"
						value="${o.summary}" type="text" maxlength=50 />
				</div>
			</div>
			<div class="form-group">
				<label class="col-md-1 col-sm-2 control-label" for="url">链接地址</label>
				<div class="col-md-5 col-sm-4">
					<input class="form-control" id="url" name="url" value="${o.url}"
							type="text" />
				</div>
				<label class="col-md-1 col-sm-2 control-label" for="url">上传</label>
				<div class="col-md-5 col-sm-4">
					<div class="input-group">
						<input class="form-control" id="img" name="img" value="${o.img}"
							type="text" readOnly  />
						<div class="input-group-addon">
							<i id="icon" class="fa fa-folder-open" onclick="onUploadBg()"></i>
						</div>
						<div class="input-group-addon">
							<i id="icon" class="fa fa-trash-o" onclick="onClearBg()"></i>
						</div>
					</div>
				</div>
			</div>
			<div class="form-group">
				<label class="col-lg-1 col-sm-2 control-label" for="content">说明</label>
				<div class="col-lg-11 col-sm-10">
					<textarea class="form-control" id="content" name="content"
						value="${o.content}" rows="8" cols=""></textarea>
				</div>
			</div>
		</form>
	</div>
</body>
</html>