<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <title>组织机构--列表</title>
    <jsp:include page="/WEB-INF/views/include/head4.jsp" />
    <script>
        //tree
        var _expandPath = "";
        //生成表格
        function loadGrid () {

            $ ("#grid").jqGrid ({
                url : "car/listInfo",
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
                        label : '总费用',
                        name : 'total',
                        index : 'total',
                        sortable : false,
                        width : 80
                    },  {
                        label : '保养修理费用',
                        name : 'baoyangfeiyong',
                        index : 'baoyangfeiyong',
                        sortable : false,
                        width : 120
                    },
                    {
                        label : '其他费用',
                        name : 'qitafeiyong',
                        index : 'qitafeiyong',
                        sortable : false,
                        width : 120
                    },{
                        label : '送保时间',
                        name : 'starttime',
                        index : 'starttime',
                        sortable : false,
                        width : 120,
                        formatter : function (value, options, row) {
                            return jsonDateTimeFormatter (value, 2);
                        }
                    },{
                        label : '完成时间',
                        name : 'finishtime',
                        index : 'finishtime',
                        sortable : false,
                        width : 120,
                        formatter : function (value, options, row) {
                            return jsonDateTimeFormatter (value, 2);
                        }
                    }, {
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
        //保存
        function onSave (id) {
            id = id || 0;
            var title = "添加维修保养信息"
            if (id > 0){
                title = "编辑维修保养信息"
            }
            layer.open ({
                type : 2,
                title : title,
                shadeClose : true,
                shade : 0.8,
                area : [
                    '800', '530'
                ],
                content : 'car/addInfo?id=' + id //iframe的url
            });
        }
        //添加完成后执行方法
        function onSaveOk (entity) {
            $ ("#grid").trigger ("reloadGrid");
            layer.closeAll ();
        }
        //删除
        function onDel (id) {
            layer.confirm ('确定要删除维修保养信息？', {
                btn : [
                    '确定', '取消'
                ]
                //按钮
            }, function () {
                $.post ("car/delInfo", {
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
