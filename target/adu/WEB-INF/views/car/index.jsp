<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>组织机构--列表</title>
<jsp:include page="/WEB-INF/views/include/head4.jsp" />
<script>
	//tree
    //生成表格
    function loadGrid () {

        $ ("#grid").jqGrid ({
            url : "car/list",
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
                    label : ' ',
                    name : 'id',
                    width : 260,
                    align : 'center',
                    sortable : false,
                    formatter : function (value, options, row) {
                        var btn = "";
                        btn += '&nbsp;<a href="javascript:onUse(' + value + ')" title="">申请使用车辆</a>'
                        btn += '&nbsp;<a href="javascript:onAddCash(' + value + ')" title="">登记运行费用</a>'
                        btn += '&nbsp;<a href="javascript:onAddInfo(' + value + ')" title="">登记维保信息</a>'
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

    function onAddCash (id) {
        var title = "登记运行费用"

        layer.open ({
            type : 2,
            title : title,
            shadeClose : true,
            shade : 0.8,
            area : [
                '1000', '600'
            ],
            content : 'car/addCash?carId=' + id //iframe的url
        });
    }

    function onAddInfo (id) {
        var title = "登记维保信息"

        layer.open ({
            type : 2,
            title : title,
            shadeClose : true,
            shade : 0.8,
            area : [
                '800', '530'
            ],
            content : 'car/addInfo?carId=' + id //iframe的url
        });
    }

    function onUse (id) {
        var title = "登记车辆使用"

        layer.open ({
            type : 2,
            title : title,
            shadeClose : true,
            shade : 0.8,
            area : [
                '90%', '90%'
            ],
            content : 'car/use?carId=' + id //iframe的url
        });
    }


    //保存
    function onSave (id) {
        id = id || 0;
        var title = "添加车辆"
        if (id > 0){
            title = "编辑车辆"
        }
        layer.open ({
            type : 2,
            title : title,
            shadeClose : true,
            shade : 0.8,
            area : [
                '800', '530'
            ],
            content : 'car/edit?id=' + id //iframe的url
        });
    }
    //添加完成后执行方法
    function onSaveOk (entity) {
        $ ("#grid").trigger ("reloadGrid");
        layer.closeAll ();
    }
    //删除
    function onDel (id) {
        layer.confirm ('确定要删除车辆？', {
            btn : [
                '确定', '取消'
            ]
            //按钮
        }, function () {
            $.post ("car/del", {
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
			&nbsp;&nbsp;
			<button class="btn btn-info" id="btnAdd" type="button"
					onclick="onSave()">新建车辆</button>
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
