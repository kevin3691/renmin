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
<script type="text/javascript" src="jslib/webuploader/uploader.src.js"></script>
<script> 
	function loadGrid () {
	    $ ("#grid").jqGrid (
	            {
	                url : "comm/attachment/list",
	                height : document.body.clientHeight - 180,
	                rownumbers : true,
	                colModel : [
	                        {
	                            label : '&nbsp;',
	                            name : 'icon',
	                            index : 'icon',
	                            align : 'center',
	                            width : 30,
	                            formatter : function (value, options, row) {
		                            return "<i class='"+value+"'></i>";
	                            }
	                        },
	                        {
	                            label : '标题',
	                            name : 'title',
	                            index : 'title',
	                            width : 200
	                        },
	                        {
	                            label : '类别',
	                            name : 'category',
	                            index : 'category',
	                            width : 90
	                        },
	                        {
	                            label : '依附于',
	                            name : 'applyTo',
	                            index : 'applyTo',
	                            width : 60
	                        },
	                        {
	                            label : '文件地址',
	                            name : 'fileUrl',
	                            index : 'fileUrl',
	                            width : 120
	                        },
	                        {
	                            label : '文件大小',
	                            name : 'fileSize',
	                            index : 'fileSize',
	                            width : 80,
	                            formatter : function (value, options, row) {
		                            var s = commafy (value / 1024);
		                            s = s != "0" ? s : "<1";
		                            return s + "KB";
	                            }
	                        },
	                        {
	                            label : '上传时间',
	                            name : 'createdAt',
	                            index : 'createdAt',
	                            sortable : false,
	                            width : 140,
	                            formatter : function (value, options, row) {
		                            return jsonDateTimeFormatter (row.recordInfo.createdAt, 2);
	                            }
	                        },
	                        {
	                            label : '上传人',
	                            name : 'createdByName',
	                            index : 'createdByName',
	                            width : 60,
	                            formatter : function (value, options, row) {
		                            return row.recordInfo.createdByName;
	                            }
	                        },
	                        {
	                            label : ' ',
	                            name : 'id',
	                            width : 140,
	                            align : 'center',
	                            sortable : false,
	                            formatter : function (value, options, row) {
		                            var btn = "";
		                            btn += '&nbsp;<a href="javascript:onShow(\'' + row.fileUrl + '\',\'' + row.fileExt
		                                    + '\')" title="">查看</a>'
		                            btn += '&nbsp;<a href="comm/attachment/download?filePath=' + row.filePath
		                                    + '" title="">下载</a>'
		                            btn += '&nbsp;<a href="javascript:onSave(' + value + ')" title="">编辑</a>'
		                            btn += '&nbsp;<a href="javascript:onDel(' + value + ')" title="">删除</a>'
		                            return btn;
	                            }
	                        }
	                ],
	                rowNum : 20,
	                rowList : [
	                        20, 50, 100
	                ],
	                pager : '#pager',
	                sortname : 'id',
	                sortorder : "asc",
	            });
	    jQuery ("#grid").jqGrid ('bindKeys', {
	        "onEnter" : function (rowid) {
		        //alert ("你enter了一行， id为:" + rowid)
	        },
	        "onRightKey" : function (rowid) {
		        onDown (rowid)
	        },
	        "onLeftKey" : function (rowid) {
		        onDel (rowid)
	        },
	        "onSpace" : function (rowid) {
		        onShow (rowid)
	        }
	    });
    }
    function onSave (id) {
	    id = id || 0;
	    var title = "编辑附件"
	    layer.open ({
	        type : 2,
	        title : title,
	        shadeClose : true,
	        shade : 0.8,
	        area : [
	                '800', '470'
	        ],
	        content : 'comm/attachment/edit?id=' + id //iframe的url
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
    function onShow (url, fileExt) {
	    url = _BasePath + "/" + url;
	    if (".jpg;.gif;.bmp;.png".indexOf (fileExt) >= 0){
		    showPhoto (url)
	    }
	    else{
		    window.open (url, "att", "")
	    }
    }
    function showPhoto (url) {
	    layer.photos ({
		    photos : {
		        "title" : "", //相册标题
		        "id" : 0, //相册id
		        "start" : 0, //初始显示的图片序号，默认0
		        "data" : [ //相册包含的图片，数组格式
			        {
			            "alt" : "图片名",
			            "pid" : 0, //图片id
			            "src" : url, //原图地址
			            "thumb" : "" //缩略图地址
			        }
		        ]
		    }
	    });
    }
    function onUpload (flag) {
	    flag = flag || "";
	    var title = "上传附件";
	    var url = 'comm/attachment/upload';
	    if (flag == "preview"){
		    url = 'comm/attachment/preUpload';
	    }
	    else if (flag == "corpper"){
		    url = 'comm/attachment/cropUpload';
	    }
	    layer.open ({
	        type : 2,
	        title : title,
	        shadeClose : true,
	        shade : 0.8,
	        area : [
	                '800', '450'
	        ],
	        content : url
	    //iframe的url
	    });
    }
    function onSelfUpload () {
	    $ ("input[name='file']").click ();
    }
    //上传完附件后执行
    function onUploadFinished () {
	    onQ ();
    }
    //查询
    function onQ () {
	    var para = {
	        title : $ ("#title").val (),
	        category : $ ("#category").val (),
	        applyTo : $ ("#applyTo").val (),
	        startAt : $ ("#startAt").val (),
	        endAt : $ ("#endAt").val (),
	        personName : $ ("#personName").val ()
	    };
	    $ ("#grid").jqGrid ("setGridParam", {
		    postData : para
	    }).trigger ("reloadGrid");
    }
    //显示全部
    function showAll () {
	    $ ("#title").val ("");
	    $ ("#category").val ("");
	    $ ("#applyTo").val ("");
	    $ ("#startAt").val ("");
	    $ ("#endaAt").val ("");
	    $ ("#personName").val ("");
	    onQ ();
    }
    //附件上传完成后回调 
    function onUploadSucess (file, res) {
	    onQ ();
    }
    $ (function () {
	    UPLOADER.formData = {
		    applyTo : "CommAttachment",
	    }
	    UPLOADER.accept = {
	        title : 'Images',
	        extensions : 'gif,jpg,jpeg,bmp,png',
	        mimeTypes : 'image/*'
	    }
	    UPLOADER.init ();
	    $ ('#startAt').datetimepicker ({
		    minView : 3
	    });
	    $ ('#endAt').datetimepicker ({
		    minView : 3
	    });
	    loadGrid ();
    });
</script>
</head>
<body>
	<div class="container-fluid">
		<ul class="nav nav-tabs" style="padding-top:10px;">
			<li class="active"><a href="comm/attachment/index">附件列表</a></li>
			<li><a href="comm/attachment/preIndex">预览列表</a></li>
			<li><a href="comm/attachment/testIndex">测试引用附件</a></li>
			<li style="float:right;"><div>
					<button class="btn btn-info" id="btnUpload" type="button"
						onclick="onSelfUpload()">上传</button>
					<button class="btn btn-info" id="btnPerUpload" type="button"
						onclick="onUpload('preview')">上传(预览)</button>
					<button class="btn btn-info" id="btnCropUpload" type="button"
						onclick="onUpload('corpper')">上传(裁剪)</button>
				</div></li>
		</ul>
		<div class="breadcrumb content-header form-inline">
			<div class="form-group">
				<label for="title">标题</label> <input class="form-control input-sm"
					id="title" value="" style="width:100px;" type="text" /> <label
					for="category">类别</label> <input class="form-control input-sm"
					id="category" value="" style="width:100px;" type="text" /> <label
					for="applyTo">依附于</label> <input class="form-control input-sm"
					id="applyTo" style="width:80px;" value="" type="text" />
				<!-- 
					 <label for="sizeFrom">大小</label> <input
					class="form-control input-sm" id="sizeFrom" style="width:70px;" value="" type="text" />至
					<div class="input-group">
					<input
					class="form-control input-sm" id="sizeTo" style="width:70px;" value="" type="text" />
					<div class="input-group-addon">
						KB
					</div>
					</div>
					 -->
				<label for="sizeFrom">时间</label>
				<div class="input-group">
					<input class="form-control input-sm" id="startAt" name="startAt"
						style="width:90px;" type="text" />
					<div class="input-group-addon">
						<i class="fa fa-calendar"
							onclick="$('#startAt').datetimepicker('show');"></i>
					</div>
				</div>
				至
				<div class="input-group">
					<input class="form-control input-sm" id="endAt" name="endAt"
						style="width:90px;" type="text" />
					<div class="input-group-addon">
						<i class="fa fa-calendar"
							onclick="$('#endAt').datetimepicker('show');"></i>
					</div>
				</div>
				<label for="personName">上传人</label> <input
					class="form-control input-sm" id="personName" value=""
					style="width:70px;" type="text" />
			</div>
			<div class="form-group">
				<button class="btn btn-info" id="btnQuery" type="button"
					onclick="onQ()">查询</button>
			</div>
			<div class="form-group">
				<button class="btn btn-info" id="btnShowAll" type="button"
					onclick="showAll()">显示全部</button>
			</div>
			<ol class="breadcrumb">
				<li><a href="home/dashboard"><i class="fa fa-dashboard"></i>
						首页</a></li>
				<li class="active">附件列表</li>
			</ol>
		</div>
		<table id="grid" style="height:35px;"></table>
		<div id="pager" style="height:35px;"></div>
	</div>
</body>
</html>
