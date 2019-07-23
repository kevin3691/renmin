<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib
	uri="http://www.owasp.org/index.php/Category:OWASP_CSRFGuard_Project/Owasp.CsrfGuard.tld"
	prefix="csrf"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<title>${WorkplateTitle}</title>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8">

<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	//String basePath = path + "/";
	
%>
<base id="basePath" href="<%=basePath%>">
<script type="text/javascript">
    var _BasePath = "<%=basePath%>";
</script>
<script type="text/javascript" charset="utf-8"
	src="jslib/jquery-1.12.4.min.js"></script>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
<meta http-equiv="X-FRAME-OPTIONS" content="DENY">
<meta http-equiv="X-Content-Type-Options" content="nosniff">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="shortcut icon" href="<%=basePath%>images/favicon.ico">
<!--[if lt IE 9]>
      <script src="//cdn.bootcss.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="//cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
<link href="css/master.css" rel="stylesheet" type="text/css">
	<jsp:include page="/WEB-INF/views/include/head4.jsp" />
</head>
<script type="text/javascript">
    //初始化
    $(function () {
        loadGrid();
    })
    //加载表格
    function loadGrid() {
        $("#grid").jqGrid({
            url: "worklog/list",
            postData:{
                category:'LINGDAO'
            },
            colModel: [
                {
                    label: '开始日期',
                    name: 'startdatei',
                    index: 'startdatei'
                }, {
                    label: '结束日期',
                    name: 'finishdatei',
                    index: 'finishdatei'
                }, {
                    label: '标题',
                    name: 'titlei',
                    index: 'titlei'
                }, {
                    label: '内容',
                    name: 'contenti',
                    index: 'contenti'
                }, {
                    label: ' ',
                    name: 'id',
                    align: 'center',
                    sortable: false,
                    formatter: function (value, options, row) {
                        var btn = "";
                        btn += '&nbsp;<a href="javascript:onSave(' + value + ')" title="">编辑</a>'
                        btn += '&nbsp;<a href="javascript:onDel(' + value + ')" title="">删除</a>'
                        return btn;
                    }
                }
            ],
            rowNum: 20,
            rowList: [
                20, 50, 100
            ],
            pager: '#pager',
            sortname: 'id',
            sortorder: "asc"
        });
    }
    //保存
    function onSave (id) {

        id = id || 0;
        var title = "添加工作日志"
        if (id > 0){
            title = "编辑工作日志"
        }
        layer.open ({
            type : 2,
            title : title,
            shadeClose : true,
            shade : 0.8,
            area : [
                '90%', '90%'
            ],
            content : 'worklog/edit?id=' + id //iframe的url
        });
    }
    function onDel(id) {
        layer.confirm ('确定要删除该记录？', {
            btn : [
                '确定', '取消'
            ]
            //按钮
        }, function () {
            $.post ("worklog/del", {
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
            titlei : $ ("#titlei").val (),
        };
        $ ("#grid").jqGrid ("setGridParam", {
            postData : para
        }).trigger ("reloadGrid");
    }
    //显示全部
    function showAll () {
        $ ("#titlei").val ("");
        onQ ();
    }
</script>
<body>

<div class="container-fluid">
	<div class="breadcrumb content-header form-inline"
		 style="padding:8px;">
		<div class="form-group">
			<label>标题</label>
			<input class="form-control input-sm" id="titlei" value="" type="text" />
		</div>
		<div class="form-group">
			<button class="btn btn-info" id="" type="button"
					onclick="onQ()">查询</button>
		</div>
		<div class="form-group">
			<button class="btn btn-info" id="" type="button"
					onclick="showAll()">显示全部</button>
			&nbsp;&nbsp;
			<button class="btn btn-info" id="btnAdd" type="button"
					onclick="onSave()">添加</button>
		</div>
	</div>

	<div id="pager" style="height:35px;"></div>
</div>

<table id="grid"></table>
</body>
</html>
