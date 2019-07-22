﻿<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<title>用户管理--列表</title>
	<jsp:include page="/WEB-INF/views/include/head.jsp" />
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
            $ ("#grid").datagrid ({
                title: '文档列表',
                width: '100%',
                height: document.body.clientHeight - 30,
                nowrap: true,
                rownumbers: true,
                fitColumns: true,
				singleSelect:true,
                animate: true,
                collapsible: true,
                url: 'document/list',
                queryParams:{
                    isPi:1
                },
                idField: 'id',
                treeField: 'UserName',
                pagination: true,
                pageNumber:1,
                pageSize:20,
                fitColumns: true,
                striped: true,
                toolbar:'#tb',
                pageList: [20, 30, 40, 50, 100],
                columns : [[
                    {
                        title : '类别',
                        field : 'docTypeName',
                        align : 'center',
                        width : 80
                    }, {
                        title : '文件名称',
                        field : 'title',
                        align : 'center',
                        width : 240
                    }, {
                        title : '创建时间',
                        field : 'recordInfo.createdAt',
                        sortable : false,
                        align : 'center',
                        width : 130,
                        formatter : function (value, row, index) {
                            return jsonDateTimeFormatter (row.recordInfo.createdAt, 2);
                        }
                    }, {
                        title : '创建者',
                        field : 'recordInfo.createdByName',
                        sortable : false,
                        align : 'center',
                        width : 70,
                        formatter : function (value, row, index) {
                            return row.recordInfo.createdByName;
                        }
                    },{
                        title : '是否督办',
                        field : 'isDu',
                        sortable : false,
                        align : 'center',
                        width : 130,
                        formatter : function (value, row, index) {
                            return value == 1 ? '是' : '<span style="color:gray;">否</span>'
                        }
                    },  {
                        title : '操作',
                        field : 'id',
                        width : 130,
                        align : 'center',
                        sortable : false,
                        formatter : function (value, row, index) {

                            var btn = "";
                            if(row.isPi == 1){
                                btn += '&nbsp;<a href="javascript:onPi(' + value + ')" title="">录入批转信息</a>'
                            }
                            btn += '&nbsp;<a href="javascript:onShow(\''+ row.fileUrl +'\')" title="">查看</a>'

                            return btn;
                        }
                    }
                ]]
            });

        }

        function onPi(id){
            id = id || 0;
            var title = "录入批转信息"

            // parent.layer.open ({
            //     type : 2,
            //     title : title,
            //     shadeClose : true,
            //     shade : 0.8,
            //     area : [
            //         '90%', '80%'
            //     ],
            //     content : 'document/pizhuan?docId=' + id
            // });

            var url = 'document/pizhuan?docId=' + id
            win(url,title)

		}

		function onConfig(){
            var title = "公文流程设置"
            var url = 'workflow/workflow/index4'

            win(url,title)
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
            //     content : 'document/edit?id=' + id + '&docTypeId=' + _ORGID //iframe的url
            // });

            var url = 'document/edit?id=' + id + '&docTypeId=' + _ORGID

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
            $.post ('document/saveDoc', {"docTypeId":docTypeId,"docTypeName":docTypeName, "fileId":fileId}, function (result, status) {
                if (result.error){
                    //layer.msg (result.error);
                    //$ ("#name").focus ();
                    return;
                }

                $("#grid").datagrid("reload");
            });

        }
        //查看
        function onShow(url) {
            url = _BasePath + url;
            window.open(url, "att", "")
            //win(url,"查看文件")
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
			var url = 'document/view?id=' + id + '&docTypeId=' + _ORGID
            win(url,title)
        }

        function onOrgSave(id){
            id = id || 0;
            var title = "新建分类"
            if (id > 0){
                title = "修改分类"
            }
            // layer.open ({
            //     type : 2,
            //     title : title,
            //     shadeClose : true,
            //     shade : 0.8,
            //     area : [
            //         '500', '200'
            //     ],
            //     content : 'doctype/edit?id=' + id //iframe的url
            // });
			var url = 'doctype/edit?id=' + id
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

        function onOrgNew(id){
            id = id || 0;
            var title = "新建分类"
            layer.open ({
                type : 2,
                title : title,
                shadeClose : true,
                shade : 0.8,
                area : [
                    '600', '200'
                ],
                content : 'doctype/edit?parentId=' + id //iframe的url
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
                $.post ("doctype/del", {
                    id : id
                }, function () {
                    document.getElementById('ifrmQdb').contentWindow.location.reload(true);
                    //document.getElementById('ifrmQdb').src=src;
                });
                layer.closeAll ();
            });
        }

        function onPersonSaveOk () {
            //document.getElementById('ifrmQdb').contentWindow.location.reload(true);
            $ ("#grid").datagrid ("reload");
            window.top.onCancel()
        }
        //添加完成后执行方法
        function onSaveOk (entity) {
            //document.getElementById('ifrmQdb').contentWindow.location.reload(true);
            $ ("#grid").datagrid ("reload");
            parent.layer.closeAll ();
        }
        //添加完成后执行方法
        function onOrgSaveOk (entity) {
            document.getElementById('ifrmQdb').contentWindow.location.reload(true);
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
                $.post ("document/del", {
                    id : id
                }, function () {
                    $ ("#grid").datagrid ("reload");
                });
                layer.closeAll ();
            });
        }
        //排序
        function onSort (id, order) {
            $.post ("document/sort", {
                id : id,
                order : order
            }, function () {
                $ ("#grid").datagrid ("reload");
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
            $("#grid").datagrid("reload");
        }
        //查询
        function onQ (docTypeId) {
            docTypeId = docTypeId || 0
            var para = {
                docTypeId : docTypeId,
                title : $ ("#name").val ()
            };
            $ ("#grid").datagrid ("reload", para);
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
            // 当有文件被添加进队列的时候
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
            // 文件上传过程中创建进度条实时显示。
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
<div class="container2">
	<div id="uploader" class="wu-example">
		<!--用来存放文件信息-->
		<div id="thelist" class="uploader-list"></div>
		<div class="btns" style="display:none;">
			<div id="picker">选择文件</div>
			<button id="ctlBtn" class="btn btn-default">开始上传</button>
		</div>
	</div>

	<div class="content">

		<table id="grid">

		</table>
		<div id="tb" style="padding:0 30px;">
			<div class="conditions">
				<span class="con-span">文件名称: </span><input class="easyui-textbox" type="text" id="name" name="name" style="width:166px;height:35px;line-height:35px;"></input>
				<a href="javascript:;" onclick="onQ()"  class="easyui-linkbutton" iconCls="icon-search" data-options="selected:true">查询</a>
				<a href="javascript:;" onclick="showAll()" class="easyui-linkbutton" iconCls="icon-reload">重置</a>
				<%--<a href="#" class="easyui-linkbutton more" iconCls="icon-more">更多</a>--%>
			</div>

			<div class="opt-buttons">
				<a href="javascript:;" onclick="onConfig()" class="easyui-linkbutton" data-options="selected:true">公文流程设置</a>

			</div>
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
