<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>单页文档</title>
<jsp:include page="/WEB-INF/views/include/head4.jsp" />
<script type="text/javascript" charset="utf-8" src="u000e/config.min.js"></script>
<script type="text/javascript" charset="utf-8" src="u000e/all.min.js"></script>
<script type="text/javascript">
	//保存
    function onSave () {
	    //表单验证
	    if (!$ ('#mainForm').validate ().form ()){
		    return false;
	    }
	    var ue = UE.getEditor ('editor');
	    $ ("#content").val (ue.getContent ());
	    $ ("#stts").val ("发布");
	    var para = $ ("#mainForm").serialize ();
	    $.post ('cms/news/save', $ ("#mainForm").serialize (), function (result) {
		    $("#id").val(result.entity.id);
		    layer.msg("保存成功");
	    });
    }
    //ueditor 上传完成后回调
    function ueSimpleUploadCallback(json){
    	$.post("comm/uploader/saveAs",{url:json.url},function(result,stts){
                        		//alert(result+"\n\r"+stts)
                        	})
    }
    
    //初始化
    $ (function () {
	    var ue = UE.getEditor ('editor');
	    $ ("#editor").height (document.body.clientHeight - 125);
	    if ("${o.id}" == "0" || "${o.id}" == ""){
		    $ ("#colSym").val ("${colSym}");
		    $ ("#colTitle").val ("${colTitle}");
		    $ ("#title").val ("${colTitle}");
	    }
    })
</script>
</head>

<body>
	<div class="container-fluid">
		<form id="mainForm" class="form-horizontal">
			<div class="breadcrumb content-header form-inline"
				style="padding:8px;">
					<label for="title">标题</label> <input class="form-control"
						id="title" name="title" value="${o.title}" style="width:390px;"
						type="text" />
					<button type="button" class="btn btn-info" onclick="onSave()">保存</button>
					&nbsp;
				<ol class="pull-right breadcrumb">
					<li><a href="home/dashboard"><i class="fa fa-dashboard"></i>
							首页</a></li>
					<li class="active">${colTitle}</li>
				</ol>
			</div>

			<input type="hidden" id="id" name="id" value="${o.id}" /> <input
				type="hidden" id="template" name="template" value="单篇文章" /><input
				type="hidden" id="colSym" name="colSym" value="${o.colSym}" /> <input
				type="hidden" id="colTitle" name="colTitle" value="${o.colTitle}" />
			<input type="hidden" id="source" name="source" value="${o.source}" />
			<input type="hidden" id="author" name="author" value="${o.author}" />
			<input type="hidden" id="keyword" name="keyword" value="${o.keyword}" />
			<input type="hidden" id="summary" name="summary" value="${o.summary}" />
			<input type="hidden" id="img" name="img" value="${o.img}" /><input
				type="hidden" id="url" name="url" value="${o.url}" /> <input
				type="hidden" id="width" name="width" value="${o.width}" /><input
				type="hidden" id="height" name="height" value="${o.height}" /> <input
				type="hidden" id="content" name="content" value="" /> <input
				type="hidden" id="publishAt" name="publishAt" value="${o.publishAt}" />
			<input type="hidden" id="stts" name="stts" value="${o.stts}" /> <input
				type="hidden" id="hits" name="hits" value="${o.hits}" /> <input
				type="hidden" id="top" name="top" value="${o.top}" /> <input
				type="hidden" id="isActive" name="isActive" value="${o.isActive}" />
			<input type="hidden" id="lineNo" name="lineNo" value="${o.lineNo}" />
			<jsp:include page="/WEB-INF/views/include/recordinfo.jsp" />
			<script id="editor" name="editor" type="text/plain"
				style="width:100%;">${o.content}</script>
		</form>
	</div>
</body>
</html>
