<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<jsp:include page="/WEB-INF/views/include/head.jsp" />
<title>区域管理--列表</title>
<script type="text/javascript">
	var _Path = [
	    0
    ]
    var _TitlePath = [
	    "区域管理"
    ]
    $ (function () {
	    var ap = "${AreaPath}"
	    var atp = "${AreaTitlePath}"
	    if (ap != ""){
		    _Path = ap.split (".");
		    _TitlePath = atp.split (".");
		    onQ ();
	    }
	    loadGrid ();
    });
    function loadGrid () {
	    $ ("#grid").jqGrid (
	            {
	                url : "comm/area/list",
	                postData : {
		                nodeid : _Path[_Path.length - 1]
	                },
	                height : document.body.clientHeight - 130,
	                fitColumns : true,
	                rownumbers : true,
	                colModel : [
	                        {
	                            label : '类别',
	                            name : 'category',
	                            index : 'category',
	                            sortable : false,
	                            width : 100
	                        },
	                        {
	                            label : '名称',
	                            name : 'name',
	                            index : 'name',
	                            sortable : false,
	                            width : 80
	                        },
	                        {
	                            label : '代号',
	                            name : 'sym',
	                            index : 'sym',
	                            sortable : false,
	                            width : 80
	                        },
	                        {
	                            label : '邮编',
	                            name : 'zipcode',
	                            index : 'zipcode',
	                            sortable : false,
	                            width : 80
	                        },
	                        {
	                            label : '区号',
	                            name : 'areacode',
	                            index : 'areacode',
	                            sortable : false,
	                            width : 80
	                        },
	                        {
	                            label : '状态',
	                            name : 'isActive',
	                            index : 'isActive',
	                            width : 50,
	                            sortable : false,
	                            formatter : function (value, options, row) {
		                            return value == 1 ? '使用中' : '<span style="color:gray;">已停用</span>'
	                            }
	                        },
	                        {
	                            label : ' ',
	                            name : 'id',
	                            width : 200,
	                            align : 'center',
	                            sortable : false,
	                            formatter : function (value, options, row) {
		                            var btn = "";
		                            btn += '&nbsp;<a href="javascript:onNext(' + row.id + ',\'' + row.name
		                                    + '\')" title="">进入下级</a>&nbsp;'
		                            btn += '&nbsp;<a href="javascript:onPre()" title="">返回上级</a>&nbsp;'
		                            btn += '&nbsp;<a href="javascript:onSort(' + value + ',\'up\',\''
		                                    + row.baseTree.path + '\')" title="">上移</a>'
		                            btn += '&nbsp;<a href="javascript:onSort(' + value + ',\'down\',\''
		                                    + row.baseTree.path + '\')" title="">下移</a>'
		                            btn += '&nbsp;<a href="javascript:onSave(' + value + ')" title="">编辑</a>'
		                            btn += '&nbsp;<a href="javascript:onDel(' + value + ')" title="">删除</a>&nbsp;'
		                            return btn;
	                            }
	                        }
	                ],
	                rowNum : 50,
	                rowList : [
	                        50, 100, 200
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
	        },
	        "onLeftKey" : function (rowid) {
	        },
	        "onSpace" : function (rowid) {
	        }
	    });
    }
    
    //编辑方法
    function onSave (id) {
	    id = id || 0;
	    var title = "编辑区域信息"
	    layer.open ({
	        type : 2,
	        title : title,
	        shadeClose : true,
	        shade : 0.8,
	        area : [
	                '800', '420'
	        ],
	        content : 'comm/area/edit?id=' + id + "&parentId=" + _Path[_Path.length - 1]//iframe的url;
	    });
    }
    //编辑完成后执行的方法
    function onSaveOk () {
	    $ ("#grid").trigger ("reloadGrid");
	    layer.closeAll ();
    }
    //删除方法
    function onDel (id) {
	    layer.confirm ('确定要删除？', {
		    btn : [
		            '确定', '取消'
		    ]
	    //按钮
	    }, function () {
		    $.post ("comm/area/del", {
			    id : id
		    }, function () {
			    $ ("#grid").trigger ("reloadGrid");
		    });
		    layer.closeAll ();
	    });
    }
    //排序
    function onSort (id, order, path) {
	    $.post ("comm/area/sort", {
	        id : id,
	        order : order
	    }, function () {
		    $ ("#grid").trigger ("reloadGrid");
	    });
    }
    function onNext (id, title) {
	    var idx = -1;
	    for (var i = 0; i < _Path.length; i++){
		    if (_Path[i] == id){
			    idx = i;
			    break;
		    }
	    }
	    if (idx >= 0){
		    _Path = _Path.slice (0, idx + 1);
		    _TitlePath = _TitlePath.slice (0, idx + 1);
	    }
	    else{
		    _Path.push (id)
		    _TitlePath.push (title)
	    }
	    onQ ();
    }
    function onPre () {
	    if (_Path.length == 1){
		    return;
	    }
	    _Path.pop ();
	    _TitlePath.pop ();
	    onQ ();
    }
    //查询
    function onQ () {
	    var para = {
	        name : $ ("#name").val (),
	        sym : $ ("#sym").val (),
	        nodeid : _Path[_Path.length - 1],
	    };
	    $ ("#grid").jqGrid ("setGridParam", {
	        page : 0,
	        postData : para
	    }).trigger ("reloadGrid");
	    genNav ();
    }
    function showAll () {
	    $ ("#category").val ("");
	    $ ("#name").val ("")
	    onQ (0);
	    $ ('#ifrmOrg').attr ('src', $ ('#ifrmOrg').attr ('src'));
    }
    //生成导航条
    function genNav () {
	    var s = '<li><a href="home/dashboard"><i class="fa fa-dashboard"></i>首页</a></li>';
	    for (var i = 0; i < _Path.length; i++){
		    if (i == _Path.length - 1){
			    s += '<li onclick=\'onNext("' + _Path[i] + '","' + _TitlePath[i] + '")\' class="active">'
			            + _TitlePath[i] + '</li>'
		    }
		    else{
			    s += '<li onclick=\'onNext("' + _Path[i] + '","' + _TitlePath[i] + '")\' >' + _TitlePath[i] + '</li>'
		    }
	    }
	    $ ("#nav").html (s);
    }
    function onTreeView () {
	    document.location.href = "indexTree";
    }
    $ (function () {
	    genNav ();
    })
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
				<label for="sym">代码</label> <input class="form-control input-sm"
					id="sym" value="" type="text" />
			</div>
			<div class="form-group">
				<button class="btn btn-info" id="btnAdd" type="button"
					onclick="onQ()">查询</button>
			</div>
			<div class="form-group">
				<button class="btn btn-info" id="btnShowAll" type="button"
					onclick="showAll()">显示全部</button>
				&nbsp;&nbsp;
				<button class="btn btn-info" id="btnAdd" type="button"
					onclick="onSave()">添加</button>
				&nbsp;&nbsp;
				<button class="btn btn-info" id="btnView" type="button"
					onclick="onTreeView()">树状浏览</button>
			</div>
			<ol class="breadcrumb" id="nav">

			</ol>
		</div>
		<table id="grid"></table>
		<div id="pager" style="height:35px;"></div>
	</div>
</body>
</html>
