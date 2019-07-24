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
	                url : "comm/news/list",
	                height : document.body.clientHeight - 130,
	                postData : {
	                    template : "新闻列表,视频新闻",
	                    stts : "待审核"
	                },
	                rownumbers : true,
	                colModel : [
	                        {
	                            label : '栏目',
	                            name : 'colTitle',
	                            index : 'colTitle',
	                            width : 100
	                        },
	                        {
	                            label : '标题',
	                            name : 'title',
	                            index : 'title',
	                            width : 260
	                        },
	                        {
	                            label : '发布时间',
	                            name : 'publishAt',
	                            index : 'publishAt',
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
	                            label : '状态',
	                            name : 'stts',
	                            index : 'stts',
	                            width : 60
	                        },
	                        {
	                            label : ' ',
	                            name : 'id',
	                            align : 'center',
	                            sortable : false,
	                            width : 100,
	                            formatter : function (value, options, row) {
		                            var btn = "";
		                            //btn += '&nbsp;<a href="javascript:onSee(' + value + ')" title="">查看</a>'
		                            btn += '&nbsp;<a href="javascript:onEdit(' + value + ',\'' + row.template
		                                    + '\')" title="">编辑</a>'
		                            if (row.stts == "已审核"){
			                            btn += '&nbsp;<a href="javascript:onAudit(' + value
			                                    + ',\'待审核\')" title="">取消审核</a>'
		                            }
		                            else{
			                            btn += '&nbsp;<a href="javascript:onAudit(' + value
			                                    + ',\'已审核\')" title="">审核</a>'
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
	                sortname : 'top',
	                sortorder : "desc"
	            });
    }
    //查看
    function onSee (id) {
	    window.top.layer.open ({
	        type : 2,
	        title : "查看详细",
	        shadeClose : true,
	        shade : 0.8,
	        area : [
	                '90%', '90%'
	        ],
	        content : _BasePath + "comm/news/dtl?id=" + id
	    });
    }
    //编辑
    function onEdit (id,template) {
	    var returnUrl = "comm/news/audit";
	    var url = "comm/news/edit";
	    if (template&&template == "视频新闻"){
		    url = "comm/video/edit"
	    }
	    window.location.href = _BasePath + url + "?id=" + id + "&colSym=${colSym}&colTitle="
	            + encodeURI ("${colTitle}") + "&returnUrl=" + returnUrl;
    }
    //审核
    function onAudit (id, stts) {
	    layer.confirm ('确定要审核通过该记录？', {
		    btn : [
		            '确定', '取消'
		    ]
	    //按钮
	    }, function (result) {
		    $.post ("comm/news/update", {
		        id : id,
		        stts : stts
		    }, function (result) {
			    onQ ();
		    })
		    layer.closeAll ();
	    });
    }
    //查询
    function onQ (id) {
	    var para = {
	        title : $ ("#title").val (),
	        keyword : $ ("#keyword").val (),
	        createdByName : $ ("#createdByName").val (),
	        stts : $ ("#stts").val ()
	    };
	    $ ("#grid").jqGrid ("setGridParam", {
		    postData : para
	    }).trigger ("reloadGrid");
    }
    //显示全部
    function showAll () {
	    $ ("#title").val ("");
	    $ ("#keyword").val ("");
	    $ ("#createdByName").val ("");
	    $ ("#stts").val ("");
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
					id="title" value="" type="text" /> <label for="keyword">关键字</label>
				<input class="form-control input-sm" id="keyword" value=""
					type="text" /> <label for="createdByName">发布人</label> <input
					class="form-control input-sm" id="createdByName" value=""
					type="text" /> <label for="stts">状态</label> <select id="stts"
					name="stts" style="width:100px;" class="form-control select2">
					<option value="">全部</option>
					<option value="待审核" selected>待审核</option>
					<option value="已审核">已审核</option>
				</select>
			</div>
			<div class="form-group">
				<button class="btn btn-info" id="btnAdd" type="button"
					onclick="onQ()">查询</button>
			</div>
			<div class="form-group">
				<button class="btn btn-info" id="btnShowAll" type="button"
					onclick="showAll()">显示全部</button>
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
