﻿<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<title>用户管理--列表</title>
	<jsp:include page="/WEB-INF/views/include/head4.jsp" />
	<link rel="stylesheet" type="text/css"
		  href="jslib/webuploader/webuploader.min.css">
	<script type="text/javascript"
			src="jslib/webuploader/webuploader.min.js"></script>
	<script>

        var _ORGID = 0;
        var _ORGNAME = "";
        var _ORGNUM = 0;
        //装载表格
        function loadGrid () {
            $ ("#grid").jqGrid ({
                title: '文档列表',
                height: document.body.clientHeight - 30,

                rownumbers: true,
                url: 'docfile/list',
                postData:{
                },
                colModel : [
                    {
                        label : '分类',
                        name : 'docTypeName',
                        index : 'docTypeName',
                        align : 'center',
                        width : 80
                    }, {
                        label : '名称',
                        name : 'title',
                        index : 'title',
                        align : 'center',
                        width : 240
                    }, {
                        label : '创建时间',
                        name : 'recordInfo.createdAt',
                        index : 'recordInfo.createdAt',
                        sortable : false,
                        align : 'center',
                        width : 130,
                        formatter : function (value, options, row) {
                            return jsonDateTimeFormatter (row.recordInfo.createdAt, 2);
                        }
                    }, {
                        label : '创建者',
                        name : 'recordInfo.createdByName',
                        index : 'recordInfo.createdByName',
                        sortable : false,
                        align : 'center',
                        width : 70,
                        formatter : function (value, options, row) {
                            return row.recordInfo.createdByName;
                        }
                    },  {
                        label : '操作',
                        name : 'id',
                        index : 'id',
                        width : 130,
                        align : 'center',
                        sortable : false,
                        formatter : function (value, options, row) {

                            var btn = "";
                            // if(row.isPi == 1){
                            //     btn += '&nbsp;<a href="javascript:onPi(' + value + ')" title="">录入批转信息</a>'
                            // }
                            btn += '&nbsp;<a href="javascript:onShow(\''+ row.fileUrl +'\',\''+row.fileExt+'\','+value+')" title="">下载</a>'
                            /*btn += '&nbsp;<a href="javascript:onView(' + value + ')" title="">查看</a>'
                            btn += '&nbsp;<a href="javascript:onSave(' + value + ')" title="">编辑信息</a>'*/
                            btn += '&nbsp;<a href="javascript:onDel(' + value + ')" title="">删除</a>'
                            //btn += '&nbsp;<a href="javascript:onKeySet(' + value + ')" title="">设置加密锁</a>'
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
                sortorder : "asc"
            });

        }


        //编辑
        function onSave (id) {

            id = id || 0;
            var title = "添加文档"
            if (id > 0){
                title = "编辑文档"
            }
            // parent.layer.open ({
            //     type : 2,
            //     title : title,
            //     shadeClose : true,
            //     shade : 0.8,
            //     area : [
            //         '90%', '80%'
            //     ],
            //     content : 'docfile/edit?id=' + id + '&docTypeId=' + _ORGID //iframe的url
            // });

            var url = 'docfile/edit?id=' + id + '&docTypeId=' + _ORGID

            win(url,title)
        }




        function win(url,title) {
            window.top.document.getElementById("ifrmDtl").src = url;
            window.top.$('#winDtl').dialog({
                width:'90%',
                height:'90%',
                closed: false,
                cache: false,
                modal:true,
                title:title
            });

            window.top.$('#winDtl').dialog("open");
        }

        function saveDoc(docTypeId,docTypeName,fileId) {
            $.post ('docfile/saveDoc', {"docTypeId":docTypeId,"docTypeName":docTypeName, "fileId":fileId}, function (result, status) {
                if (result.error){
                    //layer.msg (result.error);
                    //$ ("#name").focus ();
                    return;
                }

                $ ("#grid").jqGrid ("setGridParam", {
                }).trigger ("reloadGrid");
            });

        }
        //查看
        function onShow(url,fileExt,id) {

            url = _BasePath + "/" + url;
            if (".jpg;.gif;.bmp;.png".indexOf (fileExt) >= 0) {
                showPhoto(url)
            }
            // else if(".doc;.docx;".indexOf (fileExt) >= 0){
             //    $.post('document/viewdoc',{'id':id},function(result,status){
             //        var targeturl = result.url;
			// 		if(targeturl != ""){
             //            window.top.document.getElementById("ifrmDoc").src = "document/doc?url=" + targeturl;
             //            window.top.$('#winDoc').dialog({
             //                width:'90%',
             //                height:'90%',
             //                closed: false,
             //                cache: false,
             //                modal:true,
             //                title:"文档内容"
             //            });
            //
             //            window.top.$('#winDoc').dialog("open");
			// 		}
			// 	});
			// }
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

        function onView (id) {

            id = id || 0;
            var title = "查看文档"

            // parent.layer.open ({
            //     type : 2,
            //     title : title,
            //     shadeClose : true,
            //     shade : 0.8,
            //     area : [
            //         '90%', '90%'
            //     ],
            //     content : 'document/view?id=' + id + '&docTypeId=' + _ORGID //iframe的url
            // });
			var url = 'docfile/view?id=' + id + '&docTypeId=' + _ORGID
            win(url,title)
        }

        function onOrgSave(id){
            id = id || 0;
            var title = "新建分类"
            if (id > 0){
                title = "修改分类"
            }

			var url = 'docfiletype/edit?id=' + id
            window.top.document.getElementById("ifrmDtl").src = url;
            window.top.$('#winDtl').dialog({
                width:400,
                height:200,
                closed: false,
                cache: false,
                modal:true,
                title:title
            });

            window.top.$('#winDtl').dialog("open");
        }

        function onOrgNew(parentId,id){
			id = id || 0;
			parentId = parentId || 0;
			var title = id > 0 ? "编辑" : "新建分类";
            /*var title = "新建分类"
			if(id > 0)
			{
				title = "编辑"
			}*/
            layer.open ({
                type : 2,
                title : title,
                shadeClose : true,
                shade : 0.8,
                area : [
                    '600', '200'
                ],
                content : 'docfiletype/edit?parentId=' + parentId + '&id=' + id //iframe的url
            });

        }



        function onOrgDel (id,num) {
            id = id || 0;
            num = num || 0;
            if(id == 0)
            {
                layer.msg("请选择分类！")
                return false;
            }
            if(num > 0)
            {
                layer.msg("该分类中已有文档，禁止删除！")
                return false;
            }
            layer.confirm ('确定要删除该分类？', {
                btn : [
                    '确定', '取消'
                ]
                //按钮
            }, function () {
                $.post ("docfiletype/del", {
                    id : id
                }, function () {
                    document.getElementById('ifrmOrg').contentWindow.location.reload(true);
                    //document.getElementById('ifrmQdb').src=src;
                });
                layer.closeAll ();
            });
        }

        function onPersonSaveOk () {
            //document.getElementById('ifrmQdb').contentWindow.location.reload(true);
            $ ("#grid").jqGrid ("setGridParam", {
            }).trigger ("reloadGrid");
            window.top.onCancel()
        }
        //添加完成后执行方法
        function onSaveOk (entity) {
            //document.getElementById('ifrmQdb').contentWindow.location.reload(true);
            $ ("#grid").jqGrid ("setGridParam", {
            }).trigger ("reloadGrid");
            parent.layer.closeAll ();
        }
        //添加完成后执行方法
        function onOrgSaveOk (entity) {
            document.getElementById('ifrmOrg').contentWindow.location.reload(true);
            //$ ("#grid").trigger ("reload");
           layer.closeAll()
        }
        //删除
        function onDel (id) {
            layer.confirm ('确定要删除该文档？', {
                btn : [
                    '确定', '取消'
                ]
                //按钮
            }, function () {
                $.post ("docfile/del", {
                    id : id
                }, function () {
                    $ ("#grid").jqGrid ("setGridParam", {

                    }).trigger ("reloadGrid");
                });
                layer.closeAll ();
            });
        }
        //排序
        function onSort (id, order) {
            $.post ("docfile/sort", {
                id : id,
                order : order
            }, function () {
                $ ("#grid").jqGrid ("setGridParam", {
                }).trigger ("reloadGrid");
            });
        }
        //Iframe中点击ORG时获取ORGID，查询该机构下的人员
        function onOrgNodeClick (node) {
            _ORGID = node.id;
            _ORGNAME = node.name;
            _ORGNUM = node.docCount;
            onQ (node.id);
        }
        function showProgress() {
            layer.open({
                type : 1,
                title : false,
                closeBtn : 0,
                area : [ '100%', '50%' ],
                skin : 'layui-layer-nobg', //没有背景色
                shadeClose : true,
                content : $('#uploader')
            });
        }
        function onSelfUpload() {
            if(_ORGID <= 0){
                alert("请选择文档分类！");
                return;
			}
            $("input[name='file']").click();
        }
        //上传完附件后执行
        function onUploadFinished() {
            $ ("#grid").jqGrid ("setGridParam", {
            }).trigger ("reloadGrid");
        }
        //查询
        function onQ (docTypeId) {
            docTypeId = docTypeId || 0
            var para = {
                docTypeId : docTypeId,
                title : $ ("#name").val ()
            };
            $ ("#grid").jqGrid ("setGridParam", {
                page : 0,
                postData : para
            }).trigger ("reloadGrid");
        }
        //显示全部
        function showAll () {
            $ ("#name").val ("")
            onQ (0);
            $ ('#ifrmOrg').attr ('src', $ ('#ifrmOrg').attr ('src'));
        }

        //页面加载完成后执行
        $ (function () {
            var uploader = WebUploader.create({
                // swf文档路径
                swf : _BasePath + 'jslib/webuploader/Uploader.swf',
                // 文档接收服务端。
                server : 'comm/attachment/uploader',
                // 选择文档的按钮。可选。
                // 内部根据当前运行是创建，可能是input元素，也可能是flash.
                pick : '#picker',
                // 不压缩image, 默认如果是jpeg，文档上传前会压缩一把再上传！
                resize : false,
                formData : {
                    category : _ORGNAME,
                    applyTo : "${applyTo}",
                    refNum : _ORGID,
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
            // 当有文档被添加进队列的时候
            uploader.on('fileQueued', function(file) {
                //showProgress ();
                $("#thelist")
                    .append(
                        '<div id="' + file.id + '" class="item">'
                        + '<h4 class="info">' + file.name
                        + '</h4>'
                        + '<p class="state">等待上传...</p>'
                        + '</div>');
                uploader.upload();
            });
            // 文档上传过程中创建进度条实时显示。
            uploader
                .on(
                    'uploadProgress',
                    function(file, percentage) {
                        var $li = $('#' + file.id), $percent = $li
                            .find('.progress .progress-bar');
                        // 避免重复创建
                        if (!$percent.length) {
                            $percent = $(
                                '<div class="progress progress-striped active">'
                                + '<div class="progress-bar" role="progressbar" style="width: 0%">'
                                + '</div>' + '</div>')
                                .appendTo($li).find(
                                    '.progress-bar');
                        }
                        $li.find('p.state').text('上传中');
                        $percent.css('width', percentage * 100
                            + '%');
                    });
            uploader.on('uploadSuccess', function(file,response) {
                $('#' + file.id).remove();
                var obj = response.entity;
                saveDoc(_ORGID,_ORGNAME,obj.id);
                //$("#grid").trigger("reload");
            });
            uploader.on('uploadError', function(file) {
                $('#' + file.id).find('p.state').text('上传出错');
                $("#grid").datagrid("reload");
                layer.closeAll();
            });
            uploader.on('uploadComplete', function(file) {
                $('#' + file.id).find('.progress').fadeOut();
                $("#grid").datagrid("reload");
            });
            uploader.on('uploadFinished', function() {
                $("#grid").datagrid("reload");
            });
            $("#ctlBtn").on('click', function() {
                uploader.upload();
            });
            $ ("#ifrmOrg").height (document.body.clientHeight - 115)
            loadGrid ();
        });
	</script>
</head>

<body>
<div class="container-fluid">
	<div id="uploader" class="wu-example">
		<!--用来存放文档信息-->
		<div id="thelist" class="uploader-list"></div>
		<div class="btns" style="display:none;">
			<div id="picker">选择文档</div>
			<button id="ctlBtn" class="btn btn-default">开始上传</button>
		</div>
	</div>
		<div class="breadcrumb content-header form-inline"
			 style="padding:8px;">
			<div class="form-group">
				<label for="name">文档名称</label> <input
					class="form-control input-sm" id="name" value=""
					type="text" />
			</div>
			<div class="form-group">
				<button class="btn btn-info" id="btnAdd" type="button"
						onclick="onQ()">查询</button>
			</div>
			<div class="form-group">
				<button class="btn btn-info" id="btnShowAll" type="button"
						onclick="showAll()">显示全部</button>
				&nbsp;&nbsp;
				<button class="btn btn-info" id="btnAdd" type="button"
						onclick="onSelfUpload()">上传</button>


			</div>
		</div>

	<div class="row">
		<div class="col-sm-2 no-padding" style="">
			<div class="nav-tabs-custom">
				<!-- Tabs within a box -->
				<ul class="nav nav-tabs pull-right ui-sortable-handle">
					<li class="pull-left header"
						style="padding-left:20px;font-size:14px;">

						<i
							class="fa fa-bank"></i> <b> 类别 <b>
						<button class="btn btn-info" id="btnAdd" type="button"
								onclick="onOrgNew(_ORGID,0)">新建</button>
						<button class="btn btn-info" id="btnAdd" type="button"
								onclick="onOrgNew(0,_ORGID)">编辑</button>
						<button class="btn btn-danger" id="btnAdd" type="button"
								onclick="onOrgDel(_ORGID,_ORGNUM)()">删除</button>
					</li>
				</ul>
				<div class="tab-content no-padding">
					<iframe scrolling="auto" id="ifrmOrg"
							style="width: 100%; height: 300px;" frameborder="0"
							src="docfiletype/list4"></iframe>
				</div>
			</div>
		</div>
		<div class="col-sm-10">
			<table id="grid"></table>
			<div id="pager" style="height:35px;"></div>
		</div>
	</div>
</div>


</body>
</html>
<script type="text/javascript">


    $('.easyui-tabs1').tabs({
        tabHeight: 36,
        onSelect: function() {
            setTimeout(function() {
                resizeTabs();
            },100)
        }
    });
    $(window).resize(function(){
        $('.easyui-tabs1').tabs("resize");
        setTimeout(function() {
            resizeTabs();
        },100)
    }).resize();
    function resizeTabs() {
        var $body = $('body'),
            $window = $(window);

        if($window.height() > $body.height()) {

            $('.panel-body').height($window.height() - 44);

        }
    }
</script>
