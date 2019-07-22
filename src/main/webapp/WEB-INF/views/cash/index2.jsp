﻿<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<title>用户管理--列表</title>
	<jsp:include page="/WEB-INF/views/include/head2.jsp" />
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
                title: '报销申请列表',
                width: '100%',
                height: document.body.clientHeight - 30,
                nowrap: true,
                rownumbers: true,
                fitColumns: true,
				singleSelect:true,
                animate: true,
                collapsible: true,
                url: 'cash/list',
                queryParams:{
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
                        title : '申请人',
                        field : 'sqr',
                        align : 'center',
                        width : 80
                    }, {
                        title : '申请日期',
                        field : 'recordInfo.createdAt',
                        sortable : false,
                        align : 'center',
                        width : 130,
                        formatter : function (value, row, index) {
                            return jsonDateTimeFormatter (row.recordInfo.createdAt, 2);
                        }
                    }, {
                        title : '部门',
                        field : 'org',
                        align : 'center',
                        width : 240
                    }, {
                        title : '类型',
                        field : 'type',
                        align : 'center',
                        width : 240
                    }, {
                        title : '支付方式',
                        field : 'payment',
                        align : 'center',
                        width : 240
                    }, {
                        title : '报销总金额',
                        field : 'total',
                        align : 'center',
                        width : 240
                    }, {
                        title : '单据总数',
                        field : 'paper',
                        align : 'center',
                        width : 240
                    },{
                        title : '状态',
                        field : 'status',
                        sortable : false,
                        align : 'center',
                        width : 130,
                        formatter : function (value, row, index) {
                            return value == 1 ? '已审批' : '<span style="color:gray;">待审批</span>'
                        }
                    },  {
                        title : '操作',
                        field : 'id',
                        width : 130,
                        align : 'center',
                        sortable : false,
                        formatter : function (value, row, index) {

                            var btn = "";
                            if(row.status == 0){
                                btn += '&nbsp;<a href="javascript:onSave(' + value + ')" title="">编辑</a>'
                                btn += '&nbsp;<a href="javascript:onDel(' + value + ')" title="">删除</a>'
                            }
                            return btn;
                        }
                    }
                ]]
            });

        }



        //编辑
        function onSave (id) {

            id = id || 0;
            var title = "新建报销单"
            if (id > 0){
                title = "编辑报销单"
            }


            var url = 'cash/edit?id=' + id
			window.top.OBJ = this
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


        //删除
        function onDel (id) {
            layer.confirm ('确定删除？', {
                btn : [
                    '确定', '取消'
                ]
                //按钮
            }, function () {
                $.post ("cash/del", {
                    id : id
                }, function () {
                    $ ("#grid").datagrid ("reload");
                });
                layer.closeAll ();
            });
        }
        //排序
        function onSort (id, order) {
            $.post ("cash/sort", {
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


            loadGrid ();
        });
	</script>
</head>

<body>
<div class="container">

	<div class="content2">

		<table id="grid">

		</table>
		<div id="tb" style="padding:0 30px;">
			<div class="conditions">
				<span class="con-span">申请人: </span><input class="easyui-textbox" type="text" id="name" name="name" style="width:166px;height:35px;line-height:35px;"></input>
				<a href="javascript:;" onclick="onQ()"  class="easyui-linkbutton" iconCls="icon-search" data-options="selected:true">查询</a>
				<a href="javascript:;" onclick="showAll()" class="easyui-linkbutton" iconCls="icon-reload">重置</a>
				<%--<a href="#" class="easyui-linkbutton more" iconCls="icon-more">更多</a>--%>
			</div>
			<div class="opt-buttons">
				<a href="javascript:;" onclick="onSave()" class="easyui-linkbutton" data-options="selected:true">新建</a>

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
