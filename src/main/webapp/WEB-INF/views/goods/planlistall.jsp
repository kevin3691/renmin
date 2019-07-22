<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>办公用品--列表</title>
<jsp:include page="/WEB-INF/views/include/head4.jsp" />
<script>

    var _ORGID = 0;
    var _ORGNAME = "";
    var _ORGNUM = 0;

	//装载表格
    function loadGrid () {
	    $ ("#grid").jqGrid ({
	        url : "goods/listGoodPlanList",
			postData:{
				orgId:"${baseUser.baseOrgId}"
			},
	        height : document.body.clientHeight - 130,
	        rownumbers : true,
	        colModel : [
                {
                    label : '名称',
                    name : 'title',
                    index : 'title',
                    width : 120
                }, {
                    label : '创建日期',
                    name : 'startdt',
                    width : 120,
                    sortable : false,
                    align : 'center',
                    formatter: function (value, options, row) {
                        return jsonDateTimeFormatter(value,1)
                    }
                }
                , {
                    label : '完成日期',
                    name : 'finishdt',
                    width : 120,
                    sortable : false,
                    align : 'center',
                    formatter: function (value, options, row) {
                        return jsonDateTimeFormatter(value,1)
                    }
                }, {
                    label : '状态',
                    name : 'isActive',
                    width : 120,
                    sortable : false,
                    align : 'center',
                    formatter: function (value, options, row) {
                        var btn = ""
                        if(value == 0){
                            btn += "未执行"
                        }
                        if(value == 1){
                            btn += "<span style='color: blue'>执行中</span>"
                        }

                        if(value == 2){
                            btn += "<span style='color: green'>已完成</span>"
                        }
                        return btn
                    }
                },{
	                    label : ' ',
	                    name : 'id',
	                    width : 120,
	                    align : 'center',
	                    sortable : false,
	                    formatter : function (value, options, row) {
		                    var btn = "";
							if(row.isActive == 0){
                                btn += '&nbsp;<a href="javascript:onSave('  + value + ')" title="">编辑</a>&nbsp;&nbsp;'
                                btn += '&nbsp;<a href="javascript:onDel(' + value + ')" title="">删除</a>&nbsp;'
							}
                            if(row.isActive == 1){
                                btn += '&nbsp;<a href="javascript:onView2('  + value + ')" title="">查看</a>&nbsp;&nbsp;'
                            }
                            if(row.isActive == 2){
                                btn += '&nbsp;<a href="javascript:onView('  + value + ')" title="">查看</a>&nbsp;&nbsp;'
                            }


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
        var title = "新建采购计划"
        if (id > 0){
            title = "编辑采购计划"
        }
        layer.open ({
            type : 2,
            title : title,
            shadeClose : true,
            shade : 0.8,
            area : [
                '90%', '90%'
            ],
            content : 'goods/editPlanList?id=' + id //iframe的url
        });
    }


    function onView (id) {

        id = id || 0;
        var title = "查看采购计划"

        layer.open ({
            type : 2,
            title : title,
            shadeClose : true,
            shade : 0.8,
            area : [
                '90%', '90%'
            ],
            content : 'goods/viewPlanList?id=' + id //iframe的url
        });
    }

    function onView2 (id) {

        id = id || 0;
        var title = "查看采购计划"

        layer.open ({
            type : 2,
            title : title,
            shadeClose : true,
            shade : 0.8,
            area : [
                '90%', '90%'
            ],
            content : 'goods/viewPlanList2?id=' + id //iframe的url
        });
    }
    //添加完成后执行方法
    function onSaveOk (entity) {
	    $ ("#grid").trigger ("reloadGrid");
	    layer.closeAll ();
    }


    //删除
    function onDel (id) {
	    layer.confirm ('确定要删除采购计划？', {
		    btn : [
		            '确定', '取消'
		    ]
	    //按钮
	    }, function () {
		    $.post ("goods/delPlanList", {
			    id : id
		    }, function () {
			    $ ("#grid").trigger ("reloadGrid");
		    });
		    layer.closeAll ();
	    });
    }


    //查询
    function onQ () {
	    var para = {

	    };
	    $ ("#grid").jqGrid ("setGridParam", {
	        page : 0,
	        postData : para
	    }).trigger ("reloadGrid");
    }
    //显示全部
    function showAll () {

	    onQ ();
    }
    //页面加载完成后执行
    $ (function () {
	    loadGrid ();
    });
</script>
</head>

<body>
	<div class="container-fluid">
		<div class="breadcrumb content-header form-inline"
			style="padding:8px;">
			<%--<div class="form-group">--%>
				<%--<label for="name">名称</label> <input class="form-control input-sm"--%>
					<%--id="name" value="" type="text" />--%>
			<%--</div>--%>
			<%--<div class="form-group">--%>
				<%--<label for="sn">编号</label> <input class="form-control input-sm"--%>
					<%--id="sn" value="" type="text" />--%>
			<%--</div>--%>
			<%--<div class="form-group">--%>
				<%--<button class="btn btn-info"  type="button"--%>
					<%--onclick="onQ()">查询</button>--%>
			<%--</div>--%>
			<div class="form-group">
				<%--<button class="btn btn-info" type="button"--%>
					<%--onclick="showAll()">显示全部</button>--%>
				<%--&nbsp;&nbsp;--%>
				<button class="btn btn-info"  type="button"
					onclick="onSave()">添加</button>
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
