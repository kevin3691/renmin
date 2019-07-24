<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>附件--列表</title>
<jsp:include page="/WEB-INF/views/include/head4.jsp" />
<link rel="stylesheet" type="text/css"
	href="jslib/webuploader/webuploader.min.css">
<script type="text/javascript"
	src="jslib/webuploader/webuploader.min.js"></script>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path;
%>
<script>
	$ (function () {
	    loadGrid ();
    });
    function loadGrid () {
	    var opts = {
	        url : "comm/attachment/list",
	        height : 50,
	        rownumbers : true,
	        postData : {
	            category : "${category}",
	            applyTo : "${applyTo}",
	            refNum : "${refNum}",
	            allowExt : "${allowExt}",
	            allowSize : "${allowSize}",
	            destDir : "${destDir}"
	        },
	        colModel : [
	                {
	                    label : ' ',
	                    name : 'icon',
	                    sortable : false,
	                    width : 35,
	                    formatter : function (value, options, row) {
		                    return "<i class='"+value+"'></i>";
	                    }
	                }, {
	                    label : '标题',
	                    name : 'title',
	                    index : 'title',
	                    sortable : false,
	                    width : 200
	                }, {
	                    label : ' ',
	                    name : 'id',
	                    width : 100,
	                    align : 'center',
	                    sortable : false,
	                    formatter : function (value, options, row) {
		                    var btn = "";
		                    btn += '&nbsp;<a href="javascript:onShow(\''+ row.fileUrl +'\')" title="">查看</a>'
		                    btn += '&nbsp;<a href="<%=basePath%>'+ row.fileUrl +'" title=""  target= "_blank">下载</a>'
		                    if ("${mode}" == "RW"){
			                    btn += '&nbsp;<a href="javascript:onSave(' + value + ')" title="">编辑</a>'
			                    btn += '&nbsp;<a href="javascript:onDel(' + value + ')" title="">删除</a>'
		                    }
		                    return btn;
	                    }
	                }
	        ],
	        rowNum : 100,
	        rowList : [
	                100, 200, 300
	        ],
	        pager : '#pager',
	        sortname : 'id',
	        sortorder : "asc",
	        gridComplete : function () {
		        var rows = $ ("#grid").jqGrid ("getDataIDs").length
		        $ ("#grid").jqGrid ("setGridHeight", "auto")
		        if (parent.document.getElementById ("ifrmAtt")){
			        parent.document.getElementById ("ifrmAtt").style.height = 50 + 40 * rows;
		        }		       
	        }
	    }
	    if ("${mode}" == "RW"){
		    opts.colModel[2].label = '<button onclick="onSelfUpload()" class="btn btn-sm btn-info" type="button"><i class="fa  fa-fw fa-edit"></i>添加附件</button>'
	    }
	    $ ("#grid").jqGrid (opts);
	    jQuery ("#grid").jqGrid ('bindKeys', {
	        "onEnter" : function (rowid) {
		        //alert ("你enter了一行， id为:" + rowid)
	        },
	        "onRightKey" : function (rowid) {
		        if ("${mode}" == "RW"){
			        onDown (rowid)
		        }
	        },
	        "onLeftKey" : function (rowid) {
		        if ("${mode}" == "RW"){
			        onDel (rowid)
		        }
	        },
	        "onSpace" : function (rowid) {
		        onShow (rowid)
	        }
	    });
    }
    //窗口变化时自适应宽度
    window.onresize = function () {
	    $ ("#grid").setGridWidth (document.body.clientWidth - 12);
	    document.location.reload ();
    }
    function onSave (id, pid) {
	    id = id || 0;
	    pid = pid || 0;
	    var title = "添加附件"
	    layer.open ({
	        type : 2,
	        title : title,
	        shadeClose : true,
	        shade : 0.8,
	        area : [
	                '800', '450'
	        ],
	        content : 'comm/attachment/edit?id=' + id + "&parentId=" + pid //iframe的url
	    });
    }
    function onSaveOk (entity) {
	    layer.closeAll ();
	    $ ("#grid").trigger ("reloadGrid");
    }
    function onDel (id) {
	    layer.confirm ('确定要删除该附件？', {
		    btn : [
		            '确定', '取消'
		    ]
	    //按钮
	    }, function () {
		    $.post ("comm/attachment/del", {
			    id : id
		    }, function () {
			    $ ("#grid").trigger ("reloadGrid");
		    });
		    layer.closeAll ();
	    });
    }
     //查看
   function onShow(url) {
		var path="<%=basePath%>";
		url = path + url;
		window.open(url, "att", "")
	}
    //查询
    function onQ () {
	    var para = {
		    title : ""
	    };
	    $ ("#grid").jqGrid ("setGridParam", {
		    postData : para
	    }).trigger ("reloadGrid");
    }
    //显示全部
    function showAll () {
	    $ ("#title").val ("");
	    onQ ();
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
    function onSelfUpload () {
	    $ ("input[name='file']").click ();
    }
    //上传完附件后执行
    function onUploadFinished () {
	    $ ("#grid").trigger ("reloadGrid");
    }
    $ (
            function () {
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
	                fileSizeLimit : "${allowSize}", // 200 M
	                fileSingleSizeLimit : "${allowSize}"
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
		            $ ("#grid").trigger ("reloadGrid");
	            });
	            uploader.on ('uploadError', function (file) {
		            $ ('#' + file.id).find ('p.state').text ('上传出错');
		            $ ("#grid").trigger ("reloadGrid");
		            layer.closeAll ();
	            });
	            uploader.on ('uploadComplete', function (file) {
		            $ ('#' + file.id).find ('.progress').fadeOut ();
		            $ ("#grid").trigger ("reloadGrid");
	            });
	            uploader.on ('uploadFinished', function () {
		            $ ("#grid").trigger ("reloadGrid");
	            });
	            $ ("#ctlBtn").on ('click', function () {
		            uploader.upload ();
	            });
            })
</script>
</head>

<body>
	<div class="container-fluid">
		<div class="breadcrumb content-header form-inline"
			style="display:none;">
			<button class="btn btn-info" id="btnUpload" type="button"
				onclick="onSelfUpload()">上传</button>
		</div>
		<div id="uploader" class="wu-example">
			<!--用来存放文件信息-->
			<div id="thelist" class="uploader-list"></div>
			<div class="btns" style="display:none;">
				<div id="picker">选择文件</div>
				<button id="ctlBtn" class="btn btn-default">开始上传</button>
			</div>
		</div>

		<table id="grid" style="height:35px;"></table>
	</div>
</body>
</html>
