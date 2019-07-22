<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<jsp:include page="/WEB-INF/views/include/head4.jsp" />
	<link rel="stylesheet" type="text/css"
		  href="jslib/webuploader/webuploader.min.css">
	<script type="text/javascript"
			src="jslib/webuploader/webuploader.min.js"></script>
	<script type="text/javascript" src="jslib/webuploader/uploader.min.js"></script>
	<script type="text/javascript" charset="utf-8" src="u000e/config.min.js"></script>
	<script type="text/javascript" charset="utf-8" src="u000e/all.min.js"></script>
<title>文件批转</title>
<script type="text/javascript">

    function loadGrid () {
        $ ("#grid").jqGrid (
            {
                url : "comm/attachment/list4",
				postData:{
					refNum:"${ins.id}"
				},
                height : 310,
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
                            btn += '&nbsp;<a href="javascript:onDel(' + value + ')" title="">删除</a>'
                            return btn;
                        }
                    }
                ],
                rowNum : 5,
                rowList : [
                    5, 10, 15,20,50
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
    function onCancel(){
    	parent.layer.closeAll();
    }

    function onSave(){

        var ue = UE.getEditor ('editor');
        var content = $ ("#content").val (ue.getContent ());
    	$.post('duban/saveDuInfo', {"insId":"${ins.id}","docId":"${doc.id}","content":content}, function(result,
				status) {
			if(parent.addInfoOk)
                parent.addInfoOk();
		});
    	/* $.ajax({
			headers : {
				'Accept' : 'application/json',
				'Content-Type' : 'application/json'
			},
			type : "POST",
			url : "document/savePi?docId=${doc.id}",
			data : JSON.stringify(pishiList),
			success : function(result) {
				//document.location = 'document/index'
				document.location.reload();
			},
			error : function(result) {	
				alert("保存失败！");
			}
		}); */
    	
    }

    function onFaile() {
        parent.layer.confirm ('确定设置当前环节超时？', {
            btn : [
                '确定', '取消'
            ]
            //按钮
        }, function () {
            $.post('duban/faile', {"docId":"${doc.id}","insId":"${ins.id}"}, function(result,
                                                                                       status) {
                if(parent.addInfoOk)
                    parent.addInfoOk();
            });
        });
    }
    function onFinish(){

        parent.layer.confirm ('确定办结当前环节？', {
            btn : [
                '确定', '取消'
            ]
            //按钮
        }, function () {
            $.post('duban/finish', {"docId":"${doc.id}","insId":"${ins.id}"}, function(result,
                                                                                       status) {
                if(parent.addInfoOk)
                    parent.addInfoOk();
            });
        });

    }
    
    $ (function () {

        UPLOADER.formData = {
            applyTo : "duinfo",
			refNum:"${ins.id}"
        }
        UPLOADER.accept = {
            title : 'Images',
            extensions : 'gif,jpg,jpeg,bmp,png',
            mimeTypes : 'image/*'
        }
        UPLOADER.init ();

        $ ("#startTime").inputmask ("yyyy-mm-dd", {
            "placeholder" : "yyyy-mm-dd"
        });
        //加载日期控件
        $ ('#startTime').datetimepicker ({
            minView : 3
            //时间，默认为日期时间
        });
        //设置掩码
        $ ('#startTime').inputmask ("yyyy-mm-dd");

        $ ("#finishTime").inputmask ("yyyy-mm-dd", {
            "placeholder" : "yyyy-mm-dd"
        });
        //加载日期控件
        $ ('#finishTime').datetimepicker ({
            minView : 3
            //时间，默认为日期时间
        });
        //设置掩码
        $ ('#finishTime').inputmask ("yyyy-mm-dd");
        loadGrid ();
        UE.getEditor ('editor');
    })
</script>
</head>

<body>
	<div class="content-fluid" style="margin-left:0px">
		<ul class="nav nav-tabs" style="padding-top:10px;">
			<li style="float:right;">
				<div>
					<button type="button" class="btn btn-info" onclick="onFaile()">超时未办结</button>
					&nbsp;&nbsp;
					<button type="button" class="btn btn-info" onclick="onFinish()">办结</button>
					&nbsp;&nbsp;
					<button type="button" class="btn btn-info" onclick="onSave()">保存</button>
					&nbsp;&nbsp;
					<button type="button" class="btn btn-danger" onclick="onCancel()">返回</button>
					&nbsp;&nbsp;
				</div>
			</li>
		</ul>
		
		<div>&nbsp;</div>


		 <form id="mainForm" class="form-horizontal">
			 <div class="form-group">
				 <label class="col-sm-2 control-label" for="blbm">办理部门</label>
				 <div class="col-sm-4">
					 <input class="form-control" id="blbm" name="blbm"
							value="${ins.actorName}" type="text" readOnly/>
				 </div>
				 <label class="col-sm-2 control-label" for="blbm" style="display: none">办理人</label>
				 <div class="col-sm-4" style="display: none">
					 <div class="input-group">
						 <input class="form-control" id="jbr" name="jbr"
								value="${ins.listUrl}" type="text" readOnly/>
						 <div class="input-group-addon">

						 </div>
					 </div>
				 </div>
			 </div>
			 <div class="form-group">
				 <label class="col-sm-2 control-label" for="startTime">开始时间</label>
				 <div class="col-sm-4">
					 <div class="input-group">
						 <input class="form-control" id="startTime" name="startTime" value="${ins.startTime}" readonly
								type="text" />
						 <div class="input-group-addon">

						 </div>
					 </div>
				 </div>
			 </div>

			 <div class="form-group">
				 <label class="col-sm-2 control-label" for="finishTime">办结时限</label>
				 <div class="col-sm-4">
					 <div class="input-group">
						 <input class="form-control" id="finishTime" name="finishTime" value="${ins.finishTime}" readonly
								type="text" />
						 <div class="input-group-addon">

						 </div>
					 </div>
				 </div>
			 </div>
			 <div class="form-group">
				 <label class="col-sm-2 control-label" for="content">反馈信息</label>
				 <div class="col-sm-10">
					 <script id="editor" type="text/plain" style="width:100%;height: 240px;">${ins.descr}</script>
					 <%--<textarea class="form-control" id="content" name="content" rows=8>${ins.descr}</textarea>--%>
				 </div>
			 </div>

			 <div class="form-group">
				 <label class="col-sm-2 control-label" for="content">附件 </label>
				 <div class="col-sm-10">
					 <button class="btn btn-info" id="btnUpload" type="button"
							 onclick="onSelfUpload()">上传</button>
					 <table id="grid" style="height:35px;"></table>
					 <div id="pager" style="height:35px;"></div>
				 </div>
			 </div>

		</form>
		
	</div>
</body>
</html>
