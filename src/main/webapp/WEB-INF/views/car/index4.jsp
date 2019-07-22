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
            url : "car/listUse",
            height : document.body.clientHeight - 130,
            rownumbers : true,
            colModel : [
                {
                    label : '申请人',
                    name : 'sqr',
                    index : 'sqr',
                    sortable : false,
                    width : 120
                },  {
                    label : '申请部门',
                    name : 'org',
                    index : 'org',
                    sortable : false,
                    width : 80
                },  {
                    label : '车牌号',
                    name : 'cardNo',
                    index : 'cardNo',
                    sortable : false,
                    width : 120
                },
                {
                    label: '乘车人数',
                    name: 'chengcherenshu',
                    index: 'chengcherenshu',
                    sortable: false,
                    width: 120
                } ,
                {
                    label : '出车日期',
                    name : 'chucheriqi',
                    index : 'chucheriqi',
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





    function onSave (id) {
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
        var title = "添加车辆使用申请"
        if (id > 0){
            title = "编辑车辆使用申请"
        }
        layer.open ({
            type : 2,
            title : title,
            shadeClose : true,
            shade : 0.8,
            area : [
                '800', '530'
            ],
            content : 'car/use?id=' + id //iframe的url
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
            $.post ("car/delUse", {
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

        };
        $ ("#grid").jqGrid ("setGridParam", {
            page : 0,
            postData : para
        }).trigger ("reloadGrid");
    }
    //显示全部
    function showAll () {
        $ ("#cardNo").val ("");

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
			<button class="btn btn-info" type="button"
					onclick="onQ()">查询</button>
		</div>
		<div class="form-group">
			<button class="btn btn-info" id="btnShowAll" type="button"
					onclick="showAll()">显示全部</button>
			&nbsp;&nbsp;
			<button class="btn btn-info" id="btnAdd" type="button"
					onclick="onSave()">新建</button>
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
