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
<title>文件批转</title>
<script type="text/javascript">

  
    function onCancel(){
    	parent.layer.closeAll();
    }

    function onSave(){

        $.post('duban/saveDuOrg', {"docId":"${o.id}","parentId":"${ins.id}","personId":$("#jbrId").val(),"startTime":$("#startTime").val(),"finishTime":$("#finishTime").val(),"title":$("#title").val()}, function(result,
                                                                                                                                                                                                                       status) {
            if(parent.addInfoOk)
                parent.addInfoOk();
        });

    	
    }
    function onSelPerson (id) {
        index = layer.open ({
            type : 2,
            title : "选择办理人",
            shadeClose : true,
            shade : 0.8,
            area : [
                '90%', '90%'
            ],
            content : 'base/person/sel' //iframe的url
        });
        layer.full(index);
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

    //选择部门回调方法
    function onPersonSelOk (node) {
        $("#blbm").val(node.baseOrgName);
        $("#jbr").val(node.name);
        $("#jbrId").val(node.id);
        layer.close(index);
    }

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

    function onSelfUpload () {
        $ ("input[name='file']").click ();
    }
    //上传完附件后执行
    function onUploadFinished () {
        onQ ();
    }
    function onQ () {
        var para = {

        };
        $ ("#grid").jqGrid ("setGridParam", {
            postData : para
        }).trigger ("reloadGrid");
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
    })
</script>
</head>

<body>
	<div class="content-wrapper" style="margin-left:0px">
		<ul class="nav nav-tabs" style="padding-top:10px;">
			<li style="float:right;">
				<div>
					<button type="button" class="btn btn-info" onclick="onSave()">保存</button>
					&nbsp;&nbsp;
					<button type="button" class="btn btn-danger" onclick="onCancel()">返回</button>
					&nbsp;&nbsp;
				</div>
			</li>
		</ul>
		
		<div>&nbsp;</div>
		<div class="form-group">
			<label class="col-sm-2 control-label" for="blbm">办理部门</label>
			<div class="col-sm-4">
				<input class="form-control" id="blbm" name="blbm"
					   value="" type="text" readOnly/>
			</div>
			<label class="col-sm-2 control-label" for="blbm">办理人</label>
			<div class="col-sm-4">
				<div class="input-group">
					<input class="form-control" id="jbr" name="jbr"
						   value="" type="text" readOnly/>
					<input type="hidden" id="jbrId" name="jbrId" value=0 />
					<div class="input-group-addon">
						<i class="fa fa-search"
						   onclick="onSelPerson()"></i>
					</div>
				</div>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label" for="startTime">开始时间</label>
			<div class="col-sm-4">
				<div class="input-group">
					<input class="form-control" id="startTime" name="startTime" value=""
						   type="text" />
					<div class="input-group-addon">
						<i class="fa fa-calendar"
						   onclick="$('#startTime').datetimepicker('show');"></i>
					</div>
				</div>
			</div>
			<label class="col-sm-2 control-label" for="finishTime">办结时限</label>
			<div class="col-sm-4">
				<div class="input-group">
					<input class="form-control" id="finishTime" name="finishTime" value=""
						   type="text" />
					<div class="input-group-addon">
						<i class="fa fa-calendar"
						   onclick="$('#finishTime').datetimepicker('show');"></i>
					</div>
				</div>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label" for="title">督办要求</label>
			<div class="col-sm-10">
				<textarea class="form-control" id="title" name="title" rows=3></textarea>
			</div>
		</div>

		
	</div>
</body>
</html>
