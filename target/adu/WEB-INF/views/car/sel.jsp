<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<title>人员管理--选择</title>
	<jsp:include page="/WEB-INF/views/include/head4.jsp" />
	<script>
        $(function() {
            loadGrid();
        });
        function loadGrid() {
            $("#grid").jqGrid({
                url : "car/list4sel",
                postData : {

                },
                height : document.body.clientHeight - 130,
                rownumbers : true,
                colModel : [
                    {
                        label : '车牌号',
                        name : 'cardNo',
                        index : 'cardNo',
                        sortable : false,
                        width : 120
                    },  {
                        label : '状态',
                        name : 'status',
                        index : 'status',
                        sortable : false,
                        width : 80
                    },  {
                        label : '类型',
                        name : 'type',
                        index : 'type',
                        sortable : false,
                        width : 120
                    },
                    {
                        label : '品牌',
                        name : 'pinpai',
                        index : 'pinpai',
                        sortable : false,
                        width : 120
                    },
                    {
                        label : '型号',
                        name : 'xinghao',
                        index : 'xinghao',
                        sortable : false,
                        width : 120
                    },
                    {
                        label : '购买日期',
                        name : 'goumairiqi',
                        index : 'goumairiqi',
                        sortable : false,
                        width : 120,
                        formatter : function (value, options, row) {
                            return jsonDateTimeFormatter (row.goumairiqi, 2);
                        }
                    },

                    {
                     	name:'id',
						hidden:true
                     }
                ],
                rowNum : 20,
                rowList : [
                    20, 50, 100
                ],
                rowNum : 20,
                rowList : [ 20, 50, 100 ],
                pager : '#pager',
                sortname : 'lineNo',
                sortorder : "asc",
                onSelectRow : function(rowid, status) {
                    var row = $("#grid").jqGrid("getRowData", rowid);
                    if (parent.onCarSelOk) {
                        parent.onCarSelOk(row);
                    }
                    var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
                    parent.layer.close(index); //再执行关闭
                }
            });
        }
        //Iframe中点击ORG时获取ORGID，查询该机构下的人员
        function onOrgNodeClick(node) {
            onQ(node.id);
        }
        //查询
        function onQ () {
            var para = {
                cardNo : $ ("#cardNo").val (),
                status : $ ("#status").val (),
                type : $ ("#type").val ()
            };
            $ ("#grid").jqGrid ("setGridParam", {
                page : 0,
                postData : para
            }).trigger ("reloadGrid");
        }
        //显示全部
        function showAll () {
            $ ("#cardNo").val ("");
            $ ("#status").val ("")
            $ ("#type").val ("")
            onQ ();

        }
	</script>
</head>

<body>
<div class="container-fluid">
	<div class="breadcrumb content-header form-inline"
		 style="padding:8px;">
		<div class="form-group">
			<label for="cardNo">车牌号</label> <input class="form-control input-sm"
												   id="cardNo" value="" type="text" />
		</div>
		<div class="form-group">
			<label for="status">状态</label> <input class="form-control input-sm"
												  id="status" value="" type="text" />
			<div class="form-group">
				<label for="type">类型</label> <input class="form-control input-sm"
													id="type" value="" type="text" />
			</div>
			<div class="form-group">
				<button class="btn btn-info" type="button"
						onclick="onQ()">查询</button>
			</div>
			<div class="form-group">
				<button class="btn btn-info" id="btnShowAll" type="button"
						onclick="showAll()">显示全部</button>

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
