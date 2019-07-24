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
	        url : "goods/list",
			postData:{
	          category:'GDZC'
			},
	        height : document.body.clientHeight - 130,
	        rownumbers : true,
	        colModel : [
                {
                    label : '名称',
                    name : 'name',
                    index : 'name',
                    width : 120
                }, {
                    label : '规格型号',
                    name : 'spec',
                    index : 'spec',
                    width : 120
                }, {
                    label : '编号',
                    name : 'sn',
                    index : 'sn',
                    width : 120
                }, {
                    label : '状态',
                    name : 'status',
                    index : 'status',
                    width : 120
                }, {
                    label : '价格',
                    name : 'price',
                    index : 'price',
                    width : 120
                },{
                    label : '领用人',
                    name : 'keeper',
                    index : 'keeper',
                    width : 120
                }, {
                    label : '领用人部门',
                    name : 'org',
                    index : 'org',
                    width : 120
                }, {
                    label : '使用地点',
                    name : 'location',
                    index : 'location',
                    width : 120
                } ,{
	                    label : ' ',
	                    name : 'id',
	                    width : 120,
	                    align : 'center',
	                    sortable : false,
	                    formatter : function (value, options, row) {
		                    var btn = "";
							btn += '&nbsp;<a href="javascript:onPrint('  + value + ')" title="">打印</a>'
		                    btn += '&nbsp;<a href="javascript:onSave('  + value + ')" title="">编辑</a>'
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
    function onSave (id) {
        /*if(_ORGID <= 0){
            alert("请选择固定资产分类！");
            return;
        }*/
	    id = id || 0;
	    var title = "添加固定资产"
	    if (id > 0){
		    title = "编辑固定资产"
	    }
	    layer.open ({
	        type : 2,
	        title : title,
	        shadeClose : true,
	        shade : 0.8,
	        area : [
	                '90%', '90%'
	        ],
	        content : 'goods/edit?id=' + id + '&goodTypeId=' + _ORGID + "&colSym=GDZC"//iframe的url
	    });
    }
	//打印
	function onPrint (id) {
		/*if(_ORGID <= 0){
            alert("请选择固定资产分类！");
            return;
        }*/
		id = id;
		var title = "打印固定资产标签"
		layer.open ({
			type : 2,
			title : title,
			shadeClose : true,
			shade : 0.8,
			area : [
				'50%', '50%'
			],
			content : 'goods/print?id=' + id + '&goodTypeId=' + _ORGID + "&colSym=GDZC"//iframe的url
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
	    layer.confirm ('确定要删除固定资产？', {
		    btn : [
		            '确定', '取消'
		    ]
	    //按钮
	    }, function () {
		    $.post ("goods/del", {
			    id : id
		    }, function () {
			    $ ("#grid").trigger ("reloadGrid");
		    });
		    layer.closeAll ();
	    });
    }

    function onOrgNew(parentId,id){
		id = id || 0;
		parentId = parentId || 0;
        var title = "新建分类"
		if(id > 0)
		{
			title = "编辑分类"
		}
        layer.open ({
            type : 2,
            title : title,
            shadeClose : true,
            shade : 0.8,
            area : [
                '600', '200'
            ],
            content : 'goodstype/edit?parentId=' + parentId + '&id=' + id //iframe的url
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
            $.post ("goodstype/del", {
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
	    $.post ("goods/sort", {
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
    function onQ (orgid) {
	    var para = {
	        typeId : orgid,
	        name : $ ("#name").val (),
            sn : $ ("#sn").val ()
	    };
	    $ ("#grid").jqGrid ("setGridParam", {
	        page : 0,
	        postData : para
	    }).trigger ("reloadGrid");
    }
    //显示全部
    function showAll () {
	    $ ("#name").val ("");
	    $ ("#sn").val ("")
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
			<div class="col-sm-2 no-padding" style="">
				<div class="nav-tabs-custom">
					<!-- Tabs within a box -->
					<ul class="nav nav-tabs pull-right ui-sortable-handle">
						<li class="pull-left header"
							style="padding-left:20px;font-size:14px;"><i class="fa fa-bank"></i> <b> 类别 <b></li>
						<li class="pull-right header">
							<button class="btn btn-info"  type="button" onclick="javascript:onOrgNew(_ORGID,0)">新建分类</button>
							<button class="btn btn-danger"  type="button" onclick="javascript:onOrgNew(0,_ORGID)">编辑</button>
							<button class="btn btn-danger"  type="button" onclick="javascript:onOrgDel(_ORGID,_ORGNUM)">删除</button>
						</li>
					</ul>
					<div class="tab-content no-padding">
						<iframe id="ifrmOrg"
							style="width: 100%; height: 300px;" frameborder="0"
							src="goodstype/list4"></iframe>
					</div>
				</div>
			</div>
			<div class="col-sm-10">
				<table id="grid"></table>
				<div id="pager" style="height:35px;"></div>
			</div>
		</div>

	</div>
</body>
</html>
