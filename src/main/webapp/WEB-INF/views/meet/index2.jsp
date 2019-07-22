<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>固定资产--列表</title>
<jsp:include page="/WEB-INF/views/include/head4.jsp" />
<script>

    var _ORGID = 0;
    var _ORGNAME = "";
    var _ORGNUM = 0;

	//装载表格
    function loadGrid () {
	    $ ("#grid").jqGrid ({
	        url : "meet/list",
			postData:{
	          category:'JIEDAI'
			},
	        height : document.body.clientHeight - 130,
	        rownumbers : true,
	        colModel : [
                {
                    label : '接待事项',
                    name : 'title',
                    index : 'title',
                    width : 120
                }, {
                    label : '接待类型',
                    name : 'type',
                    index : 'type',
                    width : 120
                }, {
                    label : '申请部门',
                    name : 'org',
                    index : 'org',
                    width : 120
                } , {
                    label : '开始时间',
                    name : 'starttime',
                    sortable : false,
                    align : 'center',
                    width : 130,
                    formatter : function (value, options, row) {
                        return jsonDateTimeFormatter (value, 1);
                    }
                } , {
                    label : '结束时间',
                    name : 'finishtime',
                    sortable : false,
                    align : 'center',
                    width : 130,
                    formatter : function (value, options, row) {
                        return jsonDateTimeFormatter (value, 1);
                    }
                },{
	                    label : ' ',
	                    name : 'id',
	                    width : 120,
	                    align : 'center',
	                    sortable : false,
	                    formatter : function (value, options, row) {
		                    var btn = "";
		                    btn += '&nbsp;<a href="javascript:onSave(' + row.typeId + ','  + value + ')" title="">编辑</a>'
		                    btn += '&nbsp;<a href="javascript:onDel(' + value + ')" title="">删除</a>&nbsp;'
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
    function onSave (orgid,id) {

	    id = id || 0;
	    var title = "添加接待"
	    if (id > 0){
		    title = "编辑接待"
	    }
	    layer.open ({
	        type : 2,
	        title : title,
	        shadeClose : true,
	        shade : 0.8,
	        area : [
	                '90%', '90%'
	        ],
	        content : 'meet/edit2?id=' + id + '&goodTypeId=' + _ORGID + "&colSym=JIEDAI"//iframe的url
	    });
    }
    //添加完成后执行方法
    function onSaveOk (entity) {
	    $ ("#grid").trigger ("reloadGrid");
	    layer.closeAll ();
    }


    //添加完成后执行方法
    function onOrgSaveOk (entity) {
        document.getElementById('ifrmOrg').contentWindow.location.reload(true);
        //$ ("#grid").trigger ("reload");
        layer.closeAll()
    }

    //删除
    function onDel (id) {
	    layer.confirm ('确定要删除接待？', {
		    btn : [
		            '确定', '取消'
		    ]
	    //按钮
	    }, function () {
		    $.post ("meet/del", {
			    id : id
		    }, function () {
			    $ ("#grid").trigger ("reloadGrid");
		    });
		    layer.closeAll ();
	    });
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
            content : 'meettype/edit?parentId=' + id //iframe的url
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
            $.post ("meettype/del", {
                id : id
            }, function () {
                document.getElementById('ifrmOrg').contentWindow.location.reload(true);
                //document.getElementById('ifrmQdb').src=src;
            });
            layer.closeAll ();
        });
    }



    //排序
    function onSort (id, order) {
	    $.post ("meet/sort", {
	        id : id,
	        order : order
	    }, function () {
		    $ ("#grid").trigger ("reloadGrid");
	    });
    }
    //Iframe中点击ORG时获取ORGID，查询该机构下的人员
    function onOrgNodeClick (node) {
        _ORGID = node.id;
        _ORGNAME = node.name;
        _ORGNUM = node.docCount;
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
				<label for="name">名称</label> <input class="form-control input-sm"
					id="name" value="" type="text" />
			</div>
			<div class="form-group">
				<label for="sn">编号</label> <input class="form-control input-sm"
					id="sn" value="" type="text" />
			</div>
			<div class="form-group">
				<button class="btn btn-info"  type="button"
					onclick="onQ()">查询</button>
			</div>
			<div class="form-group">
				<button class="btn btn-info" type="button"
					onclick="showAll()">显示全部</button>
				&nbsp;&nbsp;
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
