<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>新闻 - 列表</title>
<jsp:include page="/WEB-INF/views/include/head.jsp" />
<script>
	//装载表格
    function loadGrid () {
	    $ ("#grid").jqGrid (
	            {
	                url : "cms/news/list?colSym=${colSym}",
	                height : document.body.clientHeight - 130,
	                rownumbers : true,
	                colModel : [
	                        {
	                            label : '标题',
	                            name : 'title',
	                            index : 'title',
	                            width : 230
	                        },
	                        {
	                            label : '更新时间',
	                            name : 'recordInfo.updatedAt',
	                            index : 'recordInfo.updatedAt',
	                            width : 100,
	                            formatter : function (v) {
		                            return jsonDateTimeFormatter (v, 1)
	                            }
	                        },
	                        {
	                            label : '发布人',
	                            name : 'recordInfo.createdByName',
	                            index : 'recordInfo.createdByName',
	                            width : 70
	                        },
	                        {
	                            label : '图片地址',
	                            name : 'img',
	                            index : 'img',
	                            hidden : true
	                        },
	                        {
	                            label : 'id',
	                            name : 'id',
	                            index : 'id',
	                            hidden : true
	                        },
	                        {
	                            label : ' ',
	                            name : '',
	                            align : 'center',
	                            sortable : false,
	                            width : 100,
	                            formatter : function (value, options, row) {
		                            var btn = "";
		                            btn += '&nbsp;<a href="javascript:onPreview(' + row.id + ')" title="">预览</a>'
		                            btn += '&nbsp;<a href="javascript:onSave(' + row.id + ')" title="">编辑</a>'
		                            btn += '&nbsp;<a href="javascript:onDel(' + row.id + ')" title="">删除</a>'
		                            btn += '&nbsp;<a href="javascript:onSort(' + row.id + ',\'' + row.colSym
		                                    + '\',\'up\')" title="">上移</a>'
		                            btn += '&nbsp;<a href="javascript:onSort(' + row.id + ',\'' + row.colSym
		                                    + '\',\'down\')" title="">下移</a>&nbsp;'
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
    }
    //执行添加方法
    function onSave (id) {
	    id = id || 0;
	    document.location = _BasePath + 'cms/banner/edit?id=' + id + "&colSym=${colSym}&colTitle="
	            + encodeURI ("${colTitle}");
    }
    //删除方法
    function onDel (id) {
	    layer.confirm ('确定要删除该记录？', {
		    btn : [
		            '确定', '取消'
		    ]
	    //按钮
	    }, function () {
		    $.post ("cms/news/del", {
			    id : id
		    }, function () {
			    $ ("#grid").trigger ("reloadGrid");
		    });
		    layer.closeAll ();
	    });
    }
    //添加成功后执行的方法
    function onSaveOk (entity) {
	    $ ("#grid").trigger ("reloadGrid");
	    layer.closeAll ();
    }
    //排序
    function onSort (id, colSym, order) {
	    $.post ("cms/banner/sort", {
	        id : id,
	        colSym : colSym,
	        order : order
	    }, function (rest) {
		    $ ("#grid").trigger ("reloadGrid");
	    });
    }
    //图片预览
    function onPreview (v) {
	    var json = {
	        "title" : "${colSym}", //相册标题
	        "id" : 0, //相册id
	        "start" : 0, //初始显示的图片序号，默认0
	        "data" : [ //相册包含的图片，数组格式
	        //{
	        //  "alt" : "图片名",
	        // "pid" : 666, //图片id
	        // "src" : "", //原图地址
	        // "thumb" : "" //缩略图地址
	        //}
	        ]
	    }
	    var rows = $ ("#grid").jqGrid ("getRowData");
	    $.each (rows, function (i, row) {
		    if (this.id == v){
			    json.start = i;
		    }
		    json.data.push ({
		        alt : this.title,
		        pid : 0,
		        src : this.img,
		        thumb : ""
		    })
	    })
	    layer.photos ({
		    photos : json
	    });
    }
    //查询
    function onQ () {
	    var para = {
	        title : $ ("#title").val (),
	        content : $ ("#content").val ()
	    };
	    $ ("#grid").jqGrid ("setGridParam", {
		    postData : para
	    }).trigger ("reloadGrid");
    }
    //显示全部
    function showAll () {
	    $ ("#title").val ("");
	    onQ ();
    }
    //初始化
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
				<label for="title">标题</label> <input class="form-control input-sm"
					id="title" value="" type="text" maxLength=50 /> <label
					for="content">说明</label> <input class="form-control input-sm"
					id="content" value="" type="text" maxLength=50 />
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
				<button class="btn btn-info" id="btnShowAll" type="button"
					onclick="onSave()">添加</button>
			</div>
			<ol class="pull-right breadcrumb">
				<li><a href="home/dashboard"><i class="fa fa-dashboard"></i>
						首页</a></li>
				<li class="active">${colTitle}</li>
			</ol>
		</div>
		<table id="grid"></table>
		<div id="pager" style="height:35px;"></div>
	</div>
</body>
</html>
