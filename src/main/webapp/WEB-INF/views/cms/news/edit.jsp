<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>

<title>新闻 - 编辑</title>
<jsp:include page="/WEB-INF/views/include/head4.jsp" />
<script type="text/javascript" charset="utf-8" src="u000e/config.min.js"></script>
<script type="text/javascript" charset="utf-8" src="u000e/all.min.js"></script>
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
	    layer.load(1);
	    var ue = UE.getEditor ('editor');
	    $ ("#content").val (ue.getContent ());
	    if ($ ("#stts").val () == ""){
		    $ ("#stts").val ("待审核");
	    }
	    var para = $ ("#mainForm").serialize ();
	    $.post ('cms/news/save', $ ("#mainForm").serialize (), function (result) {
	    	layer.closeAll('loading');
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
	    $ ("#imgPreview").attr ('src', "");
    }
    function onUploadSucess (file, res) {
	    $ ("#img").val (res.entity.fileUrl);
	    $ ("#imgPreview").attr ('src', res.entity.fileUrl);
    }
    //返回
    function onCancel () {
	    if ("${returnUrl}" != ""){
		    window.location = _BasePath + "${returnUrl}?colSym=${colSym}&colTitle=" + encodeURI ("${colTitle}");
	    }
	    else{
		    window.location = _BasePath + "cms/news/index?colSym=${colSym}&colTitle=" + encodeURI ("${colTitle}");
	    }
	    /* var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
	    	parent.layer.close(index); //再执行关闭 */
    }
    //ueditor 上传完成后回调
    function ueSimpleUploadCallback(json){
    	$.post("comm/uploader/saveAs",{url:json.url},function(result,stts){
                        		//alert(result+"\n\r"+stts)
                        	})
    }
    //初始化
    $ (function () {
	    UPLOADER.accept = {
	        title : 'Images',
	        extensions : 'gif,jpg,jpeg,bmp,png',
	        mimeTypes : 'image/*'
	    }
	    UPLOADER.formData = {
		    applyTo : 'WfPrintTemp'
	    }
	    UPLOADER.init ();
	    //加载select特效
	    $ (".select2").select2 ();
	    //实例化编辑器
	    var ue = UE.getEditor ('editor');
	    $ ("#editor").height (document.body.clientHeight - 370);
	    //加载日期控件		
	    $ ('#publishAt').datetimepicker ({
	        minView : 0,
	        format : "yyyy-mm-dd hh:ii"
	    });
	    //如果执行时间为空则设为当前时间
	    $ ('#publishAt').val (currentDateTime ())
	    if ("${o.id}" == "0" || "${o.id}" == ""){
		    $ ("#colSym").val ("${colSym}");
		    $ ("#colTitle").val ("${colTitle}");
	    }
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
				type="hidden" id="template" name="template" value="新闻列表" /><input
				type="hidden" id="colSym" name="colSym" value="${o.colSym}" /> <input
				type="hidden" id="colTitle" name="colTitle" value="${o.colTitle}" />
			<input type="hidden" id="width" name="width" value="${o.width}" /> <input
				type="hidden" id="height" name="height" value="${o.height}" /> <input
				type="hidden" id="content" name="content" value="" /> <input
				type="hidden" id="stts" name="stts" value="${o.stts}" /> <input
				type="hidden" id="hits" name="hits" value="${o.hits}" /> <input
				type="hidden" id="top" name="top" value="${o.top}" /> <input
				type="hidden" id="lineNo" name="lineNo" value="${o.lineNo}" />
			<jsp:include page="/WEB-INF/views/include/recordinfo.jsp" />
			<div class="row">
				<div class="col-lg-9 col-sm-8">
					<div class="form-group">
						<label class="col-lg-1  col-sm-2 control-label" for="title">标题</label>
						<div class="col-lg-11 col-sm-10">
							<input class="form-control" id="title" name="title"
								value="${o.title}" type="text" required maxlength=200 />
						</div>
					</div>
					<div class="form-group">
						<label class="col-lg-1 col-sm-2 control-label" for="source">来源</label>
						<div class="col-lg-5 col-sm-4">
							<input class="form-control" id="source" name="source"
								value="${o.source}" type="text" maxlength=60 />
						</div>
						<label class="col-lg-1 col-sm-2 control-label" for="publishAt"
							style="white-space:nowrap; ">发布时间</label>
						<div class="col-lg-5 col-sm-4">
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
						<label class="col-lg-1 col-sm-2 control-label" for="author">作者</label>
						<div class="col-lg-5 col-sm-4">
							<input class="form-control" id="author" name="author"
								value="${o.author}" type="text" maxlength=20 />
						</div>
						<label class="col-lg-1 col-sm-2 control-label" for="url">链接</label>
						<div class="col-lg-5 col-sm-4">
							<input class="form-control url" id="url" name="url"
								value="${o.url}" type="text" />
						</div>
					</div>
					<div class="form-group">
						<label class="col-lg-1 col-sm-2 control-label" for="keyword">关键字</label>
						<div class="col-lg-5 col-sm-4">
							<input class="form-control" id="keyword" name="keyword"
								value="${o.keyword}" type="text" maxlength=255 />
						</div>
						<label class="col-lg-1 col-sm-2 control-label" for="img">缩略图</label>
						<div class="col-lg-5 col-sm-4">
							<div class="input-group">
								<input class="form-control" id="img" name="img" value="${o.img}"
									type="text" readOnly maxlength=255 />
								<div class="input-group-addon">
									<i id="icon" class="fa fa-image" onclick="onUploadBg()"></i>
								</div>
								<div class="input-group-addon">
									<i id="icon" class="fa fa-trash-o" onclick="onClearBg()"></i>
								</div>
							</div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-lg-1 col-sm-2 control-label" for="summary">摘要</label>
						<div class="col-lg-11 col-sm-10">
							<input class="form-control" id="summary" name="summary"
								value="${o.summary}" type="text" maxlength=600 />
						</div>
					</div>

				</div>
				<div class="col-lg-3 col-sm-4">
					<img id="imgPreview" src='${o.img}'
						style="width:95%;height:230px;background-image:url(images/noimg.jpg);background-position:center; " />
				</div>
			</div>
			<script id="editor" name="editor" type="text/plain"
				style="width:100%;">${o.content}</script>
		</form>
	</div>
</body>
</html>