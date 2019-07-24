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
                url: 'document/list_ins_old',
                postData:{
                    createdby:"${baseUser.id}",
                    isActive:5,
                    isGui:0,
                    stepId:1
                },
                colModel : [
                    {
                        label : '文件名称',
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
                    }, {
                        label : '当前环节',
                        name : 'stepName',
                        index : 'stepName',
                        align : 'center',
                        width : 80
                    }, {
                        label : '执行人',
                        name : 'actorName',
                        index : 'actorName',
                        sortable : false,
                        align : 'center',
                        width : 130,
                        formatter : function (value, options, row) {
                            //return value == 1 ? '是' : '<span style="color:gray;">否</span>'
                            return value
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
                            btn += '&nbsp;<a href="javascript:onPi(' + row.refNum + ',' +row.id+ ')" title="">查看</a>'

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
                sortorder : "asc"
            });

        }

        function onPi(id,insId){
            id = id || 0;
            insId = insId || 0;
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

            var url = 'document/dview?id=' + id + '&insId=' + insId
            //win(url,title)
            document.location.href = url

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

                onQ()
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
            onQ()
            window.top.onCancel()
        }
        //添加完成后执行方法
        function onSaveOk (entity) {
            //document.getElementById('ifrmQdb').contentWindow.location.reload(true);
            onQ()
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
                    onQ()
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
                onQ()
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
            onQ()
        }
        //查询
        function onQ () {
            var para = {
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
        }

        //页面加载完成后执行
        $ (function () {
            loadGrid ();
        });
	</script>
</head>

<body>
<div class="container-fluid">
	<div id="uploader" class="wu-example">
		<!--用来存放文件信息-->
		<div id="thelist" class="uploader-list"></div>
		<div class="btns" style="display:none;">
			<div id="picker">选择文件</div>
			<button id="ctlBtn" class="btn btn-default">开始上传</button>
		</div>
	</div>
	<div class="breadcrumb content-header form-inline"
		 style="padding:8px;">
		<div class="form-group">
			<label for="name">文件名称</label> <input
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


		</div>
	</div>

	<div class="row">

		<div class="col-sm-12">
			<table id="grid"></table>
			<div id="pager" style="height:35px;"></div>
		</div>
	</div>
</div>

</body>
</html>
<script type="text/javascript">

    function resizeTabs() {
        var $body = $('body'),
            $window = $(window);

        if($window.height() > $body.height()) {

            $('.panel-body').height($window.height() - 44);

        }
    }
</script>
