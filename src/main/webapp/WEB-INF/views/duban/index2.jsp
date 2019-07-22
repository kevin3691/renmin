<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<title>${category }--列表</title>
	<jsp:include page="/WEB-INF/views/include/head4.jsp" />
	<script>
        //装载表格
        function loadGrid () {
            $ ("#grid").jqGrid ({
                url : "duban/list",
                postData : {
                    colSym : "MASTER"
                },
                height : document.body.clientHeight - 130,
                rownumbers : true,
                colModel : [
                    {
                        label : '类别',
                        name : 'category',
                        index : 'category',
                        width : 80
                    },{
                        label : '标题',
                        name : 'title',
                        index : 'title',
                        width : 240
                    },{
                        label : '分管领导',
                        name : 'fenguanlingdao',
                        index : 'fenguanlingdao',
                        width : 240
                    },{
                        label : '督办人',
                        name : 'dubanren',
                        index : 'dubanren',
                        width : 240
                    },{
                        label : '承办部门',
                        name : 'chengbanchushi',
                        index : 'chengbanchushi',
                        width : 240
                    },{
                        label : '开始时间',
                        name : 'starttime',
                        index : 'starttime',
                        width : 180,
                        formatter : function (value, options, row) {
                            return jsonDateTimeFormatter (value, 2);
                        }
                    },{
                        label : '完成时间',
                        name : 'finishtime',
                        index : 'finishtime',
                        width : 180,
                        formatter : function (value, options, row) {
                            return jsonDateTimeFormatter (value, 2);
                        }
                    },{
                        label : ' ',
                        name : 'id',
                        width : 120,
                        align : 'center',
                        sortable : false,
                        formatter : function (value, options, row) {
                            var btn = "";
                            if(row.status == 0)
                                btn += '&nbsp;<a href="javascript:onSave('+  row.id +')" title="">编辑</a>&nbsp;&nbsp;'
                            if(row.status == 1)
                                btn += '&nbsp;<a href="javascript:onDu('+  row.id +')" title="">督办</a>'
                            if(row.status == 2)
                                btn += '&nbsp;<a href="javascript:onView('+  row.id +')" title="">查看</a>'

                            return btn;
                        }
                    },{
                        name : 'refNum',
                        hidden : true
                    }
                ],
                rowNum : 20,
                rowList : [
                    20, 50, 100
                ],
                pager : '#pager',
                sortname : 'id',
                sortorder : "desc"
            });
            jQuery ("#grid").jqGrid ('bindKeys', {
                "onEnter" : function (rowid) {
                    //alert ("你enter了一行， id为:" + rowid)
                },
                "onRightKey" : function (rowid) {
                    onSave (rowid)
                },
                "onLeftKey" : function (rowid) {
                    onDel (rowid)
                },
                "onSpace" : function (rowid) {
                }
            });
        }
        //保存
        function onSave (id) {
            id = id || 0;
            var title = "添加督办事项"
            if (id > 0){
                title = "编辑督办事项"
            }
            layer.open ({
                type : 2,
                title : title,
                shadeClose : true,
                shade : 0.8,
                area : [
                    '90%', '90%'
                ],
                content : 'duban/edit?id=' + id + '&colSym=ZHUANXIANG?colTitle=' + encodeURI("专项督办") //iframe的url
            });
        }

        function onDu(id){
            id = id || 0;
            document.location.href = 'duban/duban3?id=' + id
        }

        function onView(id){
            id = id || 0;
            document.location.href = 'duban/view3?id=' + id
        }

        function onDtl (refNum) {
            refNum = refNum || 0;
            var title = "查看公文"
            document.location = 'document/dtl?id=' + refNum
        }
        //添加完成后执行方法
        function onSaveOk (entity) {
            $ ("#grid").trigger ("reloadGrid");
            layer.closeAll ();
        }
        //删除
        function onDel (refNum) {
            layer.confirm ('确定要删除文档？', {
                btn : [
                    '确定', '取消'
                ]
                //按钮
            }, function () {
                $.post ("document/delIns", {
                    refNum : refNum
                }, function () {
                    $ ("#grid").trigger ("reloadGrid");
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
                $ ("#grid").trigger ("reloadGrid");
            });
        }
        //Iframe中点击ORG时获取ORGID，查询该机构下的人员
        function onOrgNodeClick (node) {
            onQ (node.id);
        }
        //查询
        function onQ () {
            var para = {
                title : $ ("#title").val ()
            };
            $ ("#grid").jqGrid ("setGridParam", {
                page : 0,
                postData : para
            }).trigger ("reloadGrid");
        }
        //显示全部
        function showAll () {
            $ ("#title").val ("");
            onQ (0);
            $ ('#ifrmOrg').attr ('src', $ ('#ifrmOrg').attr ('src'));
        }
        //页面加载完成后执行
        $ (function () {
            $ ("#ifrmOrg").height (document.body.clientHeight - 115)
            loadGrid ();
        });
	</script>
</head>

<body>
<div class="container-fluid">
	<div class="breadcrumb content-header form-inline"
		 style="padding:8px;">
		<div class="form-group">
			<label for="name">标题</label> <input class="form-control input-sm"
												id="name" value="" type="text" />
		</div>

		<div class="form-group">
			<button class="btn btn-info" id="btnAdd" type="button"
					onclick="onQ()">查询</button>
		</div>
		<div class="form-group">
			<button class="btn btn-info" id="btnShowAll" type="button"
					onclick="showAll()">显示全部</button>
		</div>

		<div class="form-group">
			<%--<button class="btn btn-success" id="btnSave" type="button"--%>
					<%--onclick="onSave()">新建</button>--%>
		</div>
		<ol class="pull-right breadcrumb">
			<li><a href="home/dashboard"><i class="fa fa-dashboard"></i>
				首页</a></li>
			<li class="active">主要工作任务分解督办</li>
		</ol>
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
