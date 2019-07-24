<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>附件--列表</title>
<jsp:include page="/WEB-INF/views/include/head.jsp" />
<link rel="stylesheet" type="text/css"
	href="jslib/webuploader/webuploader.min.css">
<script type="text/javascript"
	src="jslib/webuploader/webuploader.min.js"></script>
<script type="text/javascript" src="jslib/layer/extend/layer.ext.min.js"></script>
<script>
	function initUploader () {
	    var uploader = WebUploader.create ({
	        // swf文件路径
	        swf : _BasePath + 'jslib/webuploader/Uploader.swf',
	        // 文件接收服务端。
	        server : 'comm/attachment/uploader',
	        // 选择文件的按钮。可选。
	        // 内部根据当前运行是创建，可能是input元素，也可能是flash.
	        pick : '#picker',
	        // 不压缩image, 默认如果是jpeg，文件上传前会压缩一把再上传！
	        resize : false,
	        formData : {
	            category : "${category}",
	            applyTo : "${applyTo}",
	            refNum : "${refNum}",
	            allowExt : "${allowExt}",
	            allowSize : "${allowSize}",
	            destDir : "${destDir}"
	        },
	        accept : {
		        extensions : "${allowExt}"
	        },
	        fileNumLimit : 300,
	        fileSizeLimit : ${allowSize}, // 200 M
	        fileSingleSizeLimit : ${allowSize}
	    // 50 M
	    });
	    // 当有文件被添加进队列的时候
	    uploader.on ('fileQueued', function (file) {
		    //showProgress ();
		    $ ("#thelist").append (
		            '<div id="' + file.id + '" class="item">' + '<h4 class="info">' + file.name + '</h4>'
		                    + '<p class="state">等待上传...</p>' + '</div>');
		    uploader.upload ();
	    });
	    // 文件上传过程中创建进度条实时显示。
	    uploader.on ('uploadProgress', function (file, percentage) {
		    var $li = $ ('#' + file.id), $percent = $li.find ('.progress .progress-bar');
		    // 避免重复创建
		    if (!$percent.length){
			    $percent = $ (
			            '<div class="progress progress-striped active">'
			                    + '<div class="progress-bar" role="progressbar" style="width: 0%">' + '</div>'
			                    + '</div>').appendTo ($li).find ('.progress-bar');
		    }
		    $li.find ('p.state').text ('上传中');
		    $percent.css ('width', percentage * 100 + '%');
	    });
	    uploader.on ('uploadSuccess', function (file) {
		    $ ('#' + file.id).remove ();
	    });
	    uploader.on ('uploadError', function (file) {
		    $ ('#' + file.id).find ('p.state').text ('上传出错');
		    layer.closeAll ();
	    });
	    uploader.on ('uploadComplete', function (file) {
		    $ ('#' + file.id).find ('.progress').fadeOut ();
		    var s = ""
		    for ( var k in file){
			    s += k + "=" + file[k] + "\r\n"
		    }
		    loadImage ();
	    });
	    uploader.on ('uploadFinished', function () {
	    });
	    $ ("#ctlBtn").on ('click', function () {
		    uploader.upload ();
	    });
    }
    function showProgress () {
	    layer.open ({
	        type : 1,
	        title : false,
	        closeBtn : 0,
	        area : [
	                '100%', '50%'
	        ],
	        skin : 'layui-layer-nobg', //没有背景色
	        shadeClose : true,
	        content : $ ('#uploader')
	    });
    }
    //上传完附件后执行
    function onUploadFinished () {
	    //$ ("#grid").trigger ("reloadGrid");
    }
    //上传按钮点击
    function onSelfUpload () {
	    $ ("input[name='file']").click ();
    }
    //新窗口显示    
    function onShowLarge () {
	    parent.layer.open ({
	        type : 2,
	        area : [
	                '80%', '90%'
	        ],
	        fix : false, //不固定
	        maxmin : true,
	        content : document.location.href
	    });
    }
    //查看大图
    function onShowAlbum () {
	    var json = {
	        "title" : "宗地图", //相册标题
	        "id" : 1, //相册id
	        "start" : 0, //初始显示的图片序号，默认0
	        "data" : [ //相册包含的图片，数组格式
	        ]
	    }
	    for (var i = 0; i < _Rows.length; i++){
		    json.data.push ({
		        alt : _Rows[i].title,
		        pid : _Rows[i].id,
		        src : _BasePath + _Rows[i].fileUrl,
		        thumb : ""
		    })
	    }
	    if (parent.showAlbum){
	    	parent.showAlbum (json);
	    }
	    else{
	    	layer.photos ({
			    photos : json
		    });
	    }
    }
    //删除
    function onDel () {
	    layer.confirm ('确定要删除该图片？', {
		    btn : [
		            '确定', '取消'
		    ]
	    //按钮
	    }, function () {
		    id = 0;
		    if (_Rows.length > 0){
			    id = _Rows[_Rows.length - 1].id;
		    }
		    $.post ("comm/attachment/del", {
			    id : id
		    }, function () {
			    loadImage ()
		    });
		    layer.closeAll ();
	    });
    }
    var _Rows = []
    //装载图片
    function loadImage () {
	    $.post ("comm/attachment/list", {
	        applyTo : "${applyTo}",
	        refNum : "${refNum}",
	        category : "${category}",
	        sidx : "id",
	        sord : "desc"
	    }, function (result) {
		    _Rows = result.rows;
		    $ ("#imgMain").attr ("src", "")
		    if (_Rows.length > 0){
			    $ ("#imgMain").width (document.body.clientWidth);
			    $ ("#imgMain").attr ("src", _Rows[0].fileUrl)
		    }
	    });
    }
    //窗口变化时自适应宽度
    window.onresize = function () {
	    //document.location.reload ();
    }
    $ (function () {
	    loadImage ();
	    initUploader ();
    })
</script>
</head>

<body style="overflow:hidden;">
	<div class="container-fluid">
		<div class="btn-group"
			style="position:absolute;right:5px;z-index:2000;">
			<button title="查看图册" onclick="onShowAlbum()"
				class="btn btn-sm btn-info" type="button">
				<i class="fa fa-file-image-o"></i>
			</button>
			<button title="${uploadLabel}" onclick="onSelfUpload()"
				class="btn btn-sm btn-info" type="button">
				<i class="fa  fa-fw fa-edit"></i>
			</button>
			<button title="删除" onclick="onDel()" class="btn btn-sm btn-info"
				type="button">
				<i class="fa fa-trash"></i>
			</button>
		</div>
		<div id="uploader" class="wu-example" style="overflow:hidden;">
			<!--用来存放文件信息-->
			<div id="thelist" class="uploader-list"></div>
			<div class="btns" style="display:none;">
				<div id="picker">选择文件</div>
				<button id="ctlBtn" class="btn btn-default">开始上传</button>
			</div>
		</div>
		<div style="text-align:center;">
			<img id="imgMain" align="center" height="100%" alt="" src="">
		</div>
	</div>
</body>
</html>
